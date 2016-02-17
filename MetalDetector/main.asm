;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.0 #9253 (Jan 11 2016) (Linux)
; This file was generated Wed Feb 17 11:46:45 2016
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
	extern	_PORT_CONFIG
	extern	_TIMER_CONFIG
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
;   r0x1011
;   r0x1012
;   STK00
;; Starting pCode block
_main	;Function start
; 2 exit points
;	.line	127; "main.c"	T1CON = 0;
	BANKSEL	_T1CON
	CLRF	_T1CON
;	.line	128; "main.c"	TMR1H = 0;
	CLRF	_TMR1H
;	.line	129; "main.c"	TMR1L = 0;
	CLRF	_TMR1L
;	.line	130; "main.c"	TRC = 0b00111000;
	MOVLW	0x38
	BANKSEL	_TRISC
	MOVWF	_TRISC
;	.line	131; "main.c"	PTC = 0;
	BANKSEL	_PORTC
	CLRF	_PORTC
;	.line	132; "main.c"	TRA = 0b00000100;
	MOVLW	0x04
	BANKSEL	_TRISA
	MOVWF	_TRISA
;	.line	133; "main.c"	PTA = 0;
	BANKSEL	_PORTA
	CLRF	_PORTA
;	.line	134; "main.c"	setbit(PTC,1);                              // no calibration LED_RED
	BSF	_PORTC,1
