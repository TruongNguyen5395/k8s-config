# Install docker registry
helm install stable/docker-registry --name dc-repo --namespace dc-repo --set persistence.enabled=true,persistence.size=3Gi --set nodeSelector."kubernetes\.io/hostname"=vps198422
 


# Install nfs
helm install stable/nfs-client-provisioner --set nfs.server=167.114.98.168 --set nfs.path=/nfs --name nfs --namespace nfs