
_main:

;MyProject.c,1 :: 		void main() {
;MyProject.c,4 :: 		trisb=0;
	CLRF       TRISB+0
;MyProject.c,5 :: 		portb=0;
	CLRF       PORTB+0
;MyProject.c,7 :: 		uart1_init(9600);
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;MyProject.c,9 :: 		while(1)
L_main0:
;MyProject.c,11 :: 		x=adc_read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      main_x_L0+0
	MOVF       R0+1, 0
	MOVWF      main_x_L0+1
;MyProject.c,12 :: 		y=adc_read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      main_y_L0+0
	MOVF       R0+1, 0
	MOVWF      main_y_L0+1
;MyProject.c,13 :: 		inttostr(x,text);
	MOVF       main_x_L0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       main_x_L0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      main_text_L0+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,14 :: 		uart1_write_text("X=");
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyProject.c,15 :: 		uart1_write_text(text);
	MOVLW      main_text_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyProject.c,16 :: 		uart1_write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;MyProject.c,17 :: 		inttostr(y,text);
	MOVF       main_y_L0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       main_y_L0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      main_text_L0+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,18 :: 		uart1_write_text("Y=");
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyProject.c,19 :: 		uart1_write_text(text);
	MOVLW      main_text_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyProject.c,20 :: 		uart1_write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;MyProject.c,23 :: 		delay_ms(400);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
;MyProject.c,24 :: 		if(x>400&&y>400)
	MOVLW      128
	XORLW      1
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_x_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main9
	MOVF       main_x_L0+0, 0
	SUBLW      144
L__main9:
	BTFSC      STATUS+0, 0
	GOTO       L_main5
	MOVLW      128
	XORLW      1
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_y_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main10
	MOVF       main_y_L0+0, 0
	SUBLW      144
L__main10:
	BTFSC      STATUS+0, 0
	GOTO       L_main5
L__main7:
;MyProject.c,25 :: 		rb0_bit=1;
	BSF        RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_main6
L_main5:
;MyProject.c,27 :: 		rb0_bit=0;
	BCF        RB0_bit+0, BitPos(RB0_bit+0)
L_main6:
;MyProject.c,31 :: 		}
	GOTO       L_main0
;MyProject.c,33 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
