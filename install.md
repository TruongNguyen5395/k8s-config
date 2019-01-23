# Install docker registry
helm install stable/docker-registry --name dc-repo --namespace dc-repo
 
# set pvc default
kubectl patch storageclass nfs-client -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'


# Install nfs
## install nfs cluster
helm install stable/nfs-client-provisioner --set nfs.server=167.114.98.168 --set nfs.path=/nfs --name nfs --namespace nfs




# Helm
kubectl apply -f helm/rbac.yaml
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash
helm init --service-account tiller

# install nginx
helm install --name nginx --namespace nginx stable/nginx-ingress -f values.yaml 
