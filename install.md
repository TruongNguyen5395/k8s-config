
# Helm 
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash <br />
kubectl apply -f helm/rbac.yaml <br />
helm init --service-account tiller <br />
  
# Install docker registry
helm install stable/docker-registry --name dc-repo --namespace dc-repo -f registry/values.yaml <br />
 

# Install nfs
## install nfs cluster
helm install stable/nfs-client-provisioner --set nfs.server=xxx.xxx.xxx --set nfs.path=/nfs --name nfs --namespace nfs  <br />
kubectl patch storageclass nfs-client -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'  <br />


# install nginx
helm install --name nginx --namespace nginx stable/nginx-ingress -f nginx/values.yaml  <br />

#tain master
kubectl taint nodes --all node-role.kubernetes.io/master- <br />
