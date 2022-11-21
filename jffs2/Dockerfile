FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y && \
    apt install -y make gcc flex bison libncurses-dev libelf-dev libssl-dev tmux vim wget && \
    wget https://mirrors.edge.kernel.org/pub/linux/kernel/v6.x/linux-6.0.9.tar.xz && \
    mv linux-6.0.9.tar.xz /home && apt install -y kmod bc xz-utils && \
    cd /home && xz --decompress linux-6.0.9.tar.xz && tar xvf linux-6.0.9.tar && \
    rm linux-6.0.9.tar &&  cd linux-6.0.9 && make defconfig && \
    echo "CONFIG_KCOV=y" >> .config && \
    echo "CONFIG_DEBUG_INFO=y" >> .config && \
    echo "CONFIG_KASAN=y" >> .config && \ 
    echo "CONFIG_KASAN_INLINE=y" >> .config && \
    echo "CONFIG_CONFIGFS_FS=y" >> .config && \
    echo "CONFIG_SECURITYFS=y" >> .config && \
    echo "CONFIG_MTD=m" >> .config && \
    echo "CONFIG_MTD_BLKDEVS=m" >> .config && \
    echo "CONFIG_MTD_BLOCK=m" >> .config && \
    echo "CONFIG_MTD_BLOCK2MTD=m" >> .config && \
    echo "CONFIG_JFFS2_FS=m" >> .config && \
    echo "CONFIG_JFFS2_FS_DEBUG=0" >> .config && \
    echo "CONFIG_JFFS2_FS_WRITEBUFFER=y" >> .config && \
    echo "CONFIG_JFFS2_SUMMARY=y" >> .config && \
    echo "CONFIG_JFFS2_FS_XATTR=y" >> .config && \
    echo "CONFIG_JFFS2_FS_POSIX_ACL=y" >> .config && \
    echo "CONFIG_JFFS2_FS_SECURITY=y" >> .config && \
    echo "CONFIG_JFFS2_COMPRESSION_OPTIONS=y" >> .config && \
    echo "CONFIG_JFFS2_ZLIB=y" >> .config && \
    make -j`nproc` && \
    apt install -y sudo qemu-system-x86 debootstrap mtd-tools openssh-client && \
    mkdir /home/image && cd /home/image && \
    wget https://raw.githubusercontent.com/google/syzkaller/master/tools/create-image.sh -O create-image.sh && chmod +x create-image.sh
# && ./create-image.sh must be run inside the VM because docker build security 
# cd /home/linux-6.0.9 && sudo make modules_install
# sudo mount -o loop /home/image/stretch.img /mnt/chroot
# mkdir -P /mnt/chroot/lib/modules
# cp -r /lib/modules/6.0.9 /mnt/chroot/lib/modules
# mkfs.jffs2 -e 
# rm /etc/init /sbin/init
# then replace them 
