#!/bin/bash

xhost +local:docker || true

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
if [[ $1 = "--nvidia" ]] || [[ $1 = "-n" ]]
  then
    docker run -ti --rm \
            --gpus all \
            -e NVIDIA_DRIVER_CAPABILITIES=compute,utility \
            -e NVIDIA_VISIBLE_DEVICES=all \
            -e "DISPLAY" \
            -e "QT_X11_NO_MITSHM=1" \
            -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
            -e XAUTHORITY \
            -v /dev:/dev \
            -v $ROOT_DIR/catkin_ws:/catkin_ws \
            --net=host \
            --privileged \
            --name ur5rl ur5rl-img \
            -e ROS_MASTER_URI="http://192.168.1.20:11311" \
            -e ROS_HOSTNAME=192.168.1.20 \
            -e ROS_IP=192.168.1.20

    else
        echo "[!] If you wanna use nvidia gpu, please use script with -n or --nvidia argument"
        docker run -ti --rm \
            -e "DISPLAY" \
            -e "QT_X11_NO_MITSHM=1" \
            -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
            -e XAUTHORITY \
            -v /dev:/dev \
            -v $ROOT_DIR/catkin_ws:/catkin_ws \
            --net=host \
            --privileged \
            --name ur5rl ur5rl-img
fi