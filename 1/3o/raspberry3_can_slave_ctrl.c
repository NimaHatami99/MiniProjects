#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <unistd.h>
#include <wiringPi.h>
#include <wiringPiI2C.h>
#include <net/if.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <linux/can.h>
#include <linux/can/raw.h>

#define LM75_ADDR 0x48
#define LED_PIN   0   /* wiringPi numbers: GPIO17 → 0  */
#define REL_PIN   2   /* GPIO27 → wiringPi 2          */

#define ID_STAT 0x210
#define ID_CMD  0x211
#define PERIOD_MS 5000

volatile int running = 1;
void sigint(int s){ running = 0; }

static float read_lm75(int fd)
{
    int raw = wiringPiI2CReadReg16(fd, 0x00);
    raw = (raw >> 8) | ((raw & 0xFF) << 8);          /* swap bytes */
    return (int16_t)(raw >> 5) * 0.125f;              /* 0.125 °C/LSB */
}

int main(void)
{
    signal(SIGINT, sigint);
    wiringPiSetup();

    pinMode(LED_PIN, OUTPUT);
    pinMode(REL_PIN, OUTPUT);

    int lm75 = wiringPiI2CSetup(LM75_ADDR);           

    /* open CAN */
    int s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
    struct ifreq ifr; strcpy(ifr.ifr_name, "can0");
    ioctl(s, SIOCGIFINDEX, &ifr);
    struct sockaddr_can addr = { .can_family = AF_CAN,
                                 .can_ifindex = ifr.ifr_ifindex };
    bind(s,(struct sockaddr*)&addr,sizeof(addr));

    struct can_frame tx = { .can_id = ID_STAT, .can_dlc = 4 };
    struct can_frame rx;
    uint32_t last = 0;

    while (running)
    {
        /* ---------- handle incoming command ---------- */
        struct timeval tv = { .tv_sec = 0, .tv_usec = 1000 };
        fd_set fds; FD_ZERO(&fds); FD_SET(s,&fds);
        if (select(s+1,&fds,NULL,NULL,&tv) > 0 &&
            read(s,&rx,sizeof(rx)) == sizeof(rx) &&
            rx.can_id == ID_CMD && rx.can_dlc == 2)
        {
            if (rx.data[0] != 0xFF) digitalWrite(LED_PIN , rx.data[0]);
            if (rx.data[1] != 0xFF) digitalWrite(REL_PIN , rx.data[1] ? LOW : HIGH);
            /* echo new status immediately */
            float t = read_lm75(lm75);
            int16_t ti = (int16_t)(t*100);
            tx.data[0]=ti>>8; tx.data[1]=ti&0xFF;
            tx.data[2]=digitalRead(LED_PIN);
            tx.data[3]=!digitalRead(REL_PIN);         /* active-LOW relay */
            write(s,&tx,sizeof(tx));
        }

        /* ---------- periodic status ---------- */
        if (millis() - last >= PERIOD_MS){
            last = millis();
            float t = read_lm75(lm75);
            int16_t ti = (int16_t)(t*100);
            tx.data[0]=ti>>8; tx.data[1]=ti&0xFF;
            tx.data[2]=digitalRead(LED_PIN);
            tx.data[3]=!digitalRead(REL_PIN);
            write(s,&tx,sizeof(tx));
        }
    }
    close(s);
    return 0;
}
