# Kubernetes Logging into Elasticsearch

## Demo

The demo relies on minikube. You have to setup minikube and then run:
```
minikube start
eval (minikube docker-env)
```
The above will start a minikube cluster and setup the docker client in your current shell to the minikube cluster docker daemon. 

To run this demo you have to create the image of the fluentd shipper in the minikube VM. Run the following commands in the shell where you ran the commands above:

```
cd fluentd_image
make build
```

To setup the Elasticsearch Cluster and a kibana frontend run:
```
kubectl create -f kubernetes_config/es-controller.yaml
kubectl create -f kubernetes_config/kibana-controller.yaml
kubectl create -f kubernetes_config/es-service.yaml
kubectl create -f kubernetes_config/kibana-service.yaml

```

You can get the URL to the kibana dashboard via:
```
minikube service -n kube-system --url kibana-logging
```

To start the fluentd daemonset run:
```
kubectl create configmap fluentd-config --from-file=kubernetes_config/fluentd_config/td-agent.conf --namespace=kube-system
kubectl create -f kubernetes_config/fluentd-daemonset.yaml
```