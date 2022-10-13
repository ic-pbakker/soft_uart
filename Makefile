obj-m += soft_uart1.o

soft_uart-objs := module.o raspberry_soft_uart1.o queue.o

RELEASE = $(shell uname -r)
LINUX = /usr/src/linux-headers-$(RELEASE)

all:
	$(MAKE) -C $(LINUX) M=$(PWD) modules

clean:
	$(MAKE) -C $(LINUX) M=$(PWD) clean

install:
	sudo install -m 644 -c soft_uart1.ko /lib/modules/$(RELEASE)
	sudo depmod

