FROM ubuntu:20.04

# Use DEBIAN_FRONTEND=noninteractive to make things noninteractive and Set timezone using TZ=US/Eastern
RUN apt-get update && DEBIAN_FRONTEND=noninteractive TZ=US/Eastern 

# This is very important which will setup keybord conf and not ask for the user input in the later stage 
RUN ["apt-get", "install", "-y", "keyboard-configuration"]

RUN ["apt-get", "install", "-y", "sudo"]
RUN ["apt-get", "install", "-y", "cmake"]
RUN ["apt-get", "install", "-y", "apt-utils"]
RUN ["apt-get", "install", "-y", "git"]
RUN ["apt-get", "install", "-y", "mlocate"]
RUN ["apt-get", "install", "-y", "curl"]
RUN ["apt-get", "install", "-y", "wget"]
RUN ["apt-get", "install", "-y", "vim"]
RUN ["apt-get", "install", "-y", "net-tools"]
RUN ["apt-get", "install", "-y", "build-essential"]
RUN ["apt-get", "install", "-y", "apt-transport-https"]
RUN ["apt-get", "install", "-y", "ca-certificates"]
RUN ["apt-get", "install", "-y", "gnupg-agent"]
RUN ["apt-get", "install", "-y", "lsb-release"]
RUN ["apt-get", "install", "-y", "gedit"]
RUN ["apt-get", "install", "-y", "meld"]

# ROS Neotic
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "ros-noetic-desktop-full"]

RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

RUN apt install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
RUN rosdep init
RUN rosdep update

RUN apt-get update
RUN apt-get install -y python3-catkin-tools
