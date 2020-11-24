#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Using default paramters for your system"
    echo "To override this use with arguments: ./ros-init-yolov4-for-darknet_ros.sh [ROS_DISTRO] [CATKIN_FOLDER]"
    echo "e.g. './ros-init-yolov4-for-darknet_ros.sh kinetic ~/catkin_ws'"
    
    ubuntuVersionStr=$(lsb_release -r)
    ubuntuVersion=$(cut -f2 <<< "$ubuntuVersionStr")
    echo "Ubuntu: $ubuntuVersion"
    if [ "$ubuntuVersion" = "16.04" ]; then 
        distro="kinetic"
    elif [ "$ubuntuVersion" = "18.04" ]; then
        distro="melodic"
    elif [ "$ubuntuVersion" = "20.04" ]; then
        distro="noetic"
    else 
        echo "Unrecognised Ubuntu version cannot choose ROS distro automatically. Please define in arguments: ./ros-init.sh [ROS_DISTRO]"
        exit 0
    fi

    catkin_folder=~/catkin_ws
else
    distro=$1
    catkin_folder=$2
fi
echo "ROS Distro: $distro"
echo "Catkin folder: $catkin_folder"

distro_lowercase="${distro,,}"

cd $catkin_folder

