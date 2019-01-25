
# Helm
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash
kubectl apply -f helm/rbac.yaml
helm init --service-account tiller

# Install docker registry
helm install stable/docker-registry --name dc-repo --namespace dc-repo -f registry/values.yaml
 

# Install nfs
## install nfs cluster
helm install stable/nfs-client-provisioner --set nfs.server=167.114.98.168 --set nfs.path=/nfs --name nfs --namespace nfs
kubectl patch storageclass nfs-client -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'


# install nginx
helm install --name nginx --namespace nginx stable/nginx-ingress -f nginx/values.yaml 

#tain master
kubectl taint nodes --all node-role.kubernetes.io/master-
