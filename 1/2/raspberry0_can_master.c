#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <net/if.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <linux/can.h>
#include <linux/can/raw.h>

#define IFACE     "can0"
#define CMD_ID    0x123
#define RESP_ID   0x124

int main(void)
{
    int s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
    if (s < 0) { perror("socket"); return EXIT_FAILURE; }

    struct ifreq ifr;
    strcpy(ifr.ifr_name, IFACE);
    if (ioctl(s, SIOCGIFINDEX, &ifr) < 0) { perror("SIOCGIFINDEX"); return EXIT_FAILURE; }

    struct sockaddr_can addr = { .can_family = AF_CAN, .can_ifindex = ifr.ifr_ifindex };
    if (bind(s, (struct sockaddr*)&addr, sizeof(addr)) < 0) { perror("bind"); return EXIT_FAILURE; }

    /* timeout for recv */
    struct timeval tv = { .tv_sec = 1, .tv_usec = 0 };
    setsockopt(s, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));

    struct can_frame cmd = { .can_id = CMD_ID, .can_dlc = 3, .data = {'1','2','3'} };
    struct can_frame resp;

    puts("Pi-CAN master running (Ctrl-C to quit)");

    while (1) {
        /* 1 – send command */
        if (write(s, &cmd, sizeof(cmd)) != sizeof(cmd))
            perror("write");

        /* 2 – wait for reply */
        int n = read(s, &resp, sizeof(resp));
        if (n == sizeof(resp) && resp.can_id == RESP_ID && resp.can_dlc == 2) {
            int16_t ti = (resp.data[0] << 8) | resp.data[1];
            printf("Temp: %.2f °C\n", ti / 100.0f);
        } else if (n < 0) {
            /* timeout: nothing received */
            printf("No reply\n");
        }
        sleep(2);
    }
    return 0;
}
