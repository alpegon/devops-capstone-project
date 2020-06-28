## The Makefile includes instructions on running the commands

USER=alpegon

HADOLINT=$(USER)/hadolint
KUBEOPS=$(USER)/kubeops
PYLINT=$(USER)/pylint
APP=$(USER)/house-price-prediction

build-hadolint:
	docker build -t $(HADOLINT) -f containers/hadolint/Dockerfile .

build-kubeops:
	docker build -t $(KUBEOPS) -f containers/kubeops/Dockerfile .

build-pylint:
	docker build -t $(PYLINT) -f containers/pylint/Dockerfile .

build-app:
	docker build -t $(APP) -f containers/app/Dockerfile .

upload-hadolint:
	docker push $(HADOLINT)

upload-kubeops:
	docker push $(KUBEOPS)

upload-pylint:
	docker push $(PYLINT)

upload-app:
	docker push $(APP)

build-all-images: build-hadolint build-kubeops build-pylint build-app

upload-all-images: upload-hadolint upload-kubeops upload-pylint upload-app

create-eks-cluster:
	eksctl create cluster -f kubernetes/cluster-config.yml

delete-eks-cluster:
	eksctl delete cluster -f kubernetes/cluster-config.yml
