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
#define LED_PIN   0                 // wiringPi pin 0 (BCM GPIO17) used to drive an LED
#define REL_PIN   2                 // wiringPi pin 2 (BCM GPIO27) used to drive a relay (active-LOW)

#define ID_STAT 0x210               // CAN identifier for status frames (temperature + outputs)
#define ID_CMD  0x211               // CAN identifier for command frames (LED/relay control)
#define PERIOD_MS 5000              

volatile int running = 1;           // Global flag indicating main loop should continue running
void sigint(int s){ running = 0; }  // SIGINT (Ctrl+C) handler: set flag to 0 to stop the loop

static float read_lm75(int fd)                      // Read current temperature (°C) from LM75 via I2C file descriptor
{                                                   
    int raw = wiringPiI2CReadReg16(fd, 0x00);       
    raw = (raw >> 8) | ((raw & 0xFF) << 8);         
    return (int16_t)(raw >> 5) * 0.125f;            
}                                                   

int main(void)                                      
{                                                   
    signal(SIGINT, sigint);                         // Register Ctrl+C handler to exit gracefully
    wiringPiSetup();                                

    pinMode(LED_PIN, OUTPUT);                       
    pinMode(REL_PIN, OUTPUT);                       

    int lm75 = wiringPiI2CSetup(LM75_ADDR);         // Open I2C connection to LM75; returns file descriptor

    /* open CAN */                                   // ---- Create and bind a RAW CAN socket on can0 ----
    int s = socket(PF_CAN, SOCK_RAW, CAN_RAW);      // Create a RAW CAN socket (protocol family PF_CAN)
    struct ifreq ifr; strcpy(ifr.ifr_name, "can0"); // Prepare interface request for "can0"
    ioctl(s, SIOCGIFINDEX, &ifr);                   // Query kernel for the interface index of can0
    struct sockaddr_can addr = { .can_family = AF_CAN, // Build CAN socket address structure
                                 .can_ifindex = ifr.ifr_ifindex }; // Bind to the retrieved interface index
    bind(s,(struct sockaddr*)&addr,sizeof(addr));   // Bind the socket to can0 so reads/writes go over that bus

    struct can_frame tx = { .can_id = ID_STAT, .can_dlc = 4 }; // Prepare reusable TX frame (status, 4 data bytes)
    struct can_frame rx;                           // Buffer for incoming CAN frames (commands)
    uint32_t last = 0;                             // Timestamp (ms) of last periodic status transmission

    while (running)                                // Main loop: continue until SIGINT sets running = 0
    {                                              
        /* ---------- handle incoming command ---------- */ // Poll for and process command frames (non-blocking)
        struct timeval tv = { .tv_sec = 0, .tv_usec = 1000 }; // Select timeout: 1,000 microseconds (1 ms)
        fd_set fds; FD_ZERO(&fds); FD_SET(s,&fds);  // Initialize fd set and add CAN socket to it
        if (select(s+1,&fds,NULL,NULL,&tv) > 0 &&   // If socket is readable within the timeout
            read(s,&rx,sizeof(rx)) == sizeof(rx) && // And we successfully read a full CAN frame
            rx.can_id == ID_CMD && rx.can_dlc == 2) // And it is a 2-byte command frame with the expected ID
        {                                          // Begin command handling
            if (rx.data[0] != 0xFF) digitalWrite(LED_PIN , rx.data[0]);           // Apply LED command if not 0xFF (no-change)
            if (rx.data[1] != 0xFF) digitalWrite(REL_PIN , rx.data[1] ? LOW : HIGH); // Apply relay (active-LOW): 1=ON(LOW), 0=OFF(HIGH)
            /* echo new status immediately */      // After applying, publish the new status right away
            float t = read_lm75(lm75);             
            int16_t ti = (int16_t)(t*100);         
            tx.data[0]=ti>>8; tx.data[1]=ti&0xFF;  
            tx.data[2]=digitalRead(LED_PIN);       // Store current LED state (0 or 1)
            tx.data[3]=!digitalRead(REL_PIN);      // Store relay logical state; invert because output is active-LOW
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

