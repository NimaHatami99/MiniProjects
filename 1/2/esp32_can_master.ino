#include <SPI.h>
#include <mcp2515.h>

MCP2515 mcp2515(5);                 // CS pin
struct can_frame cmd, resp;

void setup() {
  Serial.begin(115200);
  SPI.begin();                      // HSPI default: 23-MOSI, 19-MISO, 18-SCK 

  mcp2515.reset();
  mcp2515.setBitrate(CAN_500KBPS, MCP_8MHZ);      // 500 kbit/s @ 8 MHz 
  mcp2515.setNormalMode();

  cmd.can_id  = 0x123;
  cmd.can_dlc = 3;
  cmd.data[0] = '1';
  cmd.data[1] = '2';
  cmd.data[2] = '3';
}

void loop() {
  /* 1 – send request */
  mcp2515.sendMessage(&cmd);                               
  Serial.println(F("TX → \"123\""));

  /* 2 – wait up to 500 ms for reply */
  unsigned long t0 = millis();
  bool got = false;
  while (millis() - t0 < 500) {
    if (mcp2515.readMessage(&resp) == MCP2515::ERROR_OK &&
        resp.can_id == 0x124 && resp.can_dlc == 2) {
      int16_t ti = (resp.data[0] << 8) | resp.data[1];
      Serial.print(F("RX ← "));
      Serial.print(ti / 100.0f);
      Serial.println(F(" °C"));
      got = true;
      break;
    }
  }
  if (!got) Serial.println(F("No reply"));
  delay(2000);
}
