#!/bin/sh

scp -o StrictHostKeyChecking=no root@192.168.56.110:/var/lib/rancher/k3s/server/node-token /tmp/token
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE=644 K3S_URL=https://192.168.56.110:6443 K3S_TOKEN_FILE=/tmp/token sh -s - --node-ip 192.168.56.111