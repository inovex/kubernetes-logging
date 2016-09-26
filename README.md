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
cd kubernetes_config
kubectl create -f es-controller.yaml
kubectl create -f kibana-controller.yaml
kubectl create -f es-service.yaml
kubectl create -f kibana-service.yaml
```

You can get the URL to the kibana dashboard via:
```
minikube service -n kube-system --url kibana-logging
```

To start the fluentd daemonset run:
```
cd kubernetes_config
kubectl create -f fluentd-daemonset.yaml
```