_00253_DS_
;	.line	135; "main.c"	while (calibration_complete==0) {           //wait for calibration
	MOVLW	0x00
	IORWF	_calibration_complete,W
	BTFSS	STATUS,2
	GOTO	_00271_DS_
;	.line	136; "main.c"	if (rdbit(PTC,3)==1){
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	ANDLW	0x08
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x1011
	MOVWF	r0x1012
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00250_DS_
;	.line	137; "main.c"	delay_ms(5);            //contact bounce
	MOVLW	0x05
	MOVWF	STK00
	MOVLW	0x00
	CALL	_delay_ms
;	.line	138; "main.c"	if(rdbit(PTC,3)==1){
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	ANDLW	0x08
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x1011
	MOVWF	r0x1012
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00250_DS_
;	.line	139; "main.c"	calibration();
	CALL	_calibration
;	.line	140; "main.c"	setbit(PTC,2);  //set LED_GREEN
	BANKSEL	_PORTC
	BSF	_PORTC,2
;	.line	141; "main.c"	clrbit(PTC,1);
	MOVF	_PORTC,W
	MOVWF	r0x1011
	MOVLW	0xfd
	ANDWF	r0x1011,W
	MOVWF	_PORTC
_00250_DS_
;	.line	144; "main.c"	while(rdbit(PTC,3)==1);
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	ANDLW	0x08
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x1011
	MOVWF	r0x1012
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00253_DS_
	GOTO	_00250_DS_
_00271_DS_
;	.line	147; "main.c"	INTF=0;                             //start detect
	BANKSEL	_INTCONbits
	BCF	_INTCONbits,1
_00256_DS_
;	.line	148; "main.c"	while (INTF==0);
	BANKSEL	_INTCONbits
	BTFSS	_INTCONbits,1
	GOTO	_00256_DS_
;	.line	149; "main.c"	TMR1ON =1;
	BSF	_T1CONbits,0
;	.line	150; "main.c"	INTF=0;
	BCF	_INTCONbits,1
_00259_DS_
;	.line	151; "main.c"	while (INTF==0);
	BANKSEL	_INTCONbits
	BTFSS	_INTCONbits,1
	GOTO	_00259_DS_
;	.line	152; "main.c"	TMR1ON=0;
	BCF	_T1CONbits,0
;	.line	153; "main.c"	TH=TMR1H;
	MOVF	_TMR1H,W
	MOVWF	r0x1011
;	.line	154; "main.c"	TL=TMR1L;
	MOVF	_TMR1L,W
;	.line	155; "main.c"	check_generator(TH,TL);
	MOVWF	r0x1012
	MOVWF	STK00
	MOVF	r0x1011,W
	CALL	_check_generator
;	.line	156; "main.c"	if(rdbit(PTC,4)==1){sensitivity_up();}
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	ANDLW	0x10
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x1011
	MOVWF	r0x1012
;	.line	157; "main.c"	if(rdbit(PTC,5)==1){sensitivity_down();}
	XORLW	0x01
	BTFSC	STATUS,2
	CALL	_sensitivity_up
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	ANDLW	0x20
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x1011
	MOVWF	r0x1012
;	.line	158; "main.c"	if(rdbit(PTC,3)==1) {
	XORLW	0x01
	BTFSC	STATUS,2
	CALL	_sensitivity_down
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	ANDLW	0x08
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x1011
	MOVWF	r0x1012
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00271_DS_
;	.line	159; "main.c"	delay_ms(5);                //contact bounce
	MOVLW	0x05
	MOVWF	STK00
	MOVLW	0x00
	CALL	_delay_ms
;	.line	160; "main.c"	if(rdbit(PTC,3)==1){
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	ANDLW	0x08
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x1011
	MOVWF	r0x1012
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00271_DS_
;	.line	161; "main.c"	calibration();
	CALL	_calibration
	GOTO	_00271_DS_
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
;   r0x100D
;   STK00
;   r0x100E
;   r0x100F
;   r0x1010
;; Starting pCode block
_check_generator	;Function start
; 0 exit points
;	.line	109; "main.c"	void check_generator( unsigned char Hbyte, unsigned char Lbyte ){
	MOVWF	r0x100D
	MOVF	STK00,W
	MOVWF	r0x100E
;	.line	113; "main.c"	buffer_sensetivity = buffer_low;
	MOVF	_buffer_low,W
	MOVWF	r0x100F
;	.line	115; "main.c"	for(i=0;i<sensitivity;i++){
	CLRF	r0x1010
_00220_DS_
	MOVF	_sensitivity,W
	SUBWF	r0x1010,W
	BTFSC	STATUS,0
	GOTO	_00212_DS_
;;genSkipc:3247: created from rifx:0x7ffc9084bb80
	INCF	r0x1010,F
	GOTO	_00220_DS_
_00212_DS_
;	.line	119; "main.c"	if(Hbyte != buffer_high){send_error();}
	MOVF	_buffer_high,W
;	.line	120; "main.c"	if(buffer_timer<buffer_sensetivity){dr_metal();}
	XORWF	r0x100D,W
	BTFSS	STATUS,2
	CALL	_send_error
	MOVF	r0x100F,W
;	.line	121; "main.c"	if(buffer_timer>buffer_sensetivity){bl_metal();}
	SUBWF	r0x100E,W
	BTFSS	STATUS,0
	CALL	_dr_metal
	MOVF	r0x100E,W
	SUBWF	r0x100F,W
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
;	.line	101; "main.c"	delay_ms(5);
	MOVLW	0x05
	MOVWF	STK00
	MOVLW	0x00
	CALL	_delay_ms
;	.line	102; "main.c"	if(rdbit(PTC,5)==1 && sensitivity>0){
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	ANDLW	0x20
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x100A
	MOVWF	r0x100B
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00191_DS_
	MOVLW	0x00
;	.line	103; "main.c"	sensitivity--;
	IORWF	_sensitivity,W
;	.line	105; "main.c"	delay_ms(5);
	BTFSS	STATUS,2
	DECF	_sensitivity,F
_00191_DS_
	MOVLW	0x05
	MOVWF	STK00
	MOVLW	0x00
	CALL	_delay_ms
_00193_DS_
;	.line	106; "main.c"	while(rdbit(PTC,5)==1);
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	ANDLW	0x20
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x100A
	MOVWF	r0x100B
	XORLW	0x01
	BTFSC	STATUS,2
	GOTO	_00193_DS_
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
;	.line	93; "main.c"	delay_ms(5);
	MOVLW	0x05
	MOVWF	STK00
	MOVLW	0x00
	CALL	_delay_ms
;	.line	94; "main.c"	if(rdbit(PTC,4)==1 && sensitivity<5){
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	ANDLW	0x10
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x100A
	MOVWF	r0x100B
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00168_DS_
;;unsigned compare: left < lit(0x5=5), size=1
	MOVLW	0x05
;	.line	95; "main.c"	sensitivity++;
	SUBWF	_sensitivity,W
;	.line	97; "main.c"	delay_ms(5);
	BTFSS	STATUS,0
	INCF	_sensitivity,F
_00168_DS_
	MOVLW	0x05
	MOVWF	STK00
	MOVLW	0x00
	CALL	_delay_ms
_00170_DS_
;	.line	98; "main.c"	while(rdbit(PTC,4)==1);
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	ANDLW	0x10
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x100A
	MOVWF	r0x100B
	XORLW	0x01
	BTFSC	STATUS,2
	GOTO	_00170_DS_
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
;	.line	79; "main.c"	INTF=0;
	BANKSEL	_INTCONbits
	BCF	_INTCONbits,1
_00159_DS_
;	.line	80; "main.c"	while(INTF==0);                         //wait for rising edge generator
	BANKSEL	_INTCONbits
	BTFSS	_INTCONbits,1
	GOTO	_00159_DS_
;	.line	81; "main.c"	TMR1ON=1;
	BSF	_T1CONbits,0
;	.line	82; "main.c"	INTF =0;
	BCF	_INTCONbits,1
_00162_DS_
;	.line	83; "main.c"	while(INTF==0);
	BANKSEL	_INTCONbits
	BTFSS	_INTCONbits,1
	GOTO	_00162_DS_
;	.line	84; "main.c"	TMR1ON=0;
	BCF	_T1CONbits,0
;	.line	85; "main.c"	buffer_high = TMR1H;
	MOVF	_TMR1H,W
	MOVWF	_buffer_high
;	.line	86; "main.c"	buffer_low = TMR1L;
	MOVF	_TMR1L,W
	MOVWF	_buffer_low
;	.line	87; "main.c"	TMR1L=0;
	CLRF	_TMR1L
;	.line	88; "main.c"	TMR1H=0;
	CLRF	_TMR1H
;	.line	89; "main.c"	calibration_complete=1;
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
;   _delay_ms
;   _delay_ms
;   _delay_ms
;   _delay_ms
;   _delay_ms
;   _delay_ms
;4 compiler assigned registers:
;   r0x100A
;   r0x100B
;   STK00
;   r0x100C
;; Starting pCode block
_send_error	;Function start
; 2 exit points
;	.line	68; "main.c"	while(j<100) {
	CLRF	r0x100A
	CLRF	r0x100B
;;unsigned compare: left < lit(0x64=100), size=2
_00142_DS_
	MOVLW	0x00
	SUBWF	r0x100B,W
	BTFSS	STATUS,2
	GOTO	_00154_DS_
	MOVLW	0x64
	SUBWF	r0x100A,W
_00154_DS_
	BTFSC	STATUS,0
	GOTO	_00144_DS_
;;genSkipc:3247: created from rifx:0x7ffc9084bb80
;	.line	69; "main.c"	setbit(PTC,0);
	BANKSEL	_PORTC
	BSF	_PORTC,0
;	.line	70; "main.c"	delay_ms(10);
	MOVLW	0x0a
	MOVWF	STK00
	MOVLW	0x00
	CALL	_delay_ms
;	.line	71; "main.c"	clrbit(PTC,0);
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	MOVWF	r0x100C
	MOVLW	0xfe
	ANDWF	r0x100C,W
	MOVWF	_PORTC
;	.line	72; "main.c"	delay_ms(10);
	MOVLW	0x0a
	MOVWF	STK00
	MOVLW	0x00
	CALL	_delay_ms
;	.line	73; "main.c"	j++;
	INCF	r0x100A,F
	BTFSC	STATUS,2
	INCF	r0x100B,F
	GOTO	_00142_DS_
_00144_DS_
;	.line	75; "main.c"	delay_ms(1000);
	MOVLW	0xe8
	MOVWF	STK00
	MOVLW	0x03
	CALL	_delay_ms
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
;	.line	60; "main.c"	setbit(PTC,0);
	BANKSEL	_PORTC
	BSF	_PORTC,0
;	.line	61; "main.c"	delay_ms(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	CALL	_delay_ms
;	.line	62; "main.c"	clrbit(PTC,0);
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	MOVWF	r0x100A
	MOVLW	0xfe
	ANDWF	r0x100A,W
	MOVWF	_PORTC
;	.line	63; "main.c"	delay_ms(1);
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
;   _delay_ms
;   _delay_ms
;   _delay_ms
;   _delay_ms
;2 compiler assigned registers:
;   STK00
;   r0x100A
;; Starting pCode block
_dr_metal	;Function start
; 2 exit points
;	.line	54; "main.c"	setbit(PTC,0);
	BANKSEL	_PORTC
	BSF	_PORTC,0
;	.line	55; "main.c"	delay_ms(20);
	MOVLW	0x14
	MOVWF	STK00
	MOVLW	0x00
	CALL	_delay_ms
;	.line	56; "main.c"	clrbit(PTC,0);
	BANKSEL	_PORTC
	MOVF	_PORTC,W
	MOVWF	r0x100A
	MOVLW	0xfe
	ANDWF	r0x100A,W
	MOVWF	_PORTC
;	.line	57; "main.c"	delay_ms(20);
	MOVLW	0x14
	MOVWF	STK00
	MOVLW	0x00
	CALL	_delay_ms
	RETURN	
; exit point of _dr_metal

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
;	.line	42; "main.c"	void delay_ms ( unsigned int ms) {
	MOVWF	r0x1004
	MOVF	STK00,W
	MOVWF	r0x1005
;	.line	46; "main.c"	for(i=0;i<ms;i++){
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
;;genSkipc:3247: created from rifx:0x7ffc9084bb80
;	.line	48; "main.c"	while(j<timerBuffer/50){j++;}
	CLRF	r0x1008
	CLRF	r0x1009
;;unsigned compare: left < lit(0x190=400), size=2
_00105_DS_
	MOVLW	0x01
	SUBWF	r0x1009,W
	BTFSS	STATUS,2
	GOTO	_00129_DS_
	MOVLW	0x90
	SUBWF	r0x1008,W
_00129_DS_
	BTFSC	STATUS,0
	GOTO	_00111_DS_
;;genSkipc:3247: created from rifx:0x7ffc9084bb80
	INCF	r0x1008,F
	BTFSC	STATUS,2
	INCF	r0x1009,F
	GOTO	_00105_DS_
_00111_DS_
;	.line	46; "main.c"	for(i=0;i<ms;i++){
	INCF	r0x1006,F
	BTFSC	STATUS,2
	INCF	r0x1007,F
	GOTO	_00110_DS_
_00112_DS_
	RETURN	
; exit point of _delay_ms


;	code size estimation:
;	  310+   29 =   339 instructions (  736 byte)

	end
