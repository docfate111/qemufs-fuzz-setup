#!/bin/sh
docker build -t jffs2qemu .
docker run -it jffs2qemu:latest
