# soft_uart_one

Software-based serial port module for Raspberry Pi.

This module creates a software-based serial port using a configurable pair of GPIO pins. The serial port will appear as `/dev/ttySOFTONE`.

When a second module is needed, load as module uart_soft_one in addition to uart_soft. Reference https://codeintherightway.blogspot.com/2017/09/soft-uart-implementation-for-raspberry.html

## Features

* Works exactly as a hardware-based serial port.
* Works with any application, e.g. cat, echo, minicom.
* Configurable baud rate.
* TX buffer of 256 bytes.
* RX buffer managed by the kernel.


## Compiling

Fetch the source - branch for soft_uart_one:
```
ssh-agent
git clone --branch soft_uart_one --single-branch git@github.com:ic-pbakker/soft_uart.git soft_uart_one
```

Install the package `raspberrypi-kernel-headers`:
```
sudo apt-get install raspberrypi-kernel-headers
```

Run `make` and `make install`, as usual.
```
cd soft_uart_one
make
sudo make install
```

I haven't tried cross-compiling this module, but it should work as well.


## Loading

Module parameters for soft_uart_one:

* gpio_tx: int [default = GPIO 4, ComfilePi pin 7]
* gpio_rx: int [default = GPIO 17, ComfilePi pin 11]

Module parameters for soft_uart_two:

* gpio_tx: int [default = GPIO 18, ComfilePi pin 12]
* gpio_rx: int [default = GPIO 27, ComfilePi pin 13]

Module parameters for soft_uart_three:

* gpio_tx: int [default = GPIO 22, ComfilePi pin 15]
* gpio_rx: int [default = GPIO 23, ComfilePi pin 16]


Loading the module with default parameters:
```
sudo insmod soft_uart_one.ko
```

Loading module with custom parameters. Reference the GPIO number, not the header pin number:
```
sudo insmod soft_uart_one.ko gpio_tx=4 gpio_rx=17
```


## Usage

The device will appear as `/dev/ttySOFTONE0`. Use it as any usual TTY device.

You must be included in the group `dialout`. You can verify in what groups you are included by typing `groups`. To add an user to the group `dialout`, type:
```
sudo usermod -aG dialout <username>
```

Usage examples:
```
minicom -b 4800 -D /dev/ttySOFTONE0
cat /dev/ttySOFTONE0
echo "hello" > /dev/ttySOFTONE0
```

## Baud rate

When choosing the baud rate, take into account that:
* The Raspberry Pi is not very fast.
* You will probably not be running a real-time operating system.
* There will be other processes competing for CPU time.

As a result, you can expect communication errors when using fast baud rates. So I would not try to go any faster than 4800 bps.
