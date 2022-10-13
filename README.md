# soft_uart1

Software-based serial port module for Raspberry Pi.

This module creates a software-based serial port using a configurable pair of GPIO pins. The serial port will appear as `/dev/ttySOFT1`.

When a second module is needed, load as module uart_soft1 in addition to uart_soft. See https://codeintherightway.blogspot.com/2017/09/soft-uart-implementation-for-raspberry.html

## Features

* Works exactly as a hardware-based serial port.
* Works with any application, e.g. cat, echo, minicom.
* Configurable baud rate.
* TX buffer of 256 bytes.
* RX buffer managed by the kernel.


## Compiling

Fetch the source:
```
git clone https://github.com/ic-pbakker/trees/soft_uart1
```

Install the package `raspberrypi-kernel-headers`:
```
sudo apt-get install raspberrypi-kernel-headers
```

Run `make` and `make install`, as usual.
```
cd soft_uart1
make
sudo make install
```

I haven't tried cross-compiling this module, but it should work as well.


## Loading

Module parameters for soft_uart1:

* gpio_tx: int [default = GPIO 18, ComfilePi pin 12]
* gpio_rx: int [default = GPIO 27, ComfilePi pin 13]

Loading the module with default parameters:
```
sudo insmod soft_uart1.ko
```

Loading module with custom parameters. Reference the GPIO number, not the header pin number:
```
sudo insmod soft_uart.ko gpio_tx=18 gpio_rx=27
```


## Usage

The device will appear as `/dev/ttySOFT1`. Use it as any usual TTY device.

You must be included in the group `dialout`. You can verify in what groups you are included by typing `groups`. To add an user to the group `dialout`, type:
```
sudo usermod -aG dialout <username>
```

Usage examples:
```
minicom -b 4800 -D /dev/ttySOFT1
cat /dev/ttySOFT1
echo "hello" > /dev/ttySOFT1
```

## Baud rate

When choosing the baud rate, take into account that:
* The Raspberry Pi is not very fast.
* You will probably not be running a real-time operating system.
* There will be other processes competing for CPU time.

As a result, you can expect communication errors when using fast baud rates. So I would not try to go any faster than 4800 bps.
