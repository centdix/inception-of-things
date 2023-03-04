k3d cluster delete
k3d cluster create --api-port 6550 -p "8081:80@loadbalancer" -p "8888:30080@server:0"

kubectl create namespace argocd
kubectl create namespace dev

kubectl apply -f argo.yaml -n argocd
kubectl apply -f ingress.yaml -n argocd
kubectl apply -f application.yaml -n argocd
echo "sleeping 30 sec..."
sleep 30
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo