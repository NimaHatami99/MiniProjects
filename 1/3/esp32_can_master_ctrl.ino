#include <WiFi.h>                    
#include <PubSubClient.h>            
#include <SPI.h>                     
#include <mcp2515.h>                 

/* ---------- user config ---------- */ 
#define WIFI_SSID   "huawei_9761"    
#define WIFI_PASS   "2651031148"     

#define MQTT_HOST   "broker.emqx.io" 
#define MQTT_PORT   1883             

/* ---------- topics ---------- */    
const char* TOP_TEMP      = "pi3_ctrl/temp";        
const char* TOP_LED       = "pi3_ctrl/led";         
const char* TOP_RELAY     = "pi3_ctrl/relay";       
const char* TOP_LED_SW    = "pi3_ctrl/led_switch";  
const char* TOP_RELAY_SW  = "pi3_ctrl/relay_switch";

/* ---------- CAN IDs ---------- */   
#define CAN_STAT_ID  0x210            // 11-bit CAN ID carrying status: temp_hi,temp_lo,LED,RELAY (4 data bytes)
#define CAN_CMD_ID   0x211            // 11-bit CAN ID used to send 2-byte command: LED,RELAY

/* ---------- MCP2515 ---------- */   
MCP2515 mcp2515(5);                   // Create MCP2515 object bound to SPI CS pin GPIO5

/* ---------- Wi-Fi / MQTT ---------- */ 
WiFiClient      wifi;                 // TCP client used by PubSubClient to talk to the MQTT broker
PubSubClient    mqtt(wifi);           // MQTT client bound to the WiFiClient transport

void pub(const char* topic, const char* payload, bool retain=false) // Publish payload to topic with optional retained flag
{                               
  mqtt.publish(topic, payload, retain); 
}                               

/* forward dashboard switch → CAN command */ 
void mqttCallback(char* topic, byte* payload, unsigned int len) // Called by PubSubClient when a subscribed message arrives
{                               
  if (len==0) return;           
  char val = payload[0];        // Read only the first byte ('0' or '1'); rest (if any) is ignored
  byte data[2] = { 0xFF, 0xFF };// Start with 0xFF sentinel = "no change" for [LED, RELAY]

  if (val!='0' && val!='1') return;       // Accept only ASCII '0' or '1' to avoid malformed commands
  if (!strcmp(topic, TOP_LED_SW))   data[0] = (val=='1');   // If the LED switch topic, set byte0 to 0/1
  if (!strcmp(topic, TOP_RELAY_SW)) data[1] = (val=='1');   // If the relay switch topic, set byte1 to 0/1

  struct can_frame cmd;           // Create a CAN frame structure for the outgoing command
  cmd.can_id  = CAN_CMD_ID;       
  cmd.can_dlc = 2;                
  cmd.data[0] = data[0];          
  cmd.data[1] = data[1];          
  mcp2515.sendMessage(&cmd);      
}                                 

/* reconnect Wi-Fi and MQTT if needed */ 
void ensureMQTT()                  
{                                 
  if (WiFi.status()!=WL_CONNECTED)        // If not connected to Wi-Fi
  {                                       
    WiFi.begin(WIFI_SSID, WIFI_PASS);     // Start (re)connecting to the configured Wi-Fi network
    while (WiFi.status()!=WL_CONNECTED) delay(500); // Busy-wait with 500 ms delay until Wi-Fi connects
  }                                       
  if (!mqtt.connected())                  // If MQTT client is not connected
  {                                       
    while (!mqtt.connected())             // Loop until connection succeeds
      mqtt.connect("esp32_can_master");   // Connect with a simple client ID (no auth; consider creds/TLS in prod)
    mqtt.subscribe(TOP_LED_SW);           
    mqtt.subscribe(TOP_RELAY_SW);         
  }                                       
}                                         

void setup()                        // Arduino setup: runs once at boot/reset
{                                   
  Serial.begin(115200);             

  /* Wi-Fi first */                 
  WiFi.begin(WIFI_SSID, WIFI_PASS); 
  while (WiFi.status()!=WL_CONNECTED) delay(500); // Block until Wi-Fi is connected

  /* MQTT */                        
  mqtt.setServer(MQTT_HOST, MQTT_PORT); 
  mqtt.setCallback(mqttCallback);   // Register the function that handles incoming subscribed messages

  /* SPI + MCP2515 */               
  SPI.begin(23, 19, 18, 5);         // SPI.begin(MOSI=23, MISO=19, SCK=18, CS=5) per ESP32 pinout used here
  mcp2515.reset();                  
  mcp2515.setBitrate(CAN_500KBPS, MCP_8MHZ); 
  mcp2515.setNormalMode();          // Enter normal mode to send/receive frames (not loopback or listen-only)
}                                   

void loop()                         
{                                   
  ensureMQTT();                     
  mqtt.loop();                      // Let PubSubClient process incoming/outgoing packets and keepalive pings

  /* read CAN frames (polling) */   // Poll the MCP2515 for available CAN frames and handle status messages
  struct can_frame rx;              // Buffer for a received CAN frame
  if (mcp2515.readMessage(&rx) == MCP2515::ERROR_OK && // If a frame was read successfully
      rx.can_id == CAN_STAT_ID && rx.can_dlc == 4)     // And it matches our status ID and has exactly 4 bytes
  {                                 
      int16_t ti = (rx.data[0] << 8) | rx.data[1]; 
      char buf[16];                 
      snprintf(buf,sizeof(buf),"%.2f",ti/100.0); 
      pub(TOP_TEMP , buf, false);            

      pub(TOP_LED  , rx.data[2]?"1":"0", true);  
      pub(TOP_RELAY, rx.data[3]?"1":"0", true);  
  }                                 
}                                   

