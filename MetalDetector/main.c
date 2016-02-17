/*
PTC.3 - sensitivity down
PTC.4 - sensitivity up
PTC.5 - calibration
PTC.0 - speaker
PTC.1 - led red
PIC.2 - led green
*/
// include for SDCC compiler
#include <pic14regs.h>
#include <stdint.h>
#include <stdio.h>
//**************************
#define PTC PORTC
#define PTA PORTA
#define TRA TRISA
#define TRC TRISC
//**************************
#define FREQ 20000000
//**************************
#define setbit(reg,bit) ((reg) |= 1 << (bit)) // setup bin in register
#define clrbit(reg,bit) ((reg) &= ~(1 << (bit))) //clean bit in register
#define rdbit(reg,bit)  ((unsigned char)((reg >> bit) & 1)) // read bit in register
//**************************
static __code uint16_t __at (_CONFIG) configword1 = _CP_OFF & _WDT_OFF & _HS_OSC & _MCLRE_OFF;
//**************************
unsigned char calibration_complete ;
unsigned char buffer_high,buffer_low;
unsigned char sensitivity=0;
//**************************
void PORT_CONFIG();
void send_error();
void TIMER_CONFIG();
void calibration();
void send_signal();
void sensitivity_up();
void sensitivity_down();
void delay_ms( unsigned int ms);
void check_generator(unsigned char Hbyte, unsigned char Lbyte);


void delay_ms ( unsigned int ms) {
    #ifdef FREQ
    unsigned int timerBuffer = FREQ/1000;
    unsigned int i,j;
    for(i=0;i<ms;i++){
        j=0;
        while(j<timerBuffer/50){j++;}
    }
    #endif // FREQ
}
//**************************
void dr_metal(){
    setbit(PTC,0);
    delay_ms(20);
    clrbit(PTC,0);
    delay_ms(20);
}
void bl_metal(){
    setbit(PTC,0);
    delay_ms(1);
    clrbit(PTC,0);
    delay_ms(1);
}
//**************************
void send_error () {
   unsigned int j =0;
   while(j<100) {
        setbit(PTC,0);
        delay_ms(10);
        clrbit(PTC,0);
        delay_ms(10);
        j++;
   }
   delay_ms(1000);
}

void calibration (){
    INTF=0;
    while(INTF==0);                         //wait for rising edge generator
    TMR1ON=1;
    INTF =0;
    while(INTF==0);
    TMR1ON=0;
    buffer_high = TMR1H;
    buffer_low = TMR1L;
    TMR1L=0;
    TMR1H=0;
    calibration_complete=1;
}

void sensitivity_up(){
        delay_ms(5);
        if(rdbit(PTC,4)==1 && sensitivity<5){
            sensitivity++;
        }
        delay_ms(5);
        while(rdbit(PTC,4)==1);
}
void sensitivity_down(){
        delay_ms(5);
        if(rdbit(PTC,5)==1 && sensitivity>0){
            sensitivity--;
        }
        delay_ms(5);
        while(rdbit(PTC,5)==1);
}

void check_generator( unsigned char Hbyte, unsigned char Lbyte ){
    unsigned char buffer_sensetivity;
    unsigned char buffer_timer;
    unsigned char i;
    buffer_sensetivity = buffer_low;
    buffer_timer = Lbyte;
    for(i=0;i<sensitivity;i++){
        buffer_sensetivity >> 1;
        buffer_timer >>1;
    }
    if(Hbyte != buffer_high){send_error();}
    if(buffer_timer<buffer_sensetivity){dr_metal();}
    if(buffer_timer>buffer_sensetivity){bl_metal();}
}
//**************************
void main() {
    unsigned char TH;
    unsigned char TL;
    T1CON = 0;
    TMR1H = 0;
    TMR1L = 0;
    TRC = 0b00111000;
    PTC = 0;
    TRA = 0b00000100;
    PTA = 0;
    setbit(PTC,1);                              // no calibration LED_RED
	while (calibration_complete==0) {           //wait for calibration
                if (rdbit(PTC,3)==1){
                        delay_ms(5);            //contact bounce
                        if(rdbit(PTC,3)==1){
                                calibration();
                                setbit(PTC,2);  //set LED_GREEN
                                clrbit(PTC,1);
                        }
                }
                while(rdbit(PTC,3)==1);
            }
	while(1) {
            INTF=0;                             //start detect
            while (INTF==0);
            TMR1ON =1;
            INTF=0;
            while (INTF==0);
            TMR1ON=0;
            TH=TMR1H;
            TL=TMR1L;
            check_generator(TH,TL);
            if(rdbit(PTC,4)==1){sensitivity_up();}
            if(rdbit(PTC,5)==1){sensitivity_down();}
            if(rdbit(PTC,3)==1) {
                    delay_ms(5);                //contact bounce
                    if(rdbit(PTC,3)==1){
                        calibration();
                    }
            }
	}
}
