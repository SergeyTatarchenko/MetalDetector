;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.0 #9253 (Jan 11 2016) (Linux)
; This file was generated Mon Feb 22 16:44:48 2016
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
;	.file	"main.c"
	list	p=16f630
	radix dec
	include "p16f630.inc"
;--------------------------------------------------------
; config word(s)
;--------------------------------------------------------
	__config 0x3fd2
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------
	extern	__print_format
	extern	_printf_small
	extern	_printf
	extern	_vprintf
	extern	_sprintf
	extern	_vsprintf
	extern	_puts
	extern	_gets
	extern	_getchar
	extern	_putchar
	extern	_send_signal
	extern	_STATUSbits
	extern	_PORTAbits
	extern	_PORTCbits
	extern	_INTCONbits
	extern	_PIR1bits
	extern	_T1CONbits
	extern	_CMCONbits
	extern	_OPTION_REGbits
	extern	_TRISAbits
	extern	_TRISCbits
	extern	_PIE1bits
	extern	_PCONbits
	extern	_OSCCALbits
	extern	_WPUbits
	extern	_WPUAbits
	extern	_IOCbits
	extern	_IOCAbits
	extern	_VRCONbits
	extern	_EECON1bits
	extern	_INDF
	extern	_TMR0
	extern	_PCL
	extern	_STATUS
	extern	_FSR
	extern	_PORTA
	extern	_PORTC
	extern	_PCLATH
	extern	_INTCON
	extern	_PIR1
	extern	_TMR1
	extern	_TMR1L
	extern	_TMR1H
	extern	_T1CON
	extern	_CMCON
	extern	_OPTION_REG
	extern	_TRISA
	extern	_TRISC
	extern	_PIE1
	extern	_PCON
	extern	_OSCCAL
	extern	_WPU
	extern	_WPUA
	extern	_IOC
	extern	_IOCA
	extern	_VRCON
	extern	_EEDAT
	extern	_EEDATA
	extern	_EEADR
	extern	_EECON1
	extern	_EECON2
	extern	__sdcc_gsinit_startup
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	_check_generator
	global	_sensitivity_down
	global	_sensitivity_up
	global	_calibration
	global	_send_error
	global	_delay_us
	global	_delay_ms
	global	_dr_metal
	global	_bl_metal
	global	_main
	global	_calibration_complete
	global	_buffer_high
	global	_buffer_low
	global	_sensitivity

	global PSAVE
	global SSAVE
	global WSAVE
	global STK12
	global STK11
	global STK10
	global STK09
	global STK08
	global STK07
	global STK06
	global STK05
	global STK04
	global STK03
	global STK02
	global STK01
	global STK00

sharebank udata_ovr 0x0020
PSAVE	res 1
SSAVE	res 1
WSAVE	res 1
STK12	res 1
STK11	res 1
STK10	res 1
STK09	res 1
STK08	res 1
STK07	res 1
STK06	res 1
STK05	res 1
STK04	res 1
STK03	res 1
STK02	res 1
STK01	res 1
STK00	res 1

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
UD_main_0	udata
_calibration_complete	res	1

UD_main_1	udata
_buffer_high	res	1

UD_main_2	udata
_buffer_low	res	1

;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL_main_0	udata
r0x1005	res	1
r0x1004	res	1
r0x1006	res	1
r0x1007	res	1
r0x1008	res	1
r0x1009	res	1
r0x100A	res	1
r0x100B	res	1
r0x100C	res	1
r0x100D	res	1
r0x100E	res	1
r0x100F	res	1
r0x1010	res	1
r0x1011	res	1
r0x1012	res	1
r0x1013	res	1
r0x1014	res	1
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------

ID_main_0	idata
_sensitivity
	db	0x00

;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
;	udata_ovr
;--------------------------------------------------------
; reset vector 
;--------------------------------------------------------
STARTUP	code 0x0000
	nop
	pagesel __sdcc_gsinit_startup
	goto	__sdcc_gsinit_startup
