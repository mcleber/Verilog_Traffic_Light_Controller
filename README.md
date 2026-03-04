# Traffic Light Controller with Verilog
### Sequential LED Control using FPGA

![Platform](https://img.shields.io/badge/Platform-FPGA-blue)
![Language](https://img.shields.io/badge/Language-Verilog-orange)
![Board](https://img.shields.io/badge/Board-Tang%20Primer%2020K-green)
![IDE](https://img.shields.io/badge/IDE-Gowin%20IDE-blue)
![License](https://img.shields.io/badge/License-GPL--3.0-blue)

<p align="center">
  <a href="https://youtu.be/ONJCw0yPPp8?si=ygO_kFMLyOfD9sJu">
    <img src="https://github.com/mcleber/Verilog_Traffic_Light/blob/main/assets/imagem_video.png" 
         width="500" 
         alt="Watch the video">
  </a>
</p>

<p align="center">
  Click the image to watch the project in operation on YouTube.
</p>

---

## Overview

This project implements a Traffic Light Controller using Verilog on an FPGA.

It was developed as one of my first practical experiments with the Sipeed Tang Primer 20K, focusing on understanding digital design, timing control, and hardware implementation.

The system controls three LEDs (Red, Yellow, and Green) following a real-world traffic light sequence.

Core concepts explored:

- Fundamentals of sequential logic in Verilog
- Counter-based timing generation
- FPGA pin mapping using Gowin IDE
- Practical LED interfacing

---

## Repository Structure

```Text
Verilog_Traffic_Light_Controller/
│
├── assets/
│   ├── imagem_video.png
│   ├── traffic_light.mp4
│   └── traffic_light_schem.jpg
│
├── constraints/
│   └── traffic_light.cst
│
├── src/
│   └── traffic_light.v
│
├── tb/
│   └── traffic_light_tb.v
│
├── License
│
└── README.md
```
---

## Hardware Required

### Electronics
- 1 × Tang Primer 20K FPGA (GW2A-LV18PG256C8/I7) with Dock
- 3 × LEDs (Red, Yellow, Green)
- 3 x 10Ω resistors (current-limiting resistors)

### Miscellaneous
- Jumper wires
- Breadboard
- USB-C cable

---

## Hardware Setup

### Schematics

<p align="center"> 
  <img src="assets/traffic_light_schem.jpg" width="400" alt="Traffic Light Schematic"> 
</p>

The LEDs are directly connected to FPGA GPIO pins with current-limiting resistors.

---

## How It Works

The traffic light sequence follows: RED → YELLOW → GREEN → RED

Each LED remains:
- ON for 1 second
- OFF for 0.5 seconds

Automatic continuous cycling — no reset required.

- The FPGA runs on a 27 MHz clock
- A counter generates time intervals (1s and 0.5s)
- The control logic determines which LED is active
- The sequence automatically repeats indefinitely

---

## Verilog Code and Constraints

All source files are available in:

- ```src/``` → Verilog implementation
- ```constraints/``` → FPGA pin mapping file
- ```tb/``` → Simulation testbench

---

## Synthesis and Programming

To compile and program the FPGA:

- Create a new project in Gowin IDE
- Select device GW2A-LV18PG256C8/I7
- Add the Verilog source file
- Configure the .cst constraints file with correct GPIO pins
- Run synthesis and generate the bitstream
- Program the FPGA via USB-C

Once programmed, the LEDs automatically begin cycling through the traffic sequence.

---

## Features

- Counter-based timing control
- Continuous automatic operation
- Simulation testbench included

---

## Future Improvements

- Add pedestrian crossing button input
- Implement adjustable timing via DIP switches
- Expand to dual-direction intersection control
- Add PWM brightness control
- Migrate to a multi-state programmable controller

---

## Common Issues and Solutions

- **Incorrect GPIO assignment:**
  If LEDs do not light up, verify the ```.cst``` file matches the Dock pinout documentation.

- **LED polarity inverted:**
  Check if the board uses active-low outputs and adjust the logic in Verilog if necessary.

---

## License

This project is open-source and available under the GPL-3.0 License.

---

## Author

Developed as an FPGA learning project using the Tang Primer 20K platform.

