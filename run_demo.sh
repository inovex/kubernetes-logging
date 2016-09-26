#!/bin/bash

# Runs the demo from scratch.

# Init Minikube Cluster
minikube start
eval $(minikube docker-env)

# Rebuild images.
cd fluentd_image
make build
cd ../es-image
make build
cd ../kibana-image
make build
cd ..

kubectl create -f kubernetes_config/es-controller.yaml
kubectl create -f kubernetes_config/kibana-controller.yaml
kubectl create -f kubernetes_config/es-service.yaml
kubectl create -f kubernetes_config/kibana-service.yaml

kubectl create configmap fluentd-config --from-file=kubernetes_config/fluentd_config/td-agent.conf --namespace=kube-system
kubectl create -f kubernetes_config/fluentd-daemonset.yaml

kubectl --namespace=kube-system get pods

minikube service -n kube-system --url kibana-logging