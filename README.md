# devops-capstone-project
Pipeline for integrating and deploying a machine learning application in a AWS EKS cluster with a rolling deployment strategy.

## Required tools

This example uses `eksctl`, `kubectl` and the `aws cli`, to install and configure these tools please follow the instructions [here](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html).


## Launching an EKS cluster in AWS

Before launching the EKS cluster make sure that your AWS user have the required policies created.
You can find the json file with the required policies in `kubernetes/aws-eks-policy.json`. The link with the explanation is [here](https://github.com/weaveworks/eksctl/issues/2182#issuecomment-632813880).

To create an EKS cluster you only need to execute:
```
eksctl create cluster -f kubernetes/cluster-config.yml
```
Update the `cluster-config.yml` to adapt the cluster to your requirements. More information about the configuration file can be found [here](https://eksctl.io/usage/schema/).

When you finish with the cluster don't forget to delete it with the command:
```
eksctl delete cluster -f kubernetes/cluster-config.yml
```

## Jenkins Pipeline

The `Jenkinsfile` can be used to create a pipeline in Jenkins that automatically deploys the application when a new change is pushed to this repository.

The pipeline automatically creates a rolling deployment using the files `app-deployment.yml` and the `app-service.yml` from the `kubernetes` folder, and the docker container image deployed has a tag that matches the build number of the jenkins job to ease the debugging.

The defined Jenkins pipeline executes the steps inside docker containers, to build the required docker containers you can used the Dockerfiles in the folders inside `containers`.

## Makefile

To simplify the container and the cluster creation you can use the Makefile available.
First edit the `USER` variable inside the Makefile to match your DockerHub username and then you can build all the containers executing:
```
make build-all-images
```

You can also upload the created images with the command:
```
make upload-all-images
```

Additionally the makefile can create/upload the images individually. Also the makefile can be used to create and delete the AWS EKS cluster.

## Test the application

Once the application is deployed in the EKS cluster you can use the `make-predictions.sh` script available in the `scripts` folder to test the application. The script automatically retrieves the Load Balancer endpoint and launches a test prediction.

```
$ ./scripts/make-prediction.sh
```
If everything is configured correctly you should see and output like the following:

```
ENDPOINT: a637c7c5d14a7499abd5961ec5c2j8u5-647450472.us-west-2.elb.amazonaws.com:8000
{
  "prediction": [
    20.35373177134412
  ]
}

```


