#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <net/if.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <linux/can.h>
#include <linux/can/raw.h>
#include "MQTTClient.h"

#define BROKER      "tcp://test.mosquitto.org:1883"
#define CLIENTID    "tk6wXkStDk"
#define QOS         1
#define TMO_MS      10000L

#define TOP_TEMP      "pi3_ctrl/temp"
#define TOP_LED       "pi3_ctrl/led"
#define TOP_RELAY     "pi3_ctrl/relay"
#define TOP_LED_SW    "pi3_ctrl/led_switch"
#define TOP_RELAY_SW  "pi3_ctrl/relay_switch"

#define CAN_DEV   "can0"
#define ID_STAT   0x210
#define ID_CMD    0x211

volatile int running = 1;
int  canfd   = -1;           /* CAN socket */
MQTTClient cli;              /* MQTT client */

static int mqtt_pub(const char *topic, const char *payload, int retain)
{
    MQTTClient_message msg = MQTTClient_message_initializer;
    msg.payload    = (void *)payload;
    msg.payloadlen = (int)strlen(payload);
    msg.qos        = QOS;
    msg.retained   = retain;
    MQTTClient_deliveryToken tok;
    int rc = MQTTClient_publishMessage(cli, topic, &msg, &tok);
    if (rc == MQTTCLIENT_SUCCESS)
        rc = MQTTClient_waitForCompletion(cli, tok, TMO_MS);
    return rc;
}

static void sigint(int s){ running = 0; }

int main(void)
{
    /* ---------- CAN ---------- */
    signal(SIGINT, sigint);
    canfd = socket(PF_CAN, SOCK_RAW, CAN_RAW);
    struct ifreq ifr; strcpy(ifr.ifr_name, CAN_DEV);
    ioctl(canfd, SIOCGIFINDEX, &ifr);
    struct sockaddr_can caddr={ .can_family=AF_CAN,.can_ifindex=ifr.ifr_ifindex };
    bind(canfd,(struct sockaddr*)&caddr,sizeof(caddr));

    /* ---------- MQTT ---------- */
    MQTTClient_connectOptions copts = MQTTClient_connectOptions_initializer;
    MQTTClient_create(&cli, BROKER, CLIENTID, MQTTCLIENT_PERSISTENCE_NONE, NULL);
    copts.keepAliveInterval = 60; copts.cleansession = 1;
mqtt_reconnect:
    if (MQTTClient_connect(cli,&copts)!=MQTTCLIENT_SUCCESS){
        fprintf(stderr,"MQTT connect fail – retry\n"); sleep(5); goto mqtt_reconnect;
    }
    MQTTClient_subscribe(cli, TOP_LED_SW  , QOS);
    MQTTClient_subscribe(cli, TOP_RELAY_SW, QOS);
    puts("Bridge running");

    int ledState=-1, relayState=-1;
    char buf[16];
    struct can_frame fr;

    while(running){
        /* ---------- poll MQTT (non-blocking) ---------- */
        char *tpc=NULL; int tlen; MQTTClient_message *msg=NULL;
        int rc=MQTTClient_receive(cli,&tpc,&tlen,&msg,0);  /* 0-ms timeout */
        if(rc==MQTTCLIENT_SUCCESS && msg){                 /* got a switch cmd */
            char topic[64]={0}; if(tlen>63)tlen=63; memcpy(topic,tpc,tlen);
            char val=((char*)msg->payload)[0];
            struct can_frame cmd={ .can_id=ID_CMD,.can_dlc=2,.data={0xFF,0xFF}};
            if(!strcmp(topic,TOP_LED_SW))   cmd.data[0]=val-'0';
            if(!strcmp(topic,TOP_RELAY_SW)) cmd.data[1]=val-'0';
            write(canfd,&cmd,sizeof(cmd));                /* forward to ESP32 */
            printf("SWITCH %s = %c → CAN 0x211 [%02X %02X]\n",
                   topic,val,cmd.data[0],cmd.data[1]);
            MQTTClient_freeMessage(&msg); MQTTClient_free(tpc);
        }

        /* ---------- read CAN (non-blocking) ---------- */
        struct timeval tv={.tv_sec=0,.tv_usec=10000}; /* 10 ms */
        fd_set fds; FD_ZERO(&fds); FD_SET(canfd,&fds);
        if(select(canfd+1,&fds,NULL,NULL,&tv)>0 &&
           read(canfd,&fr,sizeof(fr))==sizeof(fr) &&
           fr.can_id==ID_STAT && fr.can_dlc==4)
        {
            int16_t ti=(fr.data[0]<<8)|fr.data[1];
            int nLed=fr.data[2], nRel=fr.data[3];

            snprintf(buf,sizeof(buf),"%.2f",ti/100.0f);
            mqtt_pub(TOP_TEMP ,buf ,0);

            if(nLed!=ledState){ mqtt_pub(TOP_LED ,nLed?"1":"0",1); ledState=nLed; }
            if(nRel!=relayState){mqtt_pub(TOP_RELAY,nRel?"1":"0",1); relayState=nRel;}
        }
    }
    MQTTClient_disconnect(cli,10000); MQTTClient_destroy(&cli); close(canfd);
    return 0;
}
