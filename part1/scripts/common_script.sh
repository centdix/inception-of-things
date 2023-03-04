#!/bin/sh

# Deploy keys to allow all nodes to connect each others as root
mkdir /root/.ssh
mv /tmp/id_rsa  /root/.ssh/
cat /tmp/id_rsa.pub > /root/.ssh/authorized_keys

# allow access as vagrant with no password with `vagrant ssh`
cat /tmp/id_rsa.pub > /home/vagrant/.ssh/authorized_keys