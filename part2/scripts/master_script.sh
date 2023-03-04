#!/bin/sh

# allow access as vagrant with no password with `vagrant ssh`
cat /tmp/id_rsa.pub > /home/vagrant/.ssh/authorized_keys

curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE=644 sh -s - --node-ip 192.168.56.110
kubectl apply -f /tmp/deployments
kubectl apply -f /tmp/services
kubectl apply -f /tmp/ingress.yaml