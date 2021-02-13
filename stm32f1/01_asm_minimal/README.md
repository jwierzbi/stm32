# 01_minimal

Minimal assembly project for [NUCLEO-F103RB](https://www.st.com/en/evaluation-tools/nucleo-f103rb.html) board with [STM32F103RB](https://www.st.com/en/microcontrollers-microprocessors/stm32f103rb.html) microcontroller.

## Prerequisites

* [make](https://www.gnu.org/software/make/) and GCC (e.g. [arm-none-eabi-gcc](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads))
  for building
* [OpenOCD](http://openocd.org/) for programming and debugging
* GDB in addition to OpenOCD for debugging

## Building

To build the ELF target:

```bash
make
```

To build binary target:

```bash
make binary
```

To flash to the device:

```bash
make flash
```

To flash and run a debugger (GDB):

```bash
make debug
```
