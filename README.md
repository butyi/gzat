# gzat

Application template for Motorola/Freescale/NXP MC68HC908GZ60

## Services

Main file is `prg.asm`. This is the frame of software. Other files are just included by `prg.asm`.

### Analog Digital Converter

Continuously read the configured analog channels in 10bits format. Channel change is done automatic by interrupt routine. 
Up to date values are simply always available in the storage RAM array.

### Debug LED handler

Toggles the debug LED on the configured port. The ready to use LED is useful during development or to show status of application.

### Serial Communication Interface

Initializes the UART RS232 with baud rate 57600, 8bits, no parity for debug and/or application purpose. 
The task implements download reset function and a simple echo.

### Timers decremented by Time Base Module

Module is used for application timers. Timer interrupt is invoked around every 32ms. This means value 30 in timer byte results 1s timing.
Timers are count down types, so tu pull up timers write the value into timer byte, what will be decreased till zero. You need to check its zero state.

### Task handler

This is a tiny task handler. LoSchedule function takes over the execution to next task. 
Every task have own stack with configured size.
At task handover the configured registers are saved and restored into task stack.

## Compile

Check out the repo and just call `asm8 prg.asm`. 
prg.s19 will be ready to be downloaded by once GZ downloader [gzdl.c](https://github.com/butyi/gzdl.c/) or [gzdl.py](https://github.com/butyi/gzdl.py/).

## License

This is free. You can do anything you want with it.
While I am using Linux, I got so many support from free projects, I am happy if I can help for the community.

## Keywords

Motorola, Freescale, NXP, MC68HC908GZ60, 68HC908GZ60, HC908GZ60, MC908GZ60, 908GZ60, HC908GZ48, HC908GZ32, HC908GZ, 908GZ

###### 2019 Janos Bencsik

