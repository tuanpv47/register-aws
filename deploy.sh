#!/bin/bash
cd ./register-aws
ls
MY_IP=`curl ifconfig.me`
echo $MY_IP
echo "Start deploy container - [START]";
CONTAINER_NAMES=`sudo docker ps -aqf "name=register-aws" --format "{{.Names}}"`
echo $CONTAINER_NAMES
if [ -n "${CONTAINER_NAMES}" ]
then
    DOCKER_STOP=`sudo docker stop register-aws`
    DOCKER_RM=`sudo docker rm register-aws`
fi
DOCKER_BUILD=`sudo docker build --tag register-aws-image-1 .`
DOCKER_RUN=`sudo docker run -it -d --name register-aws -e PORT=80 --restart=always -p 80:80 register-aws-image-1`
DOCKER_PRUNE=`sudo docker image prune -a --force`
echo "Finish deploy container - [END]";