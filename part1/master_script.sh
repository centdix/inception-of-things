#!/bin/sh

curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE=644 sh -s - --node-ip 192.168.56.110