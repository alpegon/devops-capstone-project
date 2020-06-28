FROM ubuntu:latest

RUN apt update &&\
    apt install -y curl unzip

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" &&\
    unzip awscliv2.zip &&\
    ./aws/install

RUN curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/kubectl &&\
    chmod +x ./kubectl &&\
    mv kubectl /usr/local/bin/
