
_Display_Value:

;First_node_Duplex.c,130 :: 		void Display_Value(unsigned int value, char row, char col) {
;First_node_Duplex.c,132 :: 		buf[0] = value / 1000 + '0';
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
	ADDWF      R0+0, 1
	MOVF       R0+0, 0
	MOVWF      Display_Value_buf_L0+0
;First_node_Duplex.c,133 :: 		buf[1] = (value / 100) % 10 + '0';
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
	MOVWF      Display_Value_buf_L0+1
;First_node_Duplex.c,134 :: 		buf[2] = (value / 10) % 10 + '0';
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
	MOVWF      Display_Value_buf_L0+2
;First_node_Duplex.c,135 :: 		buf[3] = value % 10 + '0';
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
	MOVWF      Display_Value_buf_L0+3
;First_node_Duplex.c,136 :: 		buf[4] = '\0';
	CLRF       Display_Value_buf_L0+4
;First_node_Duplex.c,137 :: 		Lcd_Out(row, col, buf);
	MOVF       FARG_Display_Value_row+0, 0
	MOVWF      FARG_Lcd_Out_row+0
	MOVF       FARG_Display_Value_col+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      Display_Value_buf_L0+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;First_node_Duplex.c,138 :: 		}
L_end_Display_Value:
	RETURN
; end of _Display_Value

_Init_CAN_LCD_ADC:

;First_node_Duplex.c,140 :: 		void Init_CAN_LCD_ADC() {
;First_node_Duplex.c,141 :: 		ADCON1 = 0x80;  // AN0 analog
	MOVLW      128
	MOVWF      ADCON1+0
;First_node_Duplex.c,142 :: 		TRISA = 0xFF;
	MOVLW      255
	MOVWF      TRISA+0
;First_node_Duplex.c,144 :: 		SPI1_Init();
	CALL       _SPI1_Init+0
;First_node_Duplex.c,145 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;First_node_Duplex.c,146 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;First_node_Duplex.c,147 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;First_node_Duplex.c,149 :: 		Can_Send_Flags = _CANSPI_TX_PRIORITY_0 & _CANSPI_TX_XTD_FRAME & _CANSPI_TX_NO_RTR_FRAME;
	MOVLW      244
	MOVWF      _Can_Send_Flags+0
;First_node_Duplex.c,152 :: 		_CANSPI_CONFIG_VALID_XTD_MSG & _CANSPI_CONFIG_LINE_FILTER_OFF;
	MOVLW      209
	MOVWF      _Can_Init_Flags+0
;First_node_Duplex.c,154 :: 		CANSPIInitialize(1,3,3,3,1,Can_Init_Flags);
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
;First_node_Duplex.c,155 :: 		CANSPISetOperationMode(_CANSPI_MODE_CONFIG, 0xFF);
	MOVLW      128
	MOVWF      FARG_CANSPISetOperationMode_mode+0
	MOVLW      255
	MOVWF      FARG_CANSPISetOperationMode_WAIT+0
	CALL       _CANSPISetOperationMode+0
;First_node_Duplex.c,156 :: 		CANSPISetMask(_CANSPI_MASK_B1, -1, _CANSPI_CONFIG_XTD_MSG);
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
;First_node_Duplex.c,157 :: 		CANSPISetMask(_CANSPI_MASK_B2, -1, _CANSPI_CONFIG_XTD_MSG);
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
;First_node_Duplex.c,158 :: 		CANSPISetFilter(_CANSPI_FILTER_B2_F3, ID_B, _CANSPI_CONFIG_XTD_MSG);
	MOVLW      4
	MOVWF      FARG_CANSPISetFilter_CANSPI_FILTER+0
	MOVLW      101
	MOVWF      FARG_CANSPISetFilter_val+0
	MOVLW      0
	MOVWF      FARG_CANSPISetFilter_val+1
	MOVLW      0
	MOVWF      FARG_CANSPISetFilter_val+2
	MOVLW      0
	MOVWF      FARG_CANSPISetFilter_val+3
	MOVLW      247
	MOVWF      FARG_CANSPISetFilter_CANSPI_CONFIG_FLAGS+0
	CALL       _CANSPISetFilter+0
;First_node_Duplex.c,159 :: 		CANSPISetFilter(_CANSPI_FILTER_B2_F4, ID_C, _CANSPI_CONFIG_XTD_MSG);
	MOVLW      5
	MOVWF      FARG_CANSPISetFilter_CANSPI_FILTER+0
	MOVLW      102
	MOVWF      FARG_CANSPISetFilter_val+0
	MOVLW      0
	MOVWF      FARG_CANSPISetFilter_val+1
	MOVLW      0
	MOVWF      FARG_CANSPISetFilter_val+2
	MOVLW      0
	MOVWF      FARG_CANSPISetFilter_val+3
	MOVLW      247
	MOVWF      FARG_CANSPISetFilter_CANSPI_CONFIG_FLAGS+0
	CALL       _CANSPISetFilter+0
;First_node_Duplex.c,160 :: 		CANSPISetOperationMode(_CANSPI_MODE_NORMAL, 0xFF);
	CLRF       FARG_CANSPISetOperationMode_mode+0
	MOVLW      255
	MOVWF      FARG_CANSPISetOperationMode_WAIT+0
	CALL       _CANSPISetOperationMode+0
;First_node_Duplex.c,161 :: 		}
L_end_Init_CAN_LCD_ADC:
	RETURN
