#!/bin/bash

# See http://gazebosim.org/tutorials?tut=install_from_source&cat=install for details

gazebo_version=7
ros_distro=kinetic

sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
wget https://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
sudo apt-get update

wget https://raw.githubusercontent.com/ignition-tooling/release-tools/master/jenkins-scripts/lib/dependencies_archive.sh -O /tmp/dependencies.sh
GAZEBO_MAJOR_VERSION=$gazebo_version ROS_DISTRO=$ros_distro . /tmp/dependencies.sh
echo $BASE_DEPENDENCIES $GAZEBO_BASE_DEPENDENCIES | tr -d '\\' | xargs sudo apt-get -y install

git clone https://github.com/osrf/gazebo /tmp/gazebo
cd /tmp/gazebo

mkdir build
cd build
cmake ../
make -j$((`nproc`+1))
make install
