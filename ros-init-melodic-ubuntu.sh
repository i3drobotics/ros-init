# Ubuntu install of ROS Kinetic
# See http://wiki.ros.org/kinetic/Installation/Ubuntu for details

# Setup your sources.list
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
# Set up your keys
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
# Installation
sudo apt-get update
sudo apt install -y ros-melodic-desktop
# Environment setup
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc
# Dependencies for building packages
sudo apt install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
# Initialize rosdep
sudo apt install -y python-rosdep
sudo rosdep init
rosdep update

echo "ROS Melodic setup complete"
