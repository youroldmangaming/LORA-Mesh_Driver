# Makefile to build the SX1276 mesh networking driver as a kernel module

KDIR := /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)

obj-m := sx1276_mesh_driver.o

all:
	make -C $(KDIR) M=$(PWD) modules

clean:
	make -C $(KDIR) M=$(PWD) clean

install:
	sudo cp sx1276_mesh_driver.ko /lib/modules/$(shell uname -r)/kernel/drivers/net/
	sudo depmod
