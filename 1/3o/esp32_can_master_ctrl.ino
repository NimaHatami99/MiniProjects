#include <WiFi.h>
#include <PubSubClient.h>
#include <SPI.h>
#include <mcp2515.h>

/* ---------- user config ---------- */
#define WIFI_SSID   "huawei_9761"
#define WIFI_PASS   "2651031148"

#define MQTT_HOST   "test.mosquitto.org"
#define MQTT_PORT   1883

/* ---------- topics ---------- */
const char* TOP_TEMP      = "pi3_ctrl/temp";
const char* TOP_LED       = "pi3_ctrl/led";
const char* TOP_RELAY     = "pi3_ctrl/relay";
const char* TOP_LED_SW    = "pi3_ctrl/led_switch";
const char* TOP_RELAY_SW  = "pi3_ctrl/relay_switch";

/* ---------- CAN IDs ---------- */
#define CAN_STAT_ID  0x210
#define CAN_CMD_ID   0x211

/* ---------- MCP2515 ---------- */
MCP2515 mcp2515(5);        // CS = GPIO5
/* INT on GPIO16 – not used for ISR here, but wiring it allows future interrupts */

/* ---------- Wi-Fi / MQTT ---------- */
WiFiClient      wifi;
PubSubClient    mqtt(wifi);

/* publish helper (QoS 0, retained = true for led/relay, false for temp) */
void pub(const char* topic, const char* payload, bool retain=false)
{
  mqtt.publish(topic, payload, retain);
}

/* forward dashboard switch → CAN command */
void mqttCallback(char* topic, byte* payload, unsigned int len)
{
  if (len==0) return;
  char val = payload[0];
  byte data[2] = { 0xFF, 0xFF };

  if (val!='0' && val!='1') return;
  if (!strcmp(topic, TOP_LED_SW))   data[0] = (val=='1');
  if (!strcmp(topic, TOP_RELAY_SW)) data[1] = (val=='1');

  struct can_frame cmd;
  cmd.can_id  = CAN_CMD_ID;
  cmd.can_dlc = 2;
  cmd.data[0] = data[0];
  cmd.data[1] = data[1];
  mcp2515.sendMessage(&cmd);
}

/* reconnect Wi-Fi and MQTT if needed */
void ensureMQTT()
{
  if (WiFi.status()!=WL_CONNECTED)
  {
    WiFi.begin(WIFI_SSID, WIFI_PASS);
    while (WiFi.status()!=WL_CONNECTED) delay(500);
  }
  if (!mqtt.connected())
  {
    while (!mqtt.connected())
      mqtt.connect("esp32_can_master");
    mqtt.subscribe(TOP_LED_SW);
    mqtt.subscribe(TOP_RELAY_SW);
  }
}

void setup()
{
  Serial.begin(115200);

  /* Wi-Fi first */
  WiFi.begin(WIFI_SSID, WIFI_PASS);
  while (WiFi.status()!=WL_CONNECTED) delay(500);

  /* MQTT */
  mqtt.setServer(MQTT_HOST, MQTT_PORT);
  mqtt.setCallback(mqttCallback);

  /* SPI + MCP2515 */
  SPI.begin(23, 19, 18, 5);
  mcp2515.reset();
  mcp2515.setBitrate(CAN_500KBPS, MCP_8MHZ);
  mcp2515.setNormalMode();
}

void loop()
{
  ensureMQTT();
  mqtt.loop();                       // process in-flight packets

  /* read CAN frames (polling) */
  struct can_frame rx;
  if (mcp2515.readMessage(&rx) == MCP2515::ERROR_OK &&
      rx.can_id == CAN_STAT_ID && rx.can_dlc == 4)
  {
      int16_t ti = (rx.data[0] << 8) | rx.data[1];
      char buf[16];
      snprintf(buf,sizeof(buf),"%.2f",ti/100.0);
      pub(TOP_TEMP , buf, false);            // not retained

      pub(TOP_LED  , rx.data[2]?"1":"0", true);  // retained so widgets populate
      pub(TOP_RELAY, rx.data[3]?"1":"0", true);
  }
}
