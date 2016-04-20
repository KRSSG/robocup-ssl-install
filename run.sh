#!/bin/bash
set -e
# Any subsequent(*) commands which fail will cause the shell script to exit immediately
if [ "$#" -ne 1 ]; then
  echo "usage: ./run.sh <path-to-installation>"
  exit
fi

cd "$1"
# assuming ros is installed
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
