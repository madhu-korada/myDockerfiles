#!/bin/bash
# Launch an experiment using the docker gpu image

CONTAINER_NAME=ros-kinetic
IMAGE_NAME=ros_kinetic

echo "Running the docker (gpu image):"
echo $IMAGE_NAME

 #`id -un`
USER_ID=`id -u`
USER_NAME=ros-kinetic
USER_PASS=qwertyui
HOST_NAME=`hostname`

MOUNT_DIR_LOCAL=${HOME}/work/rosk
MOUNT_DIR_DOCKER=/home/${USER_NAME}

docker run -it -d --runtime=nvidia --network host \
    --ipc=host --hostname ${HOST_NAME} \
    -e password=${USER_PASS} -e user=${USER_NAME} \
    -u ${USER_NAME} \
    -v ${MOUNT_DIR_LOCAL}:${MOUNT_DIR_DOCKER} \
    --name ${CONTAINER_NAME}  ${IMAGE_NAME} 

# # EXECUTE
# docker exec -it $CONTAINER_NAME bash
    
    