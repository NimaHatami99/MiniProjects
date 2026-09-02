/*
 * Project 1.c
 *
 * Created: 12/08/2020 00:35:34
 * Author: NIMA
 */
#include <mega32.h>
#include <delay.h>
unsigned char row_data[]={0x42,0x42,0x46,0x4A,0x52,0x62,0x42,0x42},PORTC_select[]={0x00,0x00,0x00,0x10,0x00,0x00,0x00,0x00},PORTC_const[]={0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00};
char i=1;
bit k=1;
interrupt [TIM1_COMPA] void timer1_compa_isr(void);
void main(void)
{
DDRD=0x00;
PORTD=0xFF;
DDRC=0xFF;
PORTC=0x00;
DDRA=0xFF;
PORTA=0xFF;
TCCR1A=0x00;
TCCR1B=0x0A;
OCR1AH=0x4E;
OCR1AL=0x20;
TIMSK=0x10;
SREG|=0x80;
while(1);
}
interrupt [TIM1_COMPA] void timer1_compa_isr(void)
{
if(k==0 && PORTC_select[i-1]!=0x00)
{
if(PIND.2==0)
    {
    delay_ms(20);
    while(PIND.2==0);
    if((PORTC_const[i-1] & PORTC_select[i-1])==0)
        {
        PORTC_const[i-1] |= PORTC_select[i-1];    
        }
    else
        {
        PORTC_const[i-1] ^= PORTC_select[i-1];
        }
    }
if(PIND.0==0)
    {
    delay_ms(20);
    while(PIND.0==0);
    if(PORTC_select[i-1]==0x80)
        {
        PORTC_select[i-1]=0x01;
        }
    else
        {
        PORTC_select[i-1]<<=1;
        }    
    }
if(PIND.4==0)
    {
    delay_ms(20);
    while(PIND.4==0);
    if(PORTC_select[i-1]==0x01)
        {
        PORTC_select[i-1]=0x80;
        }
    else
        {
        PORTC_select[i-1]>>=1;
        }    
    }
if(PIND.1==0)
    {
    delay_ms(20);
    while(PIND.1==0);
    if(i==1)
        {
        PORTC_select[7]=PORTC_select[0];
        PORTC_select[0]=0;
        }
    else
        {
        PORTC_select[i-2]=PORTC_select[i-1];
        PORTC_select[i-1]=0;
        }
    }
if(PIND.3==0)
    {
    delay_ms(20);
    while(PIND.3==0);
    if(i==8)
        {
        PORTC_select[0]=PORTC_select[7];
        PORTC_select[7]=0;
        }
    else
        {
        PORTC_select[i]=PORTC_select[i-1];
        PORTC_select[i-1]=0;
        }
    }
row_data[i-1]=PORTC_const[i-1]|PORTC_select[i-1];    
}
PORTA=~(1<<(i-1));
PORTC=row_data[i-1];
delay_ms(10);
if(i==8)
{
i=1;
}
else
{
i++;
}
if(PIND.2==0 && k==1)
{
delay_ms(20);
while(PIND.2==0);
row_data[0]=0x00;
row_data[1]=0x00;
row_data[2]=0x00;
row_data[3]=0x00;
row_data[4]=0x00;
row_data[5]=0x00;
row_data[6]=0x00;
row_data[7]=0x00;
row_data[3]=PORTC_const[3]|PORTC_select[3];
k=0;
}
}