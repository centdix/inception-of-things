#/bin/bash

export VAGRANT_WSL_WINDOWS_ACCESS_USER_HOME_PATH="/mnt/c/part1"

#clean previous launch if necessary 
vagrant destroy -f
rm ~/.ssh/vagrant*

#create ssh key
ssh-keygen -t rsa -b 2048 -q -N "" -f ~/.ssh/vagrant

#launch and check if all good
vagrant up
vagrant ssh master -c "kubectl get nodes -o wide"