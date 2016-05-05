#!/bin/bash
set -e
# Any subsequent(*) commands which fail will cause the shell script to exit immediately
if [ "$#" -ne 1 ]; then
  echo "usage: ./run.sh <path-to-installation>"
  exit
fi

# requires ros to be installed...

cd "$1"
# assuming ros is installed. should have sourced /opt/ros/..../setup.zsh or wahtver
rosv=`rosversion -d`
echo "/opt/ros/$rosv/setup.bash"
source "/opt/ros/$rosv/setup.bash"
mkdir -p robocup/src
cd robocup/src
catkin_init_workspace
cd ..
catkin_make

source "devel/setup.bash"

cd src

# clone stuff

git clone https://github.com/KRSSG/robojackets.git
git clone https://github.com/KRSSG/plays.git
git clone https://github.com/KRSSG/ssl-vision.git
git clone https://github.com/KRSSG/kgpkubs_launch.git
git clone https://github.com/KRSSG/tactics.git
git clone https://github.com/KRSSG/ssl_robot.git
git clone https://github.com/KRSSG/ssl_common.git
git clone https://github.com/KRSSG/krssg_ssl_msgs.git
git clone https://github.com/KRSSG/grsim_comm.git
git clone https://github.com/KRSSG/grSim.git
git clone https://github.com/KRSSG/belief_state.git
git clone https://github.com/KRSSG/skills.git
git clone https://github.com/KRSSG/vision_comm.git
git clone https://github.com/KRSSG/traj_controller.git
git clone https://github.com/KRSSG/navigation.git
git clone https://github.com/KRSSG/refBox.git

# assumee
# installation dependencies

sudo apt-get install build-essential

# cmake
sudo apt-get install software-properties-common
sudo -E add-apt-repository ppa:george-edison55/cmake-3.x

# g++4.9
sudo -E add-apt-repository ppa:ubuntu-toolchain-r/test

# update
sudo apt-get update

# instructions for vartypes:
# [In a temporary directory]
mkdir tmpname_noclash && cd tmpname_noclash
wget http://vartypes.googlecode.com/files/vartypes-0.7.tar.gz
tar xfz vartypes-0.7.tar.gz
cd vartypes-0.7
mkdir build && cd build
cmake ..
make 
sudo make install
cd ../../
rm -rf tmpname_noclash
# install everything
sudo apt-get install g++-4.9 cmake qt5-default libqt5svg5-dev libprotobuf-dev protobuf-compiler libode2-dev screen

# make krssg_ssl_msgs first
cd ..
catkin_make --pkg krssg_ssl_msgs

# then make the rest
catkin_make