#!/bin/sh

# allow access as vagrant with no password with `vagrant ssh`
cat /tmp/id_rsa.pub > /home/vagrant/.ssh/authorized_keys

# install docker
apt-get update
apt-get install -y ca-certificates curl gnupg lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# install k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# create cluster and map port 8081 to kubernetes loadbalancer and port 8888 to nodeport 30080
k3d cluster create --api-port 6550 -p "8081:80@loadbalancer" -p "8888:30080@server:0"
cp -R /root/.kube /home/vagrant

# create namespaces
kubectl create namespace argocd
kubectl create namespace dev

# apply all
kubectl apply -f /tmp/argo.yaml -n argocd

echo "sleeping 60 sec..."
sleep 60

kubectl apply -f /tmp/ingress.yaml -n argocd
kubectl apply -f /tmp/application.yaml -n argocd

# print argo cd password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo