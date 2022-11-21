#!/bin/sh
qemu-system-x86_64 \
	-m 2G \
	-smp 2 \
	-kernel linux-5.19.17/arch/x86/boot/bzImage \
	-append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
	-drive file=image/stretch.img,format=raw \
	-enable-kvm \
	-nographic \
	-pidfile vm.pid \
	2>&1 | tee vm.log
