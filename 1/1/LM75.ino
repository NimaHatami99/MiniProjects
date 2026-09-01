#include <Wire.h>

#define LM75_ADDR 0x48      // A2-A1-A0 all high-Z ⇒ 0b1001000 = 0x48
#define READ_INTERVAL_MS 2000

float readLM75()
{
    Wire.beginTransmission(LM75_ADDR);
    Wire.write(0x00);               // Temperature register
    Wire.endTransmission(false);    // Send repeated-start
    if (Wire.requestFrom(LM75_ADDR, (uint8_t)2) != 2) {
        return NAN;                 // Sensor not responding
    }

    uint16_t raw = (Wire.read() << 8) | Wire.read();

    /*  LM75 returns:
     *      bit15..5 : signed 11-bit temperature (°C × 0.125)
     *      bit4..0  : don’t-care
     */
    return (int16_t)(raw >> 5) * 0.125f;
}

void setup()
{
    Serial.begin(115200);
    // Change SDA/SCL pins here if you used different GPIOs: Wire.begin(SDA_PIN, SCL_PIN);
    Wire.begin();                   // default SDA 21, SCL 22, 400 kHz
    Serial.println(F("LM75 temperature logger started…"));
}

void loop()
{
    static uint32_t lastRead = 0;
    uint32_t now = millis();

    if (now - lastRead >= READ_INTERVAL_MS) {
        lastRead = now;

        float tempC = readLM75();
        if (!isnan(tempC)) {
            Serial.printf("Temperature: %.3f °C\n", tempC);
        } else {
            Serial.println(F("LM75 read error – check wiring or address"));
        }
    }

    // Do other tasks here (Wi-Fi, BLE, etc.) without blocking.
}