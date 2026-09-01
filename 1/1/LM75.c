#include <stdio.h>
#include <wiringPi.h>
#include <wiringPiI2C.h>

#define LM75_ADDR 0x48

int main() {
    int lm75;

    wiringPiSetup();
    lm75 = wiringPiI2CSetup(LM75_ADDR);

    while (1) {
        // Read temperature
        int rawTemp = wiringPiI2CReadReg16(lm75, 0x00);
        // Swap bytes to convert from big-endian to little-endian
        int temp = ((rawTemp & 0xFF) << 8) | ((rawTemp & 0xFF00) >> 8);
        // Convert the raw value to temperature (Celsius)
        float tempC = (temp >> 5) * 0.125;

        printf("Temperature: %.2f°C\n", tempC);

        delay(2000); // Delay for 2 seconds
    }

    return 0;
}
