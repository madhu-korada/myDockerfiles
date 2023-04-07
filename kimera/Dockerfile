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


##################################### Kimera ######################################
RUN chown -R ${USER_NAME}:${USER_NAME} ${HOME}/

RUN apt-get update && apt-get install -y ros-$ROS_DISTRO-image-geometry ros-$ROS_DISTRO-pcl-ros ros-$ROS_DISTRO-cv-bridge

RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y \
    cmake build-essential unzip pkg-config autoconf \
    libboost-all-dev \
    libjpeg-dev libpng-dev libtiff-dev \
    libvtk6-dev libgtk-3-dev \
    libatlas-base-dev gfortran \
    libparmetis-dev \
    python3-wstool python3-catkin-tools \
    libtbb-dev

RUN mkdir -p ${HOME}/kimera_ws/src && cd ${HOME}/kimera_ws/ && \
    catkin init && catkin config --cmake-args -DCMAKE_CXX_STANDARD=14 -DCMAKE_BUILD_TYPE=Release -DGTSAM_TANGENT_PREINTEGRATION=OFF 
    # \ catkin config --merge-devel

# Add workspace to bashrc for automatic sourcing of workspace.
RUN echo 'source ${HOME}/kimera_ws/devel/setup.bash' >> ${HOME}/.bashrc

WORKDIR ${HOME}/kimera_ws/src
# Clone repo
RUN git clone https://github.com/MIT-SPARK/Kimera-VIO-ROS.git && \
    wstool init && wstool merge Kimera-VIO-ROS/install/kimera_vio_ros_https.rosinstall && \
    wstool update

RUN git clone https://github.com/MIT-SPARK/Kimera-Semantics.git 
RUN wstool merge Kimera-Semantics/install/kimera_semantics_https.rosinstall -y && \
    wstool update

RUN cd gtsam && git checkout c4184e192b4605303cc0b0d51129e470eb4b4ed1
RUN cd Kimera-VIO && git checkout origin/feature/hydra

RUN apt-get install -y ros-${ROS_DISTRO}-pcl-ros

RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build catkin_simple'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build mesh_rviz_plugins'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build kimera_rviz_markers'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build gtsam'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build opencv3_catkin'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build opengv_catkin'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build pose_graph_tools'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build dbow2_catkin'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build cmake_external_project_catkin'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build Kimera-RPGO'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build Kimera-VIO'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build Kimera-VIO-ROS'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build glog_catkin'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build gflags_catkin'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build disparity_image_proc'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build image_undistort'

RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build disparity_image_proc'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build eigen_catkin'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build eigen_checks'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build gflags_catkin'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build glog_catkin'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build minkindr'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build minkindr_ros'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build numpy_eigen'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build protobuf_catkin'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build catkin_boost_python_buildtool'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build voxblox'

RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin build'
# RUN cd ${HOME}/kimera_ws && catkin build

#################################### GTSAM ####################################

##################################### setting #####################################
RUN chown -R ${USER_NAME}:${USER_NAME} ${HOME}/
RUN echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

# # setup entrypoint
# COPY ./ros_entrypoint.sh /

# ENTRYPOINT ["/ros_entrypoint.sh"]

USER ${USER_NAME}

WORKDIR ${HOME}


