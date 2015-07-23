
_audio:

;test1.c,5 :: 		void audio(int x)
;test1.c,9 :: 		DI=0;
	BCF         RC1_bit+0, 1 
;test1.c,10 :: 		CLK=0;
	BCF         RC0_bit+0, 0 
;test1.c,11 :: 		delay_us(1800);
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_audio0:
	DECFSZ      R13, 1, 0
	BRA         L_audio0
	DECFSZ      R12, 1, 0
	BRA         L_audio0
;test1.c,13 :: 		for(i=15;i>=0;i--)
	MOVLW       15
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
L_audio1:
	MOVLW       128
	XORWF       R4, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__audio45
	MOVLW       0
	SUBWF       R3, 0 
L__audio45:
	BTFSS       STATUS+0, 0 
	GOTO        L_audio2
;test1.c,15 :: 		DI=(x>>i)&1;
	MOVF        R3, 0 
	MOVWF       R2 
	MOVF        FARG_audio_x+0, 0 
	MOVWF       R0 
	MOVF        FARG_audio_x+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__audio46:
	BZ          L__audio47
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__audio46
L__audio47:
	MOVLW       1
	ANDWF       R0, 0 
	MOVWF       R0 
	BTFSC       R0, 0 
	GOTO        L__audio48
	BCF         RC1_bit+0, 1 
	GOTO        L__audio49
L__audio48:
	BSF         RC1_bit+0, 1 
L__audio49:
;test1.c,16 :: 		CLK=0;
	BCF         RC0_bit+0, 0 
;test1.c,17 :: 		delay_us(200);
	MOVLW       66
	MOVWF       R13, 0
L_audio4:
	DECFSZ      R13, 1, 0
	BRA         L_audio4
	NOP
;test1.c,18 :: 		CLK=1;
	BSF         RC0_bit+0, 0 
;test1.c,19 :: 		delay_us(200);
	MOVLW       66
	MOVWF       R13, 0
L_audio5:
	DECFSZ      R13, 1, 0
	BRA         L_audio5
	NOP
;test1.c,13 :: 		for(i=15;i>=0;i--)
	MOVLW       1
	SUBWF       R3, 1 
	MOVLW       0
	SUBWFB      R4, 1 
;test1.c,20 :: 		}
	GOTO        L_audio1
L_audio2:
;test1.c,22 :: 		delay_ms(2);
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       151
	MOVWF       R13, 0
L_audio6:
	DECFSZ      R13, 1, 0
	BRA         L_audio6
	DECFSZ      R12, 1, 0
	BRA         L_audio6
	NOP
	NOP
;test1.c,23 :: 		DI=1;
	BSF         RC1_bit+0, 1 
;test1.c,24 :: 		CLK=1;
	BSF         RC0_bit+0, 0 
;test1.c,25 :: 		}
	RETURN      0
; end of _audio

_main:

;test1.c,29 :: 		void main() {
;test1.c,35 :: 		uart1_init(9600);
	MOVLW       25
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;test1.c,37 :: 		trisc=0b10000000;
	MOVLW       128
	MOVWF       TRISC+0 
;test1.c,38 :: 		DI=1;
	BSF         RC1_bit+0, 1 
;test1.c,39 :: 		CLK=1;
	BSF         RC0_bit+0, 0 
;test1.c,40 :: 		uart1_write_text("hello");
	MOVLW       ?lstr1_test1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_test1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;test1.c,41 :: 		while(1)
L_main7:
;test1.c,43 :: 		if(uart1_data_ready())
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main9
;test1.c,45 :: 		rec=uart1_read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_rec_L0+0 
;test1.c,46 :: 		if(rec=='1')
	MOVF        R0, 0 
	XORLW       49
	BTFSS       STATUS+0, 2 
	GOTO        L_main10
;test1.c,47 :: 		audio(1);
	MOVLW       1
	MOVWF       FARG_audio_x+0 
	MOVLW       0
	MOVWF       FARG_audio_x+1 
	CALL        _audio+0, 0
L_main10:
;test1.c,48 :: 		if(rec=='2')
	MOVF        main_rec_L0+0, 0 
	XORLW       50
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
;test1.c,49 :: 		audio(2);
	MOVLW       2
	MOVWF       FARG_audio_x+0 
	MOVLW       0
	MOVWF       FARG_audio_x+1 
	CALL        _audio+0, 0
L_main11:
;test1.c,50 :: 		if(rec=='3')
	MOVF        main_rec_L0+0, 0 
	XORLW       51
	BTFSS       STATUS+0, 2 
	GOTO        L_main12
;test1.c,51 :: 		audio(3);
	MOVLW       3
	MOVWF       FARG_audio_x+0 
	MOVLW       0
	MOVWF       FARG_audio_x+1 
	CALL        _audio+0, 0
L_main12:
;test1.c,52 :: 		if(rec=='4')
	MOVF        main_rec_L0+0, 0 
	XORLW       52
	BTFSS       STATUS+0, 2 
	GOTO        L_main13
;test1.c,53 :: 		audio(4);
	MOVLW       4
	MOVWF       FARG_audio_x+0 
	MOVLW       0
	MOVWF       FARG_audio_x+1 
	CALL        _audio+0, 0
L_main13:
;test1.c,54 :: 		if(rec=='5')
	MOVF        main_rec_L0+0, 0 
	XORLW       53
	BTFSS       STATUS+0, 2 
	GOTO        L_main14
;test1.c,55 :: 		audio(5);
	MOVLW       5
	MOVWF       FARG_audio_x+0 
	MOVLW       0
	MOVWF       FARG_audio_x+1 
	CALL        _audio+0, 0
L_main14:
;test1.c,56 :: 		}
L_main9:
;test1.c,58 :: 		f[0]=adc_read(12);
	MOVLW       12
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_f_L0+0 
	MOVF        R1, 0 
	MOVWF       main_f_L0+1 
