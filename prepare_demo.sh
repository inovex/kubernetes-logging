#!/bin/bash

# Prepare the demo from scratch.

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
cd ../example_app
make build 
cd ..
