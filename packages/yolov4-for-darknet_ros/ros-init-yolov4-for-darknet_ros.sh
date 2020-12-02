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

echo "Setting up 'yolov4 for darknet_ros' package for $distro"
distro_lowercase="${distro,,}"

# Inital build of catkin workspace
cd $catkin_folder/src
catkin_init_workspace

cd ../
catkin_make

# Download package
cd src
git clone --recursive https://github.com/Tossy0423/yolov4-for-darknet_ros.git

# Download weights
#cd darknet_ros/darknet_ros/yolo_network_config/weights
#wget https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v3_optimal/yolov4.weights

# Install uvc-camera for using webcam for testing
sudo apt install ros-$distro_lowercase-uvc-camera

# Build workspace
cd $catkin_folder
catkin_make

# Source workspace
source devel/setup.bash
