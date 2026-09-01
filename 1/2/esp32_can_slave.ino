#include <Wire.h>
#include <SPI.h>
#include <mcp2515.h>

#define LM75_ADDR 0x48
#define CMD_ID    0x123
#define RESP_ID   0x124

MCP2515 mcp2515(5);          // CS pin
struct can_frame rx, tx;

float readLM75()
{
  Wire.beginTransmission(LM75_ADDR);
  Wire.write(0x00);                // temp register
  Wire.endTransmission(false);
  Wire.requestFrom(LM75_ADDR, 2);

  if (Wire.available() < 2) return NAN;
  uint16_t raw = (Wire.read() << 8) | Wire.read();             // big-endian
  int16_t temp9 = raw >> 5;                                    // 9-bit signed
  return temp9 * 0.125f;                                       // °C
}

void setup()
{
  Serial.begin(115200);
  Wire.begin();                                                // SDA21/SCL22
  SPI.begin();                                                 // 23/19/18  

  mcp2515.reset();
  mcp2515.setBitrate(CAN_500KBPS, MCP_8MHZ);                   // 500 kbit/s  
  mcp2515.setNormalMode();

  Serial.println(F("ESP32 LM75-CAN slave ready"));
}

void loop()
{
  if (mcp2515.readMessage(&rx) == MCP2515::ERROR_OK &&
      rx.can_id == CMD_ID && rx.can_dlc == 3 &&
      rx.data[0] == '1' && rx.data[1] == '2' && rx.data[2] == '3')
  {
    float t = readLM75();
    if (isnan(t)) { Serial.println(F("LM75 read error")); return; }

    int16_t ti = (int16_t)(t * 100.0f);

    tx.can_id  = RESP_ID;
    tx.can_dlc = 2;
    tx.data[0] = (ti >> 8) & 0xFF;
    tx.data[1] = ti & 0xFF;

    mcp2515.sendMessage(&tx);
    Serial.print(F("Sent ")); Serial.print(t); Serial.println(F(" °C"));
  }
}
