# 🔁 Two Node Full Duplex Communication using CAN Protocol

This project demonstrates **full duplex communication** between two microcontrollers using the **CAN (Controller Area Network)** protocol. It is developed using **PIC16F877A** microcontrollers, **MCP2515 CAN controllers**, and programmed using **MikroC PRO for PIC**.

Ideal for reliable data exchange between two embedded systems, such as industrial automation, vehicle communication, or multi-node sensor networks.

---

## 🚀 Features

- 🔄 **Full Duplex Communication** using CAN protocol
- 📟 **LCD Display** for received data at both nodes
- 🎛️ **Potentiometer-based ADC input** at both nodes
- 🔌 Real-time data exchange with **MCP2515 via SPI**
- 🔃 Continuous transmission and reception at both ends

---

## 📁 Project Files

| File Name               | Description                                                                 |
|-------------------------|-----------------------------------------------------------------------------|
| **Node1_FullDuplex.c**  | Sends ADC value from Node 1 and displays received value from Node 2         |
| **Node2_FullDuplex.c**  | Sends ADC value from Node 2 and displays received value from Node 1         |
| **CAN_Library.c**       | Library functions for MCP2515 CAN controller via SPI                        |
| **LCD_Config.c/.h**     | Configuration for 16x2 LCD interface                                        |
| **README.md**           | This documentation file                                                     |

---

## 🧰 Hardware Used

- ✅ PIC16F877A Microcontroller ×2
- ✅ MCP2515 CAN Module ×2
- ✅ LCD 16x2 Display ×2
- ✅ Potentiometer ×2
- ✅ 10kΩ Resistor for contrast (LCD)
- ✅ 120Ω Termination Resistors ×2
- ✅ Power Supply (5V Regulated)
- ✅ Breadboard and Jumpers

---

## 🔌 Wiring Summary

### Common Connections

| Signal      | PIC Pin       | MCP2515 Module       |
|-------------|---------------|----------------------|
| MOSI        | RC5 (SDO)     | SI                   |
| MISO        | RC4 (SDI)     | SO                   |
| SCK         | RC3 (SCK)     | SCK                  |
| CS          | RC0 (Custom)  | CS                   |
| INT         | RC1 (Custom)  | INT                  |
| VCC / GND   | 5V / GND      | VCC / GND            |

- **LCD Pins**: Connected to PORTD and PORTC (RS, EN, D4–D7)
- **Potentiometer**: Connected to RA0 (Analog input)

📌 **Connect CAN_H to CAN_H and CAN_L to CAN_L between both MCP2515 modules**  
📌 **Use 120Ω resistors at both ends of CAN bus**

---

## ⚙️ Setup Instructions

1. Open **MikroC PRO for PIC**.
2. Load `Node1_FullDuplex.c` for Node 1, and `Node2_FullDuplex.c` for Node 2.
3. Compile and flash each code to its respective **PIC16F877A**.
4. Power both nodes.
5. Observe:
   - Potentiometer value on one node
   - Received value from the other node on LCD

---

## 📊 Communication Flow

Each Node:
- Reads analog input (ADC) from potentiometer.
- Sends value to other node via CAN.
- Receives value from other node.
- Displays received data on LCD.

This simulates **simultaneous two-way communication** (Full Duplex behavior) using CAN.



## 🛡️ Author

**Sanket Mali**  
🔗 [GitHub Profile](https://github.com/Sanketmail3716)

---

## 📌 Note

- This project uses software SPI; you may customize `CS` and `INT` pins.
- For better results, ensure proper voltage levels and external oscillator (8MHz or 20MHz).
