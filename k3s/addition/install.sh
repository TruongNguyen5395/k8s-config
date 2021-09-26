#!/usr/bin/env bash

##tain master
echo -n "Taint master (y/n)?"
read input
if [[ $input == "y" ]]; then
    kubectl taint nodes --all node-role.kubernetes.io/master-
fi


# Helm
echo -n "Install helm (y/n)?"
read input
if [[ $input == "y" ]]; then
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash
    kubectl apply -f helm/rbac.yaml
    helm init --service-account tiller
fi

# Install docker registry
echo -n "Install docker registry (y/n)?"
read input
if [[ $input == "y" ]]; then
    helm install stable/docker-registry --name dc-repo --namespace dc-repo -f registry/values.yaml
fi


# Install nfs
echo -n "Install nfs client provisioner (y/n)?"
read input
if [[ $input == "y" ]]; then
    echo -n Input nfs server ip:
    read NFS_IP
    helm install nfs stable/nfs-client-provisioner --set nfs.server=${NFS_IP} --set nfs.path=/nfs  --namespace nfs
    kubectl patch storageclass nfs-client -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
fi

# install nginx
# Install nfs
echo -n "Install nginx ingress controller (y/n)?"
read input
if [[ $input == "y" ]]; then
    echo -n Input master ip:
    read MASTER_IP
    sed "s/x.x.x.x/$MASTER_IP/g" nginx/values.yaml > nginx/values-tmp.yaml
    helm install --name nginx --namespace nginx stable/nginx-ingress -f nginx/values-tmp.yaml
fi