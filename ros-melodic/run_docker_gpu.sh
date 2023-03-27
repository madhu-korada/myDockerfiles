#!/bin/bash
# Launch an experiment using the docker gpu image

CONTAINER_NAME=ros-melodic-latest
IMAGE_NAME=ros_melodic

echo "Running the docker (gpu image):"
echo $IMAGE_NAME

 #`id -un`
USER_ID=`id -u`
USER_NAME=ros-melodic
USER_PASS=qwertyui
HOST_NAME=`hostname`

MOUNT_DIR_LOCAL=${HOME}/work/rosm
MOUNT_DIR_DOCKER=/home/${USER_NAME}

docker run -it -d --runtime=nvidia --network host --privileged \
    --ipc=host --hostname ${HOST_NAME} \
    -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e password=${USER_PASS} -e user=${USER_NAME} \
    -u ${USER_NAME} \
    -v ${MOUNT_DIR_LOCAL}:${MOUNT_DIR_DOCKER} \
    --name ${CONTAINER_NAME}  ${IMAGE_NAME} 

# # EXECUTE
# docker exec -it $CONTAINER_NAME bash
    
    