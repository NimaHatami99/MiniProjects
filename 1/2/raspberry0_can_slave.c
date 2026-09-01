#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <wiringPi.h>
#include <wiringPiI2C.h>
#include <net/if.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <linux/can.h>
#include <linux/can/raw.h>

#define LM75_ADDR   0x48
#define CMD_ID      0x123      /* “123” command from ESP32  */
#define RESP_ID     0x124      /* Pi → ESP32 temperature ID */

static float read_lm75(int fd)
{
    int raw = wiringPiI2CReadReg16(fd, 0x00);     /* reg 0x00 = temperature */ /* big-endian */ 
    raw = (raw >> 8) | ((raw & 0xFF) << 8);       /* swap bytes */
    int temp9 = raw >> 5;                         /* drop unused bits */
    return temp9 * 0.125f;                        /* °C */              
}

int main(void)
{
    /* ---------- I²C / LM75 ---------- */
    wiringPiSetup();                                                   
    int lm75fd = wiringPiI2CSetup(LM75_ADDR);
    if (lm75fd < 0) { perror("LM75"); return EXIT_FAILURE; }

    /* ---------- CAN socket ---------- */
    int s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
    if (s < 0) { perror("socket"); return EXIT_FAILURE; }

    struct ifreq ifr;
    strcpy(ifr.ifr_name, "can0");
    if (ioctl(s, SIOCGIFINDEX, &ifr) < 0) { perror("SIOCGIFINDEX"); return EXIT_FAILURE; }

    struct sockaddr_can addr = { .can_family = AF_CAN, .can_ifindex = ifr.ifr_ifindex };
    if (bind(s, (struct sockaddr*)&addr, sizeof(addr)) < 0) { perror("bind"); return EXIT_FAILURE; }

    printf("Pi-LM75 slave ready on can0\n");

    /* ---------- main loop ---------- */
    struct can_frame rx, tx;
    for (;;)
    {
        if (recv(s, &rx, sizeof(rx), 0) < 0) { perror("recv"); break; }

        if (rx.can_id == CMD_ID && rx.can_dlc == 3 &&
            rx.data[0] == '1' && rx.data[1] == '2' && rx.data[2] == '3')
        {
            float t = read_lm75(lm75fd);
            int16_t ti = (int16_t)(t * 100.0f);

            tx.can_id  = RESP_ID;
            tx.can_dlc = 2;
            tx.data[0] = (ti >> 8) & 0xFF;            /* MSB first */
            tx.data[1] =  ti & 0xFF;

            sendto(s, &tx, sizeof(tx), 0, (struct sockaddr*)&addr, sizeof(addr));
            printf("Sent %.2f °C\n", t);
        }
    }
    close(s);
    return EXIT_SUCCESS;
}
