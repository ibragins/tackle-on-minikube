#!/bin/bash

# if [ "$EUID" -ne 0 ]
#   then echo "Please run as root."
#   exit
# fi

echo "Downloading and installing minikube..."
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
minikube_homedir=/usr/local/bin/
if [ ! -d  "$minikube_homedir" ];
then
  echo "Folder $minikube_homedir doesn't exist, it will be created now"
  sudo mkdir -p $minikube_homedir
fi
sudo install minikube $minikube_homedir

echo "Downloading and installing kubectl..."
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

minikube start --driver=docker --memory=10g
minikube addons enable dashboard
minikube addons enable ingress
minikube addons enable olm
kubectl apply -f https://raw.githubusercontent.com/operator-framework/operator-lifecycle-manager/master/deploy/upstream/quickstart/crds.yaml
kubectl apply -f https://raw.githubusercontent.com/operator-framework/operator-lifecycle-manager/master/deploy/upstream/quickstart/olm.yaml

kubectl apply -f https://raw.githubusercontent.com/konveyor/tackle2-operator/main/tackle-k8s.yaml
# feature_auth_required: true - this is required to enable keycloak on latest upstream

while [ $(kubectl get crd|grep tackle|wc -l) != 2 ]
do echo "Waiting for Tackle CRDs..."
  sleep 5s
done


# This line in yaml below added temporary to fix the bug
# ui_image_fqin: quay.io/konveyor/tackle2-ui@sha256:f56b87f8b46765b797380c9d2616d700951487f03895c4a271b40f07bc61df01
cat << EOF | kubectl apply -f -
kind: Tackle
apiVersion: tackle.konveyor.io/v1alpha1
metadata:
  name: tackle
  namespace: konveyor-tackle
spec:
  feature_auth_required: true
EOF
