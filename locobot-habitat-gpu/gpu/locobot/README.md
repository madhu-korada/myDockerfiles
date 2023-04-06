# Making ros docker image
*You should run this code on a **Jetson device** (Nano, TX, Xavier, etc.)*

dependencies: 
- CUDA 10.1
- Python 3.6
- Python 2.7
- ROS
- Pytorch 1.5
- Librealsense
- Pyrobot

Usage:

**building docker image**
```
laptop $ source build.sh
```
**How to run**
```
laptop $ source docker_run.sh
```
    
**If you want to enter same container**
```
laptop $ source docker_join.sh
```