;--------------------------------------------------------
; code
;--------------------------------------------------------
code_main	code
;***
;  pBlock Stats: dbName = M
;***
;entry:  _main	;Function start
; 2 exit points
;has an exit
;functions called:
;   _delay_ms
;   _calibration
;   _check_generator
;   _sensitivity_up
;   _sensitivity_down
;   _delay_ms
;   _calibration
;   _delay_ms
;   _calibration
;   _check_generator
;   _sensitivity_up
;   _sensitivity_down
;   _delay_ms
;   _calibration
;3 compiler assigned registers:
;   r0x1013
;   r0x1014
;   STK00
;; Starting pCode block
_main	;Function start
; 2 exit points
;	.line	134; "main.c"	T1CON = 0;
	BANKSEL	_T1CON
	CLRF	_T1CON
;	.line	135; "main.c"	TMR1H = 0;
	CLRF	_TMR1H
;	.line	136; "main.c"	TMR1L = 0;
	CLRF	_TMR1L
;	.line	137; "main.c"	TRC = 0b00111000;
	MOVLW	0x38
	BANKSEL	_TRISC
	MOVWF	_TRISC
;	.line	138; "main.c"	PTC = 0;
	BANKSEL	_PORTC
	CLRF	_PORTC
;	.line	139; "main.c"	TRA = 0b00000100;
	MOVLW	0x04
	BANKSEL	_TRISA
	MOVWF	_TRISA
;	.line	140; "main.c"	PTA = 0;
	BANKSEL	_PORTA
	CLRF	_PORTA
;	.line	141; "main.c"	setbit(PTC,1);                              // no calibration LED_RED
	BSF	_PORTC,1
