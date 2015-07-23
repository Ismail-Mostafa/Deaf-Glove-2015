
_main:

;test1.c,1 :: 		void main() {
;test1.c,7 :: 		uart1_init(9600);
	MOVLW       25
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;test1.c,9 :: 		trisc=0b10000000;
	MOVLW       128
	MOVWF       TRISC+0 
;test1.c,10 :: 		while(1)
L_main0:
;test1.c,13 :: 		f[0]=adc_read(12);
	MOVLW       12
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_f_L0+0 
	MOVF        R1, 0 
	MOVWF       main_f_L0+1 
;test1.c,14 :: 		f[1]=adc_read(10);
	MOVLW       10
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_f_L0+2 
	MOVF        R1, 0 
	MOVWF       main_f_L0+3 
;test1.c,15 :: 		f[2]=adc_read(8);
	MOVLW       8
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_f_L0+4 
	MOVF        R1, 0 
	MOVWF       main_f_L0+5 
;test1.c,16 :: 		f[3]=adc_read(9);
	MOVLW       9
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_f_L0+6 
	MOVF        R1, 0 
	MOVWF       main_f_L0+7 
;test1.c,17 :: 		f[4]=adc_read(11);
	MOVLW       11
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_f_L0+8 
	MOVF        R1, 0 
	MOVWF       main_f_L0+9 
;test1.c,18 :: 		x=adc_read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
;test1.c,19 :: 		y=adc_read(1);
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_y_L0+0 
	MOVF        R1, 0 
	MOVWF       main_y_L0+1 
;test1.c,56 :: 		if(f[1]<180&&f[2]<180)
	MOVLW       128
	XORWF       main_f_L0+3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main13
	MOVLW       180
	SUBWF       main_f_L0+2, 0 
L__main13:
	BTFSC       STATUS+0, 0 
	GOTO        L_main4
	MOVLW       128
	XORWF       main_f_L0+5, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main14
	MOVLW       180
	SUBWF       main_f_L0+4, 0 
L__main14:
	BTFSC       STATUS+0, 0 
	GOTO        L_main4
L__main12:
;test1.c,58 :: 		uart1_write('c');
	MOVLW       99
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;test1.c,59 :: 		delay_ms(5000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 0
	BRA         L_main5
	DECFSZ      R12, 1, 0
	BRA         L_main5
	DECFSZ      R11, 1, 0
	BRA         L_main5
	NOP
;test1.c,60 :: 		}
	GOTO        L_main6
L_main4:
;test1.c,64 :: 		else if(f[1]>200&&f[2]>200&&y>370)
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       main_f_L0+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main15
	MOVF        main_f_L0+2, 0 
	SUBLW       200
L__main15:
	BTFSC       STATUS+0, 0 
	GOTO        L_main9
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       main_f_L0+5, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main16
	MOVF        main_f_L0+4, 0 
	SUBLW       200
L__main16:
	BTFSC       STATUS+0, 0 
	GOTO        L_main9
	MOVLW       128
	XORLW       1
	MOVWF       R0 
	MOVLW       128
	XORWF       main_y_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main17
	MOVF        main_y_L0+0, 0 
	SUBLW       114
L__main17:
	BTFSC       STATUS+0, 0 
	GOTO        L_main9
L__main11:
;test1.c,66 :: 		uart1_write('b');
	MOVLW       98
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;test1.c,67 :: 		delay_ms(5000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_main10:
	DECFSZ      R13, 1, 0
	BRA         L_main10
	DECFSZ      R12, 1, 0
	BRA         L_main10
	DECFSZ      R11, 1, 0
	BRA         L_main10
	NOP
;test1.c,68 :: 		}
L_main9:
L_main6:
;test1.c,71 :: 		}
	GOTO        L_main0
;test1.c,73 :: 		}
	GOTO        $+0
; end of _main