;test1.c,59 :: 		f[1]=adc_read(10);
	MOVLW       10
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_f_L0+2 
	MOVF        R1, 0 
	MOVWF       main_f_L0+3 
;test1.c,60 :: 		f[2]=adc_read(8);
	MOVLW       8
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_f_L0+4 
	MOVF        R1, 0 
	MOVWF       main_f_L0+5 
;test1.c,61 :: 		f[3]=adc_read(9);
	MOVLW       9
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_f_L0+6 
	MOVF        R1, 0 
	MOVWF       main_f_L0+7 
;test1.c,62 :: 		f[4]=adc_read(11);
	MOVLW       11
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_f_L0+8 
	MOVF        R1, 0 
	MOVWF       main_f_L0+9 
;test1.c,63 :: 		x=adc_read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_x_L0+0 
	MOVF        R1, 0 
	MOVWF       main_x_L0+1 
;test1.c,64 :: 		y=adc_read(1);
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_y_L0+0 
	MOVF        R1, 0 
	MOVWF       main_y_L0+1 
;test1.c,65 :: 		inttostr(f[0],send);
	MOVF        main_f_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        main_f_L0+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_send_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_send_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;test1.c,66 :: 		uart1_write_text("f0=");
	MOVLW       ?lstr2_test1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_test1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;test1.c,67 :: 		uart1_write_text(send);
	MOVLW       main_send_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_send_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;test1.c,68 :: 		uart1_write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;test1.c,69 :: 		IntToStr(f[1],send);
	MOVF        main_f_L0+2, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        main_f_L0+3, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_send_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_send_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;test1.c,70 :: 		uart1_write_text("f1=");
	MOVLW       ?lstr3_test1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_test1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;test1.c,71 :: 		uart1_write_text(send);
	MOVLW       main_send_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_send_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;test1.c,72 :: 		uart1_write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;test1.c,73 :: 		IntToStr(f[2],send);
	MOVF        main_f_L0+4, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        main_f_L0+5, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_send_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_send_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;test1.c,74 :: 		uart1_write_text("f2=");
	MOVLW       ?lstr4_test1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr4_test1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;test1.c,75 :: 		uart1_write_text(send);
	MOVLW       main_send_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_send_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;test1.c,76 :: 		uart1_write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;test1.c,77 :: 		IntToStr(f[3],send);
	MOVF        main_f_L0+6, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        main_f_L0+7, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_send_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_send_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;test1.c,78 :: 		uart1_write_text("f3=");
	MOVLW       ?lstr5_test1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_test1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;test1.c,79 :: 		uart1_write_text(send);
	MOVLW       main_send_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_send_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;test1.c,80 :: 		uart1_write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;test1.c,81 :: 		IntToStr(f[4],send);
	MOVF        main_f_L0+8, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        main_f_L0+9, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_send_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_send_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;test1.c,82 :: 		uart1_write_text("f4=");
	MOVLW       ?lstr6_test1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr6_test1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;test1.c,83 :: 		uart1_write_text(send);
	MOVLW       main_send_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_send_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;test1.c,84 :: 		uart1_write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;test1.c,85 :: 		IntToStr(x,send);
	MOVF        main_x_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        main_x_L0+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_send_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_send_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;test1.c,86 :: 		uart1_write_text("x=");
	MOVLW       ?lstr7_test1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr7_test1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;test1.c,87 :: 		uart1_write_text(send);
	MOVLW       main_send_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_send_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;test1.c,88 :: 		uart1_write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;test1.c,89 :: 		IntToStr(y,send);
	MOVF        main_y_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        main_y_L0+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_send_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_send_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;test1.c,90 :: 		uart1_write_text("y=");
	MOVLW       ?lstr8_test1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr8_test1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;test1.c,91 :: 		uart1_write_text(send);
	MOVLW       main_send_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_send_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;test1.c,92 :: 		uart1_write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;test1.c,93 :: 		delay_ms(1000);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main15:
	DECFSZ      R13, 1, 0
	BRA         L_main15
	DECFSZ      R12, 1, 0
	BRA         L_main15
	DECFSZ      R11, 1, 0
	BRA         L_main15
	NOP
	NOP