; end of _Init_CAN_LCD_ADC

_main:

;First_node_Duplex.c,163 :: 		void main() {
;First_node_Duplex.c,164 :: 		Init_CAN_LCD_ADC();
	CALL       _Init_CAN_LCD_ADC+0
;First_node_Duplex.c,166 :: 		while (1) {
L_main0:
;First_node_Duplex.c,167 :: 		adc_value = ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_value+0
	MOVF       R0+1, 0
	MOVWF      _adc_value+1
;First_node_Duplex.c,168 :: 		RxTx_Data[0] = adc_value >> 8;
	MOVF       R0+1, 0
	MOVWF      R2+0
	CLRF       R2+1
	MOVF       R2+0, 0
	MOVWF      _RxTx_Data+0
;First_node_Duplex.c,169 :: 		RxTx_Data[1] = adc_value & 0xFF;
	MOVLW      255
	ANDWF      R0+0, 0
	MOVWF      _RxTx_Data+1
;First_node_Duplex.c,170 :: 		CANSPIWrite(ID_A, RxTx_Data, 2, Can_Send_Flags);
	MOVLW      100
	MOVWF      FARG_CANSPIWrite_id+0
	MOVLW      0
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
;First_node_Duplex.c,171 :: 		CANSPIWrite(ID_A, RxTx_Data, 2, Can_Send_Flags);
	MOVLW      100
	MOVWF      FARG_CANSPIWrite_id+0
	MOVLW      0
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
;First_node_Duplex.c,173 :: 		Lcd_Out(1, 1, "NODE A:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_First_node_Duplex+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;First_node_Duplex.c,174 :: 		Display_Value(adc_value, 1, 6);
	MOVF       _adc_value+0, 0
	MOVWF      FARG_Display_Value_value+0
	MOVF       _adc_value+1, 0
	MOVWF      FARG_Display_Value_value+1
	MOVLW      1
	MOVWF      FARG_Display_Value_row+0
	MOVLW      6
	MOVWF      FARG_Display_Value_col+0
	CALL       _Display_Value+0
;First_node_Duplex.c,176 :: 		Msg_Rcvd = CANSPIRead(&Rx_ID, RxTx_Data, &Rx_Data_Len, &Can_Rcv_Flags);
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
;First_node_Duplex.c,177 :: 		if (Msg_Rcvd && Rx_Data_Len == 2) {
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main4
	MOVF       _Rx_Data_Len+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main4
L__main9:
;First_node_Duplex.c,178 :: 		received_value = ((unsigned int)RxTx_Data[0] << 8) | RxTx_Data[1];
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
;First_node_Duplex.c,179 :: 		if (Rx_ID == ID_B) {
	MOVF       _Rx_ID+3, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main13
	MOVF       _Rx_ID+2, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main13
	MOVF       _Rx_ID+1, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main13
	MOVF       _Rx_ID+0, 0
	XORLW      101
L__main13:
	BTFSS      STATUS+0, 2
	GOTO       L_main5
;First_node_Duplex.c,180 :: 		Lcd_Out(2, 1, "RXB:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_First_node_Duplex+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;First_node_Duplex.c,181 :: 		Display_Value(received_value, 2, 6);
	MOVF       _received_value+0, 0
	MOVWF      FARG_Display_Value_value+0
	MOVF       _received_value+1, 0
	MOVWF      FARG_Display_Value_value+1
	MOVLW      2
	MOVWF      FARG_Display_Value_row+0
	MOVLW      6
	MOVWF      FARG_Display_Value_col+0
	CALL       _Display_Value+0
;First_node_Duplex.c,182 :: 		} else if (Rx_ID == ID_C) {
	GOTO       L_main6
L_main5:
	MOVF       _Rx_ID+3, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main14
	MOVF       _Rx_ID+2, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main14
	MOVF       _Rx_ID+1, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main14
	MOVF       _Rx_ID+0, 0
	XORLW      102
L__main14:
	BTFSS      STATUS+0, 2
	GOTO       L_main7
;First_node_Duplex.c,183 :: 		Lcd_Out(2, 8, "RXC:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_First_node_Duplex+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;First_node_Duplex.c,184 :: 		Display_Value(received_value, 2, 6);
	MOVF       _received_value+0, 0
	MOVWF      FARG_Display_Value_value+0
	MOVF       _received_value+1, 0
	MOVWF      FARG_Display_Value_value+1
	MOVLW      2
	MOVWF      FARG_Display_Value_row+0
	MOVLW      6
	MOVWF      FARG_Display_Value_col+0
	CALL       _Display_Value+0
;First_node_Duplex.c,185 :: 		}
L_main7:
L_main6:
;First_node_Duplex.c,187 :: 		}
L_main4:
;First_node_Duplex.c,189 :: 		Delay_ms(200);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	DECFSZ     R11+0, 1
	GOTO       L_main8
	NOP
	NOP
;First_node_Duplex.c,190 :: 		}
	GOTO       L_main0
;First_node_Duplex.c,191 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
