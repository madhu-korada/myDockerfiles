ARG PARENT_IMAGE
FROM $PARENT_IMAGE

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV ROS_DISTRO noetic

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

RUN apt-get update && apt-get install -y \
    curl lsb-release sudo software-properties-common git cmake \
    make vim build-essential libblkid-dev e2fslibs-dev \
    libboost-all-dev libaudit-dev tzdata python3-pip libjpeg-dev \
    zlib1g-dev libpython3-dev libavcodec-dev libavformat-dev libswscale-dev \
    libtbb-dev libeigen3-dev 


###################################### ROS Neotic ######################################
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

RUN apt-get update && apt-get install -y ros-noetic-desktop-full

RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

RUN apt install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
RUN rosdep init
RUN rosdep update

RUN apt-get update
RUN apt-get install -y python3-catkin-tools


RUN chown -R ${USER_NAME}:${USER_NAME} ${HOME}/

RUN apt-get update && apt-get install -y ros-$ROS_DISTRO-image-geometry ros-$ROS_DISTRO-pcl-ros ros-$ROS_DISTRO-cv-bridge

RUN apt-get install -y --no-install-recommends apt-utils

##################################### Conda ######################################

RUN curl -L -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  &&\
    chmod +x ~/miniconda.sh &&\
    ~/miniconda.sh -b -p /opt/conda &&\
    rm ~/miniconda.sh &&\
    /opt/conda/bin/conda install pytorch torchvision torchaudio pytorch-cuda=11.7 -c pytorch -c nvidia &&\
    /opt/conda/bin/conda install tensorboard -c conda-forge &&\
    /opt/conda/bin/conda clean -ya

ENV PATH /opt/conda/bin:$PATH

WORKDIR ${HOME}

RUN git clone https://github.com/VLR-Project-Team/Stretch-DRL.git

##################################### setting #####################################
RUN chown -R ${USER_NAME}:${USER_NAME} ${HOME}/
RUN echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

# # setup entrypoint
# COPY ./ros_entrypoint.sh /

# ENTRYPOINT ["/ros_entrypoint.sh"]

USER ${USER_NAME}

WORKDIR ${HOME}


