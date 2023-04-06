ARG PARENT_IMAGE
FROM $PARENT_IMAGE

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV ROS_DISTRO melodic

###################################### user #####################################
ARG USER_ID
ARG USER_NAME
ARG USER_PASS

ENV SHELL=/bin/bash \
    USER=${USER_NAME} \
    UID=${USER_ID} \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

ENV HOME=/home/${USER_NAME}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${UID} \
    ${USER_NAME} 

RUN echo "root:root" | chpasswd
RUN echo "${USER_NAME}:${USER_PASS}" | chpasswd

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
    libaudit-dev \
    tzdata \
    python3-pip \
    libjpeg-dev zlib1g-dev libpython3-dev libavcodec-dev libavformat-dev libswscale-dev \
    libtbb-dev libeigen3-dev 

##################################### Pytorch ######################################
RUN chown -R ${USER_NAME}:${USER_NAME} ${HOME}/

RUN pip3 install \
    torch==1.5.0+cu101 \
    torchvision==0.6.0+cu101 \
    -f https://download.pytorch.org/whl/torch_stable.html

#################################### GTSAM ####################################

RUN cd ${HOME}/ \
    && git clone https://github.com/borglab/gtsam.git \
    && cd gtsam/ \
    && sed -i '25 i set(CMAKE_CXX_STANDARD_LIBRARIES "-lstdc++fs")' CMakeLists.txt \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j8 install

    # && git checkout 4.0.0-alpha2 \
##################################### setting #####################################
RUN chown -R ${USER_NAME}:${USER_NAME} ${HOME}/
RUN echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

# # setup entrypoint
# COPY ./ros_entrypoint.sh /

# ENTRYPOINT ["/ros_entrypoint.sh"]

USER ${USER_NAME}

WORKDIR ${HOME}

# ############################# LoCoBot and PyRobot ############################

RUN cd ${HOME}/

RUN curl 'https://raw.githubusercontent.com/facebookresearch/pyrobot/master/robots/LoCoBot/install/locobot_install_all.sh' > locobot_install_all.sh && chmod +x locobot_install_all.sh

RUN ./locobot_install_all.sh -t full -p 3 -l interbotix

RUN rm locobot_install_all.sh


