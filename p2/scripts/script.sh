#/bin/bash

export VAGRANT_WSL_WINDOWS_ACCESS_USER_HOME_PATH=`pwd`

#clean previous launch if necessary 
vagrant destroy -f
rm ~/.ssh/vagrant*

#create ssh key
ssh-keygen -t rsa -b 2048 -q -N "" -f ~/.ssh/vagrant

#launch and check if all good
vagrant up
vagrant ssh -c "kubectl get all -o wide"
