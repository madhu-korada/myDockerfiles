FROM osrf/ros:melodic-desktop-full

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV ROS_DISTRO melodic

###################################### user #####################################

ENV SHELL=/bin/bash \
    USER=sis \
    UID=1000 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

ENV HOME=/home/${USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${UID} \
    ${USER} 

RUN echo "root:root" | chpasswd
RUN echo "${USER}:111111" | chpasswd

###################################### basic tools #####################################

Run apt-get update && apt-get install -y \
    curl \
    lsb-release \
    sudo \
    software-properties-common \
    git \
    cmake \
    make \
    vim \
    build-essential \
    libblkid-dev \
    e2fslibs-dev \
    libboost-all-dev \
    libaudit-dev

#################################### GTSAM ####################################

RUN cd ${HOME}/ \
    && git clone https://github.com/borglab/gtsam.git \
    && cd gtsam/ \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make install

##################################### setting #####################################
RUN chown -R ${USER}:${USER} ${HOME}/
RUN echo "sis ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

# setup entrypoint
COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]

USER ${USER}

WORKDIR ${HOME}

############################# LoCoBot and PyRobot ############################

RUN cd ${HOME}/

RUN curl 'https://raw.githubusercontent.com/facebookresearch/pyrobot/master/robots/LoCoBot/install/locobot_install_all.sh' > locobot_install_all.sh && chmod +x locobot_install_all.sh

RUN ./locobot_install_all.sh -t full -p 3 -l interbotix

RUN rm locobot_install_all.sh

