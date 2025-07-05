
_Display_Value:

;Second_node_Duplex.c,35 :: 		void Display_Value(unsigned int value, char row, char col) {
;Second_node_Duplex.c,36 :: 		Lcd_Out(row, col, "    "); // Clear old value
	MOVF       FARG_Display_Value_row+0, 0
	MOVWF      FARG_Lcd_Out_row+0
	MOVF       FARG_Display_Value_col+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Second_node_Duplex+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Second_node_Duplex.c,37 :: 		Lcd_Chr(row, col+0, value/1000 + '0');
	MOVF       FARG_Display_Value_row+0, 0
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       FARG_Display_Value_col+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	MOVF       FARG_Display_Value_value+0, 0
	MOVWF      R0+0
	MOVF       FARG_Display_Value_value+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Second_node_Duplex.c,38 :: 		Lcd_Chr(row, col+1, (value/100)%10 + '0');
	MOVF       FARG_Display_Value_row+0, 0
	MOVWF      FARG_Lcd_Chr_row+0
	INCF       FARG_Display_Value_col+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_Display_Value_value+0, 0
	MOVWF      R0+0
	MOVF       FARG_Display_Value_value+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Second_node_Duplex.c,39 :: 		Lcd_Chr(row, col+2, (value/10)%10 + '0');
	MOVF       FARG_Display_Value_row+0, 0
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      2
	ADDWF      FARG_Display_Value_col+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_Display_Value_value+0, 0
	MOVWF      R0+0
	MOVF       FARG_Display_Value_value+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Second_node_Duplex.c,40 :: 		Lcd_Chr(row, col+3, value%10 + '0');
	MOVF       FARG_Display_Value_row+0, 0
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      3
	ADDWF      FARG_Display_Value_col+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_Display_Value_value+0, 0
	MOVWF      R0+0
	MOVF       FARG_Display_Value_value+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Second_node_Duplex.c,41 :: 		}
L_end_Display_Value:
	RETURN
; end of _Display_Value

_main:

;Second_node_Duplex.c,43 :: 		void main() {
;Second_node_Duplex.c,44 :: 		ADCON1 = 0x80; // Configure AN0-AN1 as analog
	MOVLW      128
	MOVWF      ADCON1+0
;Second_node_Duplex.c,45 :: 		TRISA = 0xFF;  // AN1 input on RA1
	MOVLW      255
	MOVWF      TRISA+0
;Second_node_Duplex.c,47 :: 		SPI1_Init();
	CALL       _SPI1_Init+0
;Second_node_Duplex.c,48 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;Second_node_Duplex.c,49 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Second_node_Duplex.c,50 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Second_node_Duplex.c,53 :: 		Can_Send_Flags = _CANSPI_TX_PRIORITY_0 & _CANSPI_TX_XTD_FRAME & _CANSPI_TX_NO_RTR_FRAME;
	MOVLW      244
	MOVWF      _Can_Send_Flags+0
;Second_node_Duplex.c,56 :: 		_CANSPI_CONFIG_VALID_XTD_MSG & _CANSPI_CONFIG_LINE_FILTER_OFF;
	MOVLW      209
	MOVWF      _Can_Init_Flags+0
;Second_node_Duplex.c,58 :: 		CANSPIInitialize(1,3,3,3,1,Can_Init_Flags);
	MOVLW      1
	MOVWF      FARG_CANSPIInitialize_SJW+0
	MOVLW      3
	MOVWF      FARG_CANSPIInitialize_BRP+0
	MOVLW      3
	MOVWF      FARG_CANSPIInitialize_PHSEG1+0
	MOVLW      3
	MOVWF      FARG_CANSPIInitialize_PHSEG2+0
	MOVLW      1
	MOVWF      FARG_CANSPIInitialize_PROPSEG+0
	MOVLW      209
	MOVWF      FARG_CANSPIInitialize_CANSPI_CONFIG_FLAGS+0
	CALL       _CANSPIInitialize+0
;Second_node_Duplex.c,59 :: 		CANSPISetOperationMode(_CANSPI_MODE_CONFIG,0xFF);
	MOVLW      128
	MOVWF      FARG_CANSPISetOperationMode_mode+0
	MOVLW      255
	MOVWF      FARG_CANSPISetOperationMode_WAIT+0
	CALL       _CANSPISetOperationMode+0
;Second_node_Duplex.c,60 :: 		CANSPISetMask(_CANSPI_MASK_B1,-1,_CANSPI_CONFIG_XTD_MSG);
	CLRF       FARG_CANSPISetMask_CANSPI_MASK+0
	MOVLW      255
	MOVWF      FARG_CANSPISetMask_val+0
	MOVLW      255
	MOVWF      FARG_CANSPISetMask_val+1
	MOVWF      FARG_CANSPISetMask_val+2
	MOVWF      FARG_CANSPISetMask_val+3
	MOVLW      247
	MOVWF      FARG_CANSPISetMask_CANSPI_CONFIG_FLAGS+0
	CALL       _CANSPISetMask+0
;Second_node_Duplex.c,61 :: 		CANSPISetMask(_CANSPI_MASK_B2,-1,_CANSPI_CONFIG_XTD_MSG);
	MOVLW      1
	MOVWF      FARG_CANSPISetMask_CANSPI_MASK+0
	MOVLW      255
	MOVWF      FARG_CANSPISetMask_val+0
	MOVLW      255
	MOVWF      FARG_CANSPISetMask_val+1
	MOVWF      FARG_CANSPISetMask_val+2
	MOVWF      FARG_CANSPISetMask_val+3
	MOVLW      247
	MOVWF      FARG_CANSPISetMask_CANSPI_CONFIG_FLAGS+0
	CALL       _CANSPISetMask+0
;Second_node_Duplex.c,62 :: 		CANSPISetFilter(_CANSPI_FILTER_B2_F3,ID_1st,_CANSPI_CONFIG_XTD_MSG);
	MOVLW      4
	MOVWF      FARG_CANSPISetFilter_CANSPI_FILTER+0
	MOVLW      79
	MOVWF      FARG_CANSPISetFilter_val+0
	MOVLW      47
	MOVWF      FARG_CANSPISetFilter_val+1
	MOVLW      0
	MOVWF      FARG_CANSPISetFilter_val+2
	MOVLW      0
	MOVWF      FARG_CANSPISetFilter_val+3
	MOVLW      247
	MOVWF      FARG_CANSPISetFilter_CANSPI_CONFIG_FLAGS+0
	CALL       _CANSPISetFilter+0
;Second_node_Duplex.c,63 :: 		CANSPISetOperationMode(_CANSPI_MODE_NORMAL,0xFF);
	CLRF       FARG_CANSPISetOperationMode_mode+0
	MOVLW      255
	MOVWF      FARG_CANSPISetOperationMode_WAIT+0
	CALL       _CANSPISetOperationMode+0
;Second_node_Duplex.c,65 :: 		while(1){
L_main0:
;Second_node_Duplex.c,70 :: 		Msg_Rcvd = CANSPIRead(&Rx_ID, RxTx_Data, &Rx_Data_Len, &Can_Rcv_Flags);
	MOVLW      _Rx_ID+0
	MOVWF      FARG_CANSPIRead_id+0
	MOVLW      _RxTx_Data+0
	MOVWF      FARG_CANSPIRead_rd_data+0
	MOVLW      _Rx_Data_Len+0
	MOVWF      FARG_CANSPIRead_data_len+0
	MOVLW      _Can_Rcv_Flags+0
	MOVWF      FARG_CANSPIRead_CANSPI_RX_MSG_FLAGS+0
	CALL       _CANSPIRead+0
	MOVF       R0+0, 0
	MOVWF      _Msg_Rcvd+0
;Second_node_Duplex.c,71 :: 		if ((Rx_ID == ID_1st) && Msg_Rcvd && Rx_Data_Len == 2) {
	MOVF       _Rx_ID+3, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main9
	MOVF       _Rx_ID+2, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main9
	MOVF       _Rx_ID+1, 0
	XORLW      47
	BTFSS      STATUS+0, 2
	GOTO       L__main9
	MOVF       _Rx_ID+0, 0
	XORLW      79
L__main9:
	BTFSS      STATUS+0, 2
	GOTO       L_main4
	MOVF       _Msg_Rcvd+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main4
	MOVF       _Rx_Data_Len+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main4
L__main6:
;Second_node_Duplex.c,72 :: 		received_value = ((unsigned int)RxTx_Data[0] << 8) | RxTx_Data[1];
	MOVF       _RxTx_Data+0, 0
	MOVWF      _received_value+0
	CLRF       _received_value+1
	MOVF       _received_value+0, 0
	MOVWF      _received_value+1
	CLRF       _received_value+0
	MOVF       _RxTx_Data+1, 0
	IORWF      _received_value+0, 1
	MOVLW      0
	IORWF      _received_value+1, 1
;Second_node_Duplex.c,73 :: 		Lcd_Out(2,1,"RXD2:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_Second_node_Duplex+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Second_node_Duplex.c,74 :: 		Lcd_Cmd(0xC6);
	MOVLW      198
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Second_node_Duplex.c,75 :: 		Lcd_Chr_Cp(received_value/1000+'0');
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	MOVF       _received_value+0, 0
	MOVWF      R0+0
	MOVF       _received_value+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Second_node_Duplex.c,76 :: 		Lcd_Chr_Cp(((received_value/100)%10)+'0');
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _received_value+0, 0
	MOVWF      R0+0
	MOVF       _received_value+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Second_node_Duplex.c,77 :: 		Lcd_Chr_Cp(((received_value/10)%10)+'0');
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _received_value+0, 0
	MOVWF      R0+0
	MOVF       _received_value+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Second_node_Duplex.c,78 :: 		Lcd_Chr_Cp((received_value%10)+'0');
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _received_value+0, 0
	MOVWF      R0+0
	MOVF       _received_value+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Second_node_Duplex.c,79 :: 		Lcd_Out(2,11,"     ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_Second_node_Duplex+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Second_node_Duplex.c,81 :: 		received_value = ADC_Read(0); // 10-bit ADC
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _received_value+0
	MOVF       R0+1, 0
	MOVWF      _received_value+1
;Second_node_Duplex.c,83 :: 		RxTx_Data[0] = received_value>> 8;     // MSB
	MOVF       R0+1, 0
	MOVWF      R2+0
	CLRF       R2+1
	MOVF       R2+0, 0
	MOVWF      _RxTx_Data+0
;Second_node_Duplex.c,84 :: 		RxTx_Data[1] = received_value & 0xFF;   // LSB
	MOVLW      255
	ANDWF      R0+0, 0
	MOVWF      _RxTx_Data+1
;Second_node_Duplex.c,85 :: 		CANSPIWrite(ID_2nd, RxTx_Data, 2, Can_Send_Flags);
	MOVLW      113
	MOVWF      FARG_CANSPIWrite_id+0
	MOVLW      43
	MOVWF      FARG_CANSPIWrite_id+1
	MOVLW      0
	MOVWF      FARG_CANSPIWrite_id+2
	MOVLW      0
	MOVWF      FARG_CANSPIWrite_id+3
	MOVLW      _RxTx_Data+0
	MOVWF      FARG_CANSPIWrite_wr_data+0
	MOVLW      2
	MOVWF      FARG_CANSPIWrite_data_len+0
	MOVF       _Can_Send_Flags+0, 0
	MOVWF      FARG_CANSPIWrite_CANSPI_TX_MSG_FLAGS+0
	CALL       _CANSPIWrite+0
;Second_node_Duplex.c,86 :: 		Lcd_Out(1,1,"TXD1:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_Second_node_Duplex+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Second_node_Duplex.c,93 :: 		Display_Value(received_value, 1, 6);
	MOVF       _received_value+0, 0
	MOVWF      FARG_Display_Value_value+0
	MOVF       _received_value+1, 0
	MOVWF      FARG_Display_Value_value+1
	MOVLW      1
	MOVWF      FARG_Display_Value_row+0
	MOVLW      6
	MOVWF      FARG_Display_Value_col+0
	CALL       _Display_Value+0
;Second_node_Duplex.c,94 :: 		}
L_main4:
;Second_node_Duplex.c,96 :: 		Delay_ms(200);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
	NOP
;Second_node_Duplex.c,97 :: 		}
	GOTO       L_main0
;Second_node_Duplex.c,98 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
