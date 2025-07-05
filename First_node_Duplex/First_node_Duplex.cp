#line 1 "G:/My Drive/Envision/PIC Microcontroller/MikroC/CAN/Two_node_FULL_Dulflex/First_node_Duplex/First_node_Duplex.c"
#line 96 "G:/My Drive/Envision/PIC Microcontroller/MikroC/CAN/Two_node_FULL_Dulflex/First_node_Duplex/First_node_Duplex.c"
sbit LCD_RS at RC0_bit;
sbit LCD_EN at RC1_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_RS_Direction at TRISC0_bit;
sbit LCD_EN_Direction at TRISC1_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;


sbit CanSpi_CS at RC2_bit;
sbit CanSpi_CS_Direction at TRISC2_bit;
sbit CanSpi_Rst at RC6_bit;
sbit CanSpi_Rst_Direction at TRISC6_bit;


unsigned char Can_Init_Flags, Can_Send_Flags, Can_Rcv_Flags;
unsigned char Rx_Data_Len;
char RxTx_Data[2];
char Msg_Rcvd;
unsigned int adc_value, received_value;
long Rx_ID;


const unsigned long ID_A = 100;
const unsigned long ID_B = 101;
const unsigned long ID_C = 102;


void Display_Value(unsigned int value, char row, char col) {
 char buf[5];
 buf[0] = value / 1000 + '0';
 buf[1] = (value / 100) % 10 + '0';
 buf[2] = (value / 10) % 10 + '0';
 buf[3] = value % 10 + '0';
 buf[4] = '\0';
 Lcd_Out(row, col, buf);
}

void Init_CAN_LCD_ADC() {
 ADCON1 = 0x80;
 TRISA = 0xFF;

 SPI1_Init();
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 Can_Send_Flags = _CANSPI_TX_PRIORITY_0 & _CANSPI_TX_XTD_FRAME & _CANSPI_TX_NO_RTR_FRAME;
 Can_Init_Flags = _CANSPI_CONFIG_SAMPLE_THRICE & _CANSPI_CONFIG_PHSEG2_PRG_ON &
 _CANSPI_CONFIG_XTD_MSG & _CANSPI_CONFIG_DBL_BUFFER_ON &
 _CANSPI_CONFIG_VALID_XTD_MSG & _CANSPI_CONFIG_LINE_FILTER_OFF;

 CANSPIInitialize(1,3,3,3,1,Can_Init_Flags);
 CANSPISetOperationMode(_CANSPI_MODE_CONFIG, 0xFF);
 CANSPISetMask(_CANSPI_MASK_B1, -1, _CANSPI_CONFIG_XTD_MSG);
 CANSPISetMask(_CANSPI_MASK_B2, -1, _CANSPI_CONFIG_XTD_MSG);
 CANSPISetFilter(_CANSPI_FILTER_B2_F3, ID_B, _CANSPI_CONFIG_XTD_MSG);
 CANSPISetFilter(_CANSPI_FILTER_B2_F4, ID_C, _CANSPI_CONFIG_XTD_MSG);
 CANSPISetOperationMode(_CANSPI_MODE_NORMAL, 0xFF);
}

void main() {
 Init_CAN_LCD_ADC();

 while (1) {
 adc_value = ADC_Read(0);
 RxTx_Data[0] = adc_value >> 8;
 RxTx_Data[1] = adc_value & 0xFF;
 CANSPIWrite(ID_A, RxTx_Data, 2, Can_Send_Flags);
 CANSPIWrite(ID_A, RxTx_Data, 2, Can_Send_Flags);

 Lcd_Out(1, 1, "NODE A:");
 Display_Value(adc_value, 1, 6);

 Msg_Rcvd = CANSPIRead(&Rx_ID, RxTx_Data, &Rx_Data_Len, &Can_Rcv_Flags);
 if (Msg_Rcvd && Rx_Data_Len == 2) {
 received_value = ((unsigned int)RxTx_Data[0] << 8) | RxTx_Data[1];
 if (Rx_ID == ID_B) {
 Lcd_Out(2, 1, "RXB:");
 Display_Value(received_value, 2, 6);
 } else if (Rx_ID == ID_C) {
 Lcd_Out(2, 8, "RXC:");
 Display_Value(received_value, 2, 6);
 }

 }

 Delay_ms(200);
 }
}
