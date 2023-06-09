#!/bin/sh
PARENT_IMAGE=nvidia/cuda:12.0.0-devel-ubuntu20.04
TAG=manojkorada/kimera_vio_semantics:V2.0

# INSTALL_SCRIPT="install_gpu_deps"
USER_ID=`id -u`
USER_NAME=ghar
USER_PASS=i
# INSTALL_DIR=/home/${USER_NAME}/tools/

docker build -f Dockerfile \
  --build-arg PARENT_IMAGE=${PARENT_IMAGE} \
  --build-arg USER_ID=${USER_ID} \
  --build-arg USER_NAME=${USER_NAME} \
  --build-arg USER_PASS=${USER_PASS} \
  -t ${TAG} .

# docker build --rm -t argnctu/locobot:GPU .