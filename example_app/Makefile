.PHONY:	build push

# Change these values according to your private or public registry setup.
REGISTRY = local
IMAGE = loggingapp
TAG = 0.1
build:	
	docker build -t $(REGISTRY)/$(IMAGE):$(TAG) -t $(REGISTRY)/$(IMAGE):latest  .

push:	
	docker push $(REGISTRY)/$(IMAGE):$(TAG)
	docker push $(REGISTRY)/$(IMAGE):latest
