#include <Wire.h>
#include <SPI.h>
#include <mcp2515.h>

#define LM75_ADDR 0x48
#define LED_PIN   32
#define RELAY_PIN 33

#define CAN_STAT_ID 0x210
#define CAN_CMD_ID  0x211
#define PERIOD_MS   5000

MCP2515 can(5);
struct can_frame tx, rx;
bool ledOn = false, relayOn = false;

float readLM75() {
  Wire.beginTransmission(LM75_ADDR);
  Wire.write(0x00); Wire.endTransmission(false);
  Wire.requestFrom(LM75_ADDR, 2);
  if (Wire.available() < 2) return NAN;
  uint16_t raw = (Wire.read() << 8) | Wire.read();
  return (int16_t)(raw >> 5) * 0.125f;
}
void applyIO() {
  digitalWrite(LED_PIN  , ledOn   ? HIGH : LOW);
  digitalWrite(RELAY_PIN, relayOn ? LOW  : HIGH);   // active-LOW
}
void sendStatus(float t) {
  int16_t ti = (int16_t)(t * 100.0f);
  tx.can_id  = CAN_STAT_ID;
  tx.can_dlc = 4;
  tx.data[0] = (ti >> 8) & 0xFF;
  tx.data[1] =  ti & 0xFF;
  tx.data[2] = ledOn   ? 1 : 0;
  tx.data[3] = relayOn ? 1 : 0;
  can.sendMessage(&tx);
}
void setup() {
  Serial.begin(115200);
  pinMode(LED_PIN, OUTPUT); pinMode(RELAY_PIN, OUTPUT);
  applyIO();
  Wire.begin();
  SPI.begin();
  can.reset(); can.setBitrate(CAN_500KBPS, MCP_8MHZ); can.setNormalMode();
  tx.can_id = CAN_STAT_ID; tx.can_dlc = 4;
}
void loop() {
  /* handle incoming commands */
  while (can.readMessage(&rx) == MCP2515::ERROR_OK) {
    if (rx.can_id == CAN_CMD_ID && rx.can_dlc == 2) {
      bool changed = false;
      if (rx.data[0] != 0xFF) { ledOn = rx.data[0]; changed = true; }
      if (rx.data[1] != 0xFF) { relayOn = rx.data[1]; changed = true; }
      if (changed) { applyIO(); sendStatus(readLM75()); }
    }
  }
  /* periodic status */
  static uint32_t last = 0;
  if (millis() - last >= PERIOD_MS) {
    last = millis(); sendStatus(readLM75());
  }
}
