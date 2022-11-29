obj-m += soft_uart_one.o

soft_uart-objs := module.o raspberry_soft_uart_one.o queue.o

RELEASE = $(shell uname -r)
LINUX = /usr/src/linux-headers-$(RELEASE)

all:
	$(MAKE) -C $(LINUX) M=$(PWD) modules

clean:
	$(MAKE) -C $(LINUX) M=$(PWD) clean

install:
	sudo install -m 644 -c soft_uart_one.ko /lib/modules/$(RELEASE)
	sudo depmod

