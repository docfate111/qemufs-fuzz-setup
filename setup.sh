#!/bin/sh
sudo apt update -y
# https://github.com/google/syzkaller/blob/master/docs/linux/setup_ubuntu-host_qemu-vm_x86-64-kernel.md
git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
cd linux
make defconfig
make kvm_guest.config
# change to add MTD and JFFS2
# change to add KCOV, DEBUG_INFO, KASAN, CONFIGFS, SECURITYFS
make -j`nproc`
sudo apt install -y qemu-system-x86 debootstrap
cd ..
mkdir image
cd image
wget https://raw.githubusercontent.com/google/syzkaller/master/tools/create-image.sh -O create-image.sh
chmod +x create-image.sh
./create-image.sh
cd ..
echo "git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
&& cd linux && make -j'nproc' && make modules_install #(inside qemu)"
qemu-system-x86_64 \
	-m 2G \
	-smp 2 \
	-kernel linux/arch/x86/boot/bzImage \
	-append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
	-drive file=image/stretch.img,format=raw \
	-net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
	-net nic,model=e1000 \
	-enable-kvm \
	-nographic \
	-pidfile vm.pid \
	2>&1 | tee vm.log
