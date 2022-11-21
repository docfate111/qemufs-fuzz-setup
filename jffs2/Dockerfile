FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y && \
    apt install -y make gcc flex bison libncurses-dev libelf-dev libssl-dev tmux vim wget && \
    wget https://mirrors.edge.kernel.org/pub/linux/kernel/v6.x/linux-6.0.9.tar.xz && \
    mv linux-6.0.9.tar.xz /home && apt install -y bc xz-utils && \
    xz --decompress linux-6.0.9.tar.xz && tar xvf linux-6.0.9.tar && \
    rm linux-6.0.9.tar &&   