_00282_DS_
;	.line	143; "main.c"	while (calibration_complete==0) {           //wait for calibration
	MOVLW	0x00
	IORWF	_calibration_complete,W
	BTFSS	STATUS,2
	GOTO	_00302_DS_
;	.line	144; "main.c"	if (rdbit(PTC,5)==1){
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	ANDLW	0x20
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x1013
	MOVWF	r0x1014
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00279_DS_
;	.line	145; "main.c"	delay_ms(5);            //contact bounce
	MOVLW	0x05
	MOVWF	STK00
	MOVLW	0x00
	CALL	_delay_ms
;	.line	146; "main.c"	if(rdbit(PTC,5)==1){
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	ANDLW	0x20
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x1013
	MOVWF	r0x1014
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00279_DS_
;	.line	147; "main.c"	calibration();
	CALL	_calibration
;	.line	148; "main.c"	setbit(PTC,2);  //set LED_GREEN
	BANKSEL	_PORTC
	BSF	_PORTC,2
;	.line	149; "main.c"	clrbit(PTC,1);
	MOVF	_PORTC,W
	MOVWF	r0x1013
	MOVLW	0xfd
	ANDWF	r0x1013,W
	MOVWF	_PORTC
_00279_DS_
;	.line	152; "main.c"	while(rdbit(PTC,5)==1);
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	ANDLW	0x20
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x1013
	MOVWF	r0x1014
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00282_DS_
	GOTO	_00279_DS_
_00302_DS_
;	.line	154; "main.c"	while(calibration_complete ==1) {
	MOVF	_calibration_complete,W
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00282_DS_
;	.line	155; "main.c"	INTF=0;                             //start detect
	BANKSEL	_INTCONbits
	BCF	_INTCONbits,1
_00285_DS_
;	.line	156; "main.c"	while (INTF==0);
	BANKSEL	_INTCONbits
	BTFSS	_INTCONbits,1
	GOTO	_00285_DS_
;	.line	157; "main.c"	TMR1ON =1;
	BSF	_T1CONbits,0
;	.line	158; "main.c"	INTF=0;
	BCF	_INTCONbits,1
_00288_DS_
;	.line	159; "main.c"	while (INTF==0);
	BANKSEL	_INTCONbits
	BTFSS	_INTCONbits,1
	GOTO	_00288_DS_
;	.line	160; "main.c"	TMR1ON=0;
	BCF	_T1CONbits,0
;	.line	161; "main.c"	TH=TMR1H;
	MOVF	_TMR1H,W
	MOVWF	r0x1013
;	.line	162; "main.c"	TL=TMR1L;
	MOVF	_TMR1L,W
;	.line	163; "main.c"	check_generator(TH,TL);
	MOVWF	r0x1014
	MOVWF	STK00
	MOVF	r0x1013,W
	CALL	_check_generator
;	.line	164; "main.c"	TMR1L=0;
	BANKSEL	_TMR1L
	CLRF	_TMR1L
;	.line	165; "main.c"	TMR1H=0;
	CLRF	_TMR1H
;	.line	166; "main.c"	if(rdbit(PTC,4)==1){sensitivity_up();}
	MOVF	_PORTC,W
	ANDLW	0x10
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x1013
	MOVWF	r0x1014
;	.line	167; "main.c"	if(rdbit(PTC,3)==1){sensitivity_down();}
	XORLW	0x01
	BTFSC	STATUS,2
	CALL	_sensitivity_up
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	ANDLW	0x08
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x1013
	MOVWF	r0x1014
;	.line	168; "main.c"	if(rdbit(PTC,5)==1) {
	XORLW	0x01
	BTFSC	STATUS,2
	CALL	_sensitivity_down
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	ANDLW	0x20
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x1013
	MOVWF	r0x1014
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00302_DS_
;	.line	169; "main.c"	delay_ms(5);                //contact bounce
	MOVLW	0x05
	MOVWF	STK00
	MOVLW	0x00
	CALL	_delay_ms
;	.line	170; "main.c"	if(rdbit(PTC,5)==1){
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	ANDLW	0x20
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x1013
	MOVWF	r0x1014
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00302_DS_
;	.line	171; "main.c"	calibration();
	CALL	_calibration
_00295_DS_
;	.line	172; "main.c"	while(rdbit(PTC,5)==1);
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	ANDLW	0x20
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x1013
	MOVWF	r0x1014
	XORLW	0x01
	BTFSC	STATUS,2
	GOTO	_00295_DS_
	GOTO	_00302_DS_
	RETURN	
; exit point of _main

;***
;  pBlock Stats: dbName = C
;***
;entry:  _check_generator	;Function start
; 0 exit points
;functions called:
;   _send_error
;   _dr_metal
;   _bl_metal
;   _send_error
;   _dr_metal
;   _bl_metal
;5 compiler assigned registers:
;   r0x100F
;   STK00
;   r0x1010
;   r0x1011
;   r0x1012
;; Starting pCode block
_check_generator	;Function start
; 0 exit points
;	.line	116; "main.c"	void check_generator( unsigned char Hbyte, unsigned char Lbyte ){
	MOVWF	r0x100F
	MOVF	STK00,W
	MOVWF	r0x1010
;	.line	120; "main.c"	buffer_sensetivity = buffer_low;
	MOVF	_buffer_low,W
	MOVWF	r0x1011
;	.line	122; "main.c"	for(i=0;i<sensitivity;i++){
	CLRF	r0x1012
_00249_DS_
	MOVF	_sensitivity,W
	SUBWF	r0x1012,W
	BTFSC	STATUS,0
	GOTO	_00241_DS_
;;genSkipc:3247: created from rifx:0x7ffd7ce78fd0
	INCF	r0x1012,F
	GOTO	_00249_DS_
_00241_DS_
;	.line	126; "main.c"	if(Hbyte != buffer_high){send_error();}
	MOVF	_buffer_high,W
;	.line	127; "main.c"	if(buffer_timer<buffer_sensetivity){dr_metal();}
	XORWF	r0x100F,W
	BTFSS	STATUS,2
	CALL	_send_error
	MOVF	r0x1011,W
;	.line	128; "main.c"	if(buffer_timer>buffer_sensetivity){bl_metal();}
	SUBWF	r0x1010,W
	BTFSS	STATUS,0
	CALL	_dr_metal
	MOVF	r0x1010,W
	SUBWF	r0x1011,W
	BTFSS	STATUS,0
	CALL	_bl_metal
	RETURN	

;***
;  pBlock Stats: dbName = C
;***
;entry:  _sensitivity_down	;Function start
; 0 exit points
;functions called:
;   _delay_ms
;   _delay_ms
;   _delay_ms
;   _delay_ms
;3 compiler assigned registers:
;   STK00
;   r0x100A
;   r0x100B
;; Starting pCode block
_sensitivity_down	;Function start
; 0 exit points
;	.line	108; "main.c"	delay_ms(5);
	MOVLW	0x05
	MOVWF	STK00
	MOVLW	0x00
	CALL	_delay_ms
;	.line	109; "main.c"	if(rdbit(PTC,3)==1 && sensitivity > 0){
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	ANDLW	0x08
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x100A
	MOVWF	r0x100B
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00220_DS_
	MOVLW	0x00
;	.line	110; "main.c"	sensitivity--;
	IORWF	_sensitivity,W
;	.line	112; "main.c"	delay_ms(5);
	BTFSS	STATUS,2
	DECF	_sensitivity,F
_00220_DS_
	MOVLW	0x05
	MOVWF	STK00
	MOVLW	0x00
	CALL	_delay_ms
_00222_DS_
;	.line	113; "main.c"	while(rdbit(PTC,3)==1);
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	ANDLW	0x08
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x100A
	MOVWF	r0x100B
	XORLW	0x01
	BTFSC	STATUS,2
	GOTO	_00222_DS_
	RETURN	

;***
;  pBlock Stats: dbName = C
;***
;entry:  _sensitivity_up	;Function start
; 0 exit points
;functions called:
;   _delay_ms
;   _delay_ms
;   _delay_ms
;   _delay_ms
;3 compiler assigned registers:
;   STK00
;   r0x100A
;   r0x100B
;; Starting pCode block
_sensitivity_up	;Function start
; 0 exit points
;	.line	100; "main.c"	delay_ms(5);
	MOVLW	0x05
	MOVWF	STK00
	MOVLW	0x00
	CALL	_delay_ms
;	.line	101; "main.c"	if(rdbit(PTC,4)==1 && sensitivity<5){
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	ANDLW	0x10
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x100A
	MOVWF	r0x100B
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00197_DS_
;;unsigned compare: left < lit(0x5=5), size=1
	MOVLW	0x05
;	.line	102; "main.c"	sensitivity++;
	SUBWF	_sensitivity,W
;	.line	104; "main.c"	delay_ms(5);
	BTFSS	STATUS,0
	INCF	_sensitivity,F
_00197_DS_
	MOVLW	0x05
	MOVWF	STK00
	MOVLW	0x00
	CALL	_delay_ms
_00199_DS_
;	.line	105; "main.c"	while(rdbit(PTC,4)==1);
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	ANDLW	0x10
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x100A
	MOVWF	r0x100B
	XORLW	0x01
	BTFSC	STATUS,2
	GOTO	_00199_DS_
	RETURN	

;***
;  pBlock Stats: dbName = C
;***
;entry:  _calibration	;Function start
; 2 exit points
;has an exit
;; Starting pCode block
_calibration	;Function start
; 2 exit points
;	.line	88; "main.c"	INTF=0;
	BANKSEL	_INTCONbits
	BCF	_INTCONbits,1
_00188_DS_
;	.line	89; "main.c"	while(INTF==0);                         //wait for rising edge generator
	BANKSEL	_INTCONbits
	BTFSS	_INTCONbits,1
	GOTO	_00188_DS_
;	.line	90; "main.c"	TMR1ON=1;
	BSF	_T1CONbits,0
;	.line	91; "main.c"	INTF =0;
	BCF	_INTCONbits,1
_00191_DS_
;	.line	92; "main.c"	while(INTF==0);
	BANKSEL	_INTCONbits
	BTFSS	_INTCONbits,1
	GOTO	_00191_DS_
;	.line	93; "main.c"	TMR1ON=0;
	BCF	_T1CONbits,0
;	.line	94; "main.c"	buffer_high = TMR1H;
	MOVF	_TMR1H,W
	MOVWF	_buffer_high
;	.line	95; "main.c"	buffer_low = TMR1L;
	MOVF	_TMR1L,W
	MOVWF	_buffer_low
;	.line	96; "main.c"	calibration_complete=1;
	MOVLW	0x01
	MOVWF	_calibration_complete
	RETURN	
; exit point of _calibration

;***
;  pBlock Stats: dbName = C
;***
;entry:  _send_error	;Function start
; 2 exit points
;has an exit
;functions called:
;   _delay_us
;   _delay_us
;   _delay_us
;   _delay_us
;4 compiler assigned registers:
;   r0x100C
;   r0x100D
;   STK00
;   r0x100E
;; Starting pCode block
_send_error	;Function start
; 2 exit points
;	.line	78; "main.c"	while(j<100) {
	CLRF	r0x100C
	CLRF	r0x100D
;;unsigned compare: left < lit(0x64=100), size=2
_00171_DS_
	MOVLW	0x00
	SUBWF	r0x100D,W
	BTFSS	STATUS,2
	GOTO	_00183_DS_
	MOVLW	0x64
	SUBWF	r0x100C,W
_00183_DS_
	BTFSC	STATUS,0
	GOTO	_00174_DS_
;;genSkipc:3247: created from rifx:0x7ffd7ce78fd0
;	.line	79; "main.c"	setbit(PTC,0);
	BANKSEL	_PORTC
	BSF	_PORTC,0
;	.line	80; "main.c"	delay_us(500);
	MOVLW	0xf4
	MOVWF	STK00
	MOVLW	0x01
	CALL	_delay_us
;	.line	81; "main.c"	clrbit(PTC,0);
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	MOVWF	r0x100E
	MOVLW	0xfe
	ANDWF	r0x100E,W
	MOVWF	_PORTC
;	.line	82; "main.c"	delay_us(500);
	MOVLW	0xf4
	MOVWF	STK00
	MOVLW	0x01
	CALL	_delay_us
;	.line	83; "main.c"	j++;
	INCF	r0x100C,F
	BTFSC	STATUS,2
	INCF	r0x100D,F
	GOTO	_00171_DS_
_00174_DS_
	RETURN	
; exit point of _send_error

;***
;  pBlock Stats: dbName = C
;***
;entry:  _bl_metal	;Function start
; 2 exit points
;has an exit
;functions called:
;   _delay_ms
;   _delay_ms
;   _delay_ms
;   _delay_ms
;2 compiler assigned registers:
;   STK00
;   r0x100A
;; Starting pCode block
_bl_metal	;Function start
; 2 exit points
;	.line	70; "main.c"	setbit(PTC,0);
	BANKSEL	_PORTC
	BSF	_PORTC,0
;	.line	71; "main.c"	delay_ms(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	CALL	_delay_ms
;	.line	72; "main.c"	clrbit(PTC,0);
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	MOVWF	r0x100A
	MOVLW	0xfe
	ANDWF	r0x100A,W
	MOVWF	_PORTC
;	.line	73; "main.c"	delay_ms(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	CALL	_delay_ms
	RETURN	
; exit point of _bl_metal

;***
;  pBlock Stats: dbName = C
;***
;entry:  _dr_metal	;Function start
; 2 exit points
;has an exit
;functions called:
;   _delay_us
;   _delay_us
;   _delay_us
;   _delay_us
;2 compiler assigned registers:
;   STK00
;   r0x100C
;; Starting pCode block
_dr_metal	;Function start
; 2 exit points
;	.line	64; "main.c"	setbit(PTC,0);
	BANKSEL	_PORTC
	BSF	_PORTC,0
;	.line	65; "main.c"	delay_us(200);
	MOVLW	0xc8
	MOVWF	STK00
	MOVLW	0x00
	CALL	_delay_us
;	.line	66; "main.c"	clrbit(PTC,0);
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	MOVWF	r0x100C
	MOVLW	0xfe
	ANDWF	r0x100C,W
	MOVWF	_PORTC
;	.line	67; "main.c"	delay_us(200);
	MOVLW	0xc8
	MOVWF	STK00
	MOVLW	0x00
	CALL	_delay_us
	RETURN	
; exit point of _dr_metal

;***
;  pBlock Stats: dbName = C
;***
;entry:  _delay_us	;Function start
; 2 exit points
;has an exit
;9 compiler assigned registers:
;   r0x1004
;   STK00
;   r0x1005
;   r0x1006
;   r0x1007
;   r0x1008
;   r0x1009
;   r0x100A
;   r0x100B
;; Starting pCode block
_delay_us	;Function start
; 2 exit points
;	.line	51; "main.c"	void delay_us(unsigned int us){
	MOVWF	r0x1004
	MOVF	STK00,W
	MOVWF	r0x1005
;	.line	56; "main.c"	for(i=0;i<us;i++){
	CLRF	r0x1006
	CLRF	r0x1007
_00139_DS_
	MOVF	r0x1004,W
	SUBWF	r0x1007,W
	BTFSS	STATUS,2
	GOTO	_00157_DS_
	MOVF	r0x1005,W
	SUBWF	r0x1006,W
_00157_DS_
	BTFSC	STATUS,0
	GOTO	_00141_DS_
;;genSkipc:3247: created from rifx:0x7ffd7ce78fd0
;	.line	58; "main.c"	while(j<timerBuffer){j++;}
	CLRF	r0x1008
	CLRF	r0x1009
	CLRF	r0x100A
	CLRF	r0x100B
;;unsigned compare: left < lit(0x14=20), size=4
_00134_DS_
	MOVLW	0x00
	SUBWF	r0x100B,W
	BTFSS	STATUS,2
	GOTO	_00158_DS_
	MOVLW	0x00
	SUBWF	r0x100A,W
	BTFSS	STATUS,2
	GOTO	_00158_DS_
	MOVLW	0x00
	SUBWF	r0x1009,W
	BTFSS	STATUS,2
	GOTO	_00158_DS_
	MOVLW	0x14
	SUBWF	r0x1008,W
_00158_DS_
	BTFSC	STATUS,0
	GOTO	_00140_DS_
;;genSkipc:3247: created from rifx:0x7ffd7ce78fd0
	INCF	r0x1008,F
	BTFSC	STATUS,2
	INCF	r0x1009,F
	BTFSC	STATUS,2
	INCF	r0x100A,F
	BTFSC	STATUS,2
	INCF	r0x100B,F
	GOTO	_00134_DS_
_00140_DS_
;	.line	56; "main.c"	for(i=0;i<us;i++){
	INCF	r0x1006,F
	BTFSC	STATUS,2
	INCF	r0x1007,F
	GOTO	_00139_DS_
_00141_DS_
	RETURN	
; exit point of _delay_us

;***
;  pBlock Stats: dbName = C
;***
;entry:  _delay_ms	;Function start
; 2 exit points
;has an exit
;7 compiler assigned registers:
;   r0x1004
;   STK00
;   r0x1005
;   r0x1006
;   r0x1007
;   r0x1008
;   r0x1009
;; Starting pCode block
_delay_ms	;Function start
; 2 exit points
;	.line	41; "main.c"	void delay_ms ( unsigned int ms) {
	MOVWF	r0x1004
	MOVF	STK00,W
	MOVWF	r0x1005
;	.line	45; "main.c"	for(i=0;i<ms;i++){
	CLRF	r0x1006
	CLRF	r0x1007
_00110_DS_
	MOVF	r0x1004,W
	SUBWF	r0x1007,W
	BTFSS	STATUS,2
	GOTO	_00128_DS_
	MOVF	r0x1005,W
	SUBWF	r0x1006,W
_00128_DS_
	BTFSC	STATUS,0
	GOTO	_00112_DS_
;;genSkipc:3247: created from rifx:0x7ffd7ce78fd0
;	.line	47; "main.c"	while(j<timerBuffer){j++;}
	CLRF	r0x1008
	CLRF	r0x1009
;;unsigned compare: left < lit(0x4E20=20000), size=2
_00105_DS_
	MOVLW	0x4e
	SUBWF	r0x1009,W
	BTFSS	STATUS,2
	GOTO	_00129_DS_
	MOVLW	0x20
	SUBWF	r0x1008,W
_00129_DS_
	BTFSC	STATUS,0
	GOTO	_00111_DS_
;;genSkipc:3247: created from rifx:0x7ffd7ce78fd0
	INCF	r0x1008,F
	BTFSC	STATUS,2
	INCF	r0x1009,F
	GOTO	_00105_DS_
_00111_DS_
;	.line	45; "main.c"	for(i=0;i<ms;i++){
	INCF	r0x1006,F
	BTFSC	STATUS,2
	INCF	r0x1007,F
	GOTO	_00110_DS_
_00112_DS_
	RETURN	
; exit point of _delay_ms


;	code size estimation:
;	  365+   30 =   395 instructions (  850 byte)

	end
