#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Using default paramters for your system"
    echo "To override this use with arguments: ./ros-init.sh [ROS_DISTRO]"
    echo "e.g. './ros-init.sh kinetic'"
    
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
else
    distro=$1
fi
echo "ROS Distro: $distro"

echo "Initalising ROS $distro"
distro_lowercase="${distro,,}"

# Ubuntu install of ROS
# See http://wiki.ros.org/[ROS_DISTRO]/Installation/Ubuntu for details

# Setup your sources.list
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
# Set up your keys
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
# Installation
sudo apt-get update
sudo apt-get install -y ros-$distro_lowercase-desktop
# Environment setup
echo "source /opt/ros/$distro_lowercase/setup.bash" >> ~/.bashrc
source ~/.bashrc
# Dependencies for building packages
sudo apt install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
# Initialize rosdep
sudo apt install -y python-rosdep
sudo rosdep init
rosdep update

echo "ROS setup complete"
