FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y && \
    apt install -y make gcc flex bison libncurses-dev libelf-dev libssl-dev && \
     
