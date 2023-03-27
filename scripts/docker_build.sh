#!/bin/bash
set -x

TAG=ros_kinetic
# https://hub.docker.com/layers/nvidia/cuda/8.0-cudnn5-runtime-ubuntu16.04/images/sha256-ee69517d29157ecaf4eb309fd8356930cae6ff3b58d98ffae5d11674965544a5?context=explore
PARENT=nvidia/cuda:8.0-cudnn5-runtime-ubuntu16.04

# INSTALL_SCRIPT="install_gpu_deps"
USER_ID=`id -u`
USER_NAME=`id -un`
USER_PASS=qwertyui

docker build -f Dockerfile_${TAG} \
  --build-arg PARENT_IMAGE=${PARENT} \
  --build-arg USER_ID=${USER_ID} \
  --build-arg USER_NAME=${USER_NAME} \
  --build-arg USER_PASS=${USER_PASS} \
  -t ${TAG} .

#   --build-arg INSTALL_SCRIPT=${INSTALL_SCRIPT} \