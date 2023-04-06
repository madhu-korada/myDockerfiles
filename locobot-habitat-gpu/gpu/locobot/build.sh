#!/bin/sh
PARENT_IMAGE=nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
TAG=locobot:GPU


# INSTALL_SCRIPT="install_gpu_deps"
USER_ID=`id -u`
USER_NAME=locobot
USER_PASS=qwertyui
# INSTALL_DIR=/home/${USER_NAME}/tools/

docker build -f Dockerfile \
  --build-arg PARENT_IMAGE=${PARENT_IMAGE} \
  --build-arg USER_ID=${USER_ID} \
  --build-arg USER_NAME=${USER_NAME} \
  --build-arg USER_PASS=${USER_PASS} \
  -t ${TAG} .

# docker build --rm -t argnctu/locobot:GPU .