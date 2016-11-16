# Copyright 2016 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

.PHONY: build push
 
REGISTRY = local
IMAGE = infrastructure/docker-elasticsearch-curator
CURATOR_VERSION = 3.4.0

ifndef GIT_TAG
        GIT_TAG=0.0.1
endif

TAG:=$(CURATOR_VERSION)-$(GIT_TAG)

build:	
	docker build --build-arg CURATOR_VERSION=$(CURATOR_VERSION) -t $(REGISTRY)/$(IMAGE):$(TAG) .

push: build
	docker login -u gitlab-ci-token -p ${CI_BUILD_TOKEN} ${REGISTRY}
	docker push $(REGISTRY)/$(IMAGE):$(TAG)

clean:
	rm -rf bin/
