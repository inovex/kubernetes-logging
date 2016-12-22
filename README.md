# Kubernetes Logging into Elasticsearch

This repository contains a docker images for a fluentd logshipper, kubernetes configs to deploy a basic elasticsearch cluster with kibana frontend, and documentation. These files should show how to setup a fluentd logshipper as kubernetes daemonset and pipe all container logs into an elasticsearch cluster. The logs are enriched with Metadata like `pod_name`, `pod_id`, `docker_id`. If your kubernetes application logs structured JSON log to STDOUT or STDERR the JSON is interpreted and each field of the JSON is a field in the elasticsearch index.

The content of this repository is based on the example given in the kubernetes repository. https://github.com/kubernetes/kubernetes/tree/master/cluster/addons/fluentd-elasticsearch

## Changes need for production
The file `kubernetes_config/fluentd-daemonset.yaml` contains the configuration for the fluentd logshipper. See the comments in this files for changes in production.

The `fluentd_image/Makefile` builds the docker container. Change the variables according to your docker registry setup. 

The file `kubernetes_config/fluentd_config/td-agent.conf` contains the fluentd config. You might change it to consume also journald logs or further logs of the kubelet.

## Demo

The demo relies on minikube. You have to setup minikube and then run:
```
minikube start
eval $(minikube docker-env)
```
The above will start a minikube cluster and setup the docker client in your current shell to the minikube cluster docker daemon. 

To run this demo you have to create the image of the fluentd shipper in the minikube VM. Run the following commands in the shell where you ran the commands above:

```
cd fluentd_image
make build
cd ../es-image
make build
cd ../kibana-image
make build
```

To setup the Elasticsearch Cluster and a kibana frontend run:
```
kubectl create -f kubernetes_config/es-controller.yaml
kubectl create -f kubernetes_config/kibana-controller.yaml
kubectl create -f kubernetes_config/es-service.yaml
kubectl create -f kubernetes_config/kibana-service.yaml

```

To start the fluentd daemonset run:
```
kubectl create configmap fluentd-config --from-file=kubernetes_config/fluentd_config/td-agent.conf --namespace=kube-system
kubectl create -f kubernetes_config/fluentd-daemonset.yaml
```

After this setup you can check the pods you have deployed. The command is:
```
kubectl --namespace=kube-system get pods
```
The output should look like this:
```
NAME                             READY     STATUS    RESTARTS   AGE
elasticsearch-logging-v1-15qsf   1/1       Running   0          2m
elasticsearch-logging-v1-278v2   1/1       Running   0          2m
fluentd-logging-mcegp            1/1       Running   0          10s
kibana-logging-v1-mmfv4          1/1       Running   0          2m
kube-addon-manager-minikubevm    1/1       Running   0          4m
kubernetes-dashboard-ms0el       1/1       Running   0          4m
```

To look at your logs visit the kibana dashboard. You can get the URL to the kibana dashboard via:
```
minikube service -n kube-system --url kibana-logging
```