;test1.c,96 :: 		if(f[0]<170&&f[1]<180&&f[2]<180&&f[3]>250)
	MOVLW       128
	XORWF       main_f_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main50
	MOVLW       170
	SUBWF       main_f_L0+0, 0 
L__main50:
	BTFSC       STATUS+0, 0 
	GOTO        L_main18
	MOVLW       128
	XORWF       main_f_L0+3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main51
	MOVLW       180
	SUBWF       main_f_L0+2, 0 
L__main51:
	BTFSC       STATUS+0, 0 
	GOTO        L_main18
	MOVLW       128
	XORWF       main_f_L0+5, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main52
	MOVLW       180
	SUBWF       main_f_L0+4, 0 
L__main52:
	BTFSC       STATUS+0, 0 
	GOTO        L_main18
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       main_f_L0+7, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main53
	MOVF        main_f_L0+6, 0 
	SUBLW       250
L__main53:
	BTFSC       STATUS+0, 0 
	GOTO        L_main18
L__main44:
;test1.c,98 :: 		audio(2);
	MOVLW       2
	MOVWF       FARG_audio_x+0 
	MOVLW       0
	MOVWF       FARG_audio_x+1 
	CALL        _audio+0, 0
;test1.c,99 :: 		delay_ms(5000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_main19:
	DECFSZ      R13, 1, 0
	BRA         L_main19
	DECFSZ      R12, 1, 0
	BRA         L_main19
	DECFSZ      R11, 1, 0
	BRA         L_main19
	NOP
;test1.c,100 :: 		}
	GOTO        L_main20
L_main18:
;test1.c,102 :: 		else if(f[0]<170&&f[1]<180&&f[2]<180&&f[3]<170&&rec!='c')
	MOVLW       128
	XORWF       main_f_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main54
	MOVLW       170
	SUBWF       main_f_L0+0, 0 
L__main54:
	BTFSC       STATUS+0, 0 
	GOTO        L_main23
	MOVLW       128
	XORWF       main_f_L0+3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main55
	MOVLW       180
	SUBWF       main_f_L0+2, 0 
L__main55:
	BTFSC       STATUS+0, 0 
	GOTO        L_main23
	MOVLW       128
	XORWF       main_f_L0+5, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main56
	MOVLW       180
	SUBWF       main_f_L0+4, 0 
L__main56:
	BTFSC       STATUS+0, 0 
	GOTO        L_main23
	MOVLW       128
	XORWF       main_f_L0+7, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main57
	MOVLW       170
	SUBWF       main_f_L0+6, 0 
L__main57:
	BTFSC       STATUS+0, 0 
	GOTO        L_main23
	MOVF        main_rec_L0+0, 0 
	XORLW       99
	BTFSC       STATUS+0, 2 
	GOTO        L_main23
L__main43:
;test1.c,104 :: 		audio(1);
	MOVLW       1
	MOVWF       FARG_audio_x+0 
	MOVLW       0
	MOVWF       FARG_audio_x+1 
	CALL        _audio+0, 0
;test1.c,105 :: 		delay_ms(5000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_main24:
	DECFSZ      R13, 1, 0
	BRA         L_main24
	DECFSZ      R12, 1, 0
	BRA         L_main24
	DECFSZ      R11, 1, 0
	BRA         L_main24
	NOP
;test1.c,106 :: 		}
	GOTO        L_main25
L_main23:
;test1.c,109 :: 		else if(f[0]>230&&f[1]>230&&f[2]>230&&f[3]>230&&x<280)
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       main_f_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main58
	MOVF        main_f_L0+0, 0 
	SUBLW       230
L__main58:
	BTFSC       STATUS+0, 0 
	GOTO        L_main28
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       main_f_L0+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main59
	MOVF        main_f_L0+2, 0 
	SUBLW       230
L__main59:
	BTFSC       STATUS+0, 0 
	GOTO        L_main28
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       main_f_L0+5, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main60
	MOVF        main_f_L0+4, 0 
	SUBLW       230
L__main60:
	BTFSC       STATUS+0, 0 
	GOTO        L_main28
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       main_f_L0+7, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main61
	MOVF        main_f_L0+6, 0 
	SUBLW       230
L__main61:
	BTFSC       STATUS+0, 0 
	GOTO        L_main28
	MOVLW       128
	XORWF       main_x_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main62
	MOVLW       24
	SUBWF       main_x_L0+0, 0 
L__main62:
	BTFSC       STATUS+0, 0 
	GOTO        L_main28
L__main42:
;test1.c,111 :: 		audio(3);
	MOVLW       3
	MOVWF       FARG_audio_x+0 
	MOVLW       0
	MOVWF       FARG_audio_x+1 
	CALL        _audio+0, 0
;test1.c,112 :: 		delay_ms(5000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_main29:
	DECFSZ      R13, 1, 0
	BRA         L_main29
	DECFSZ      R12, 1, 0
	BRA         L_main29
	DECFSZ      R11, 1, 0
	BRA         L_main29
	NOP
;test1.c,113 :: 		}
	GOTO        L_main30
L_main28:
;test1.c,117 :: 		else if(f[0]<170&&f[1]<180&&f[2]<180&&f[3]<170&&rec=='c')
	MOVLW       128
	XORWF       main_f_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main63
	MOVLW       170
	SUBWF       main_f_L0+0, 0 
L__main63:
	BTFSC       STATUS+0, 0 
	GOTO        L_main33
	MOVLW       128
	XORWF       main_f_L0+3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main64
	MOVLW       180
	SUBWF       main_f_L0+2, 0 
L__main64:
	BTFSC       STATUS+0, 0 
	GOTO        L_main33
	MOVLW       128
	XORWF       main_f_L0+5, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main65
	MOVLW       180
	SUBWF       main_f_L0+4, 0 
L__main65:
	BTFSC       STATUS+0, 0 
	GOTO        L_main33
	MOVLW       128
	XORWF       main_f_L0+7, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main66
	MOVLW       170
	SUBWF       main_f_L0+6, 0 
L__main66:
	BTFSC       STATUS+0, 0 
	GOTO        L_main33
	MOVF        main_rec_L0+0, 0 
	XORLW       99
	BTFSS       STATUS+0, 2 
	GOTO        L_main33
L__main41:
;test1.c,119 :: 		audio(4);
	MOVLW       4
	MOVWF       FARG_audio_x+0 
	MOVLW       0
	MOVWF       FARG_audio_x+1 
	CALL        _audio+0, 0
;test1.c,120 :: 		rec=0;
	CLRF        main_rec_L0+0 
;test1.c,121 :: 		delay_ms(5000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_main34:
	DECFSZ      R13, 1, 0
	BRA         L_main34
	DECFSZ      R12, 1, 0
	BRA         L_main34
	DECFSZ      R11, 1, 0
	BRA         L_main34
	NOP
;test1.c,122 :: 		}
	GOTO        L_main35
L_main33:
;test1.c,124 :: 		else if(f[0]>230&&f[1]>230&&f[2]>230&&f[3]>230&&x>350&&rec=='b')
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       main_f_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main67
	MOVF        main_f_L0+0, 0 
	SUBLW       230
L__main67:
	BTFSC       STATUS+0, 0 
	GOTO        L_main38
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       main_f_L0+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main68
	MOVF        main_f_L0+2, 0 
	SUBLW       230
L__main68:
	BTFSC       STATUS+0, 0 
	GOTO        L_main38
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       main_f_L0+5, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main69
	MOVF        main_f_L0+4, 0 
	SUBLW       230
L__main69:
	BTFSC       STATUS+0, 0 
	GOTO        L_main38
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       main_f_L0+7, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main70
	MOVF        main_f_L0+6, 0 
	SUBLW       230
L__main70:
	BTFSC       STATUS+0, 0 
	GOTO        L_main38
	MOVLW       128
	XORLW       1
	MOVWF       R0 
	MOVLW       128
	XORWF       main_x_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main71
	MOVF        main_x_L0+0, 0 
	SUBLW       94
L__main71:
	BTFSC       STATUS+0, 0 
	GOTO        L_main38
	MOVF        main_rec_L0+0, 0 
	XORLW       98
	BTFSS       STATUS+0, 2 
	GOTO        L_main38
L__main40:
;test1.c,126 :: 		audio(5);
	MOVLW       5
	MOVWF       FARG_audio_x+0 
	MOVLW       0
	MOVWF       FARG_audio_x+1 
	CALL        _audio+0, 0
;test1.c,127 :: 		rec=0;
	CLRF        main_rec_L0+0 
;test1.c,128 :: 		delay_ms(5000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_main39:
	DECFSZ      R13, 1, 0
	BRA         L_main39
	DECFSZ      R12, 1, 0
	BRA         L_main39
	DECFSZ      R11, 1, 0
	BRA         L_main39
	NOP
;test1.c,129 :: 		}
L_main38:
L_main35:
L_main30:
L_main25:
L_main20:
;test1.c,132 :: 		}
	GOTO        L_main7
;test1.c,134 :: 		}
	GOTO        $+0
; end of _main
