#!/bin/bash
# This is simple automation script to create and start docker image for my project.
# additional commands could be added to export and propagade docker image to AWS s3 bucket and use it in userdata script for ec2 instance startup. 
DOC_IMG_NAME=max-html:v1
DOC_IMG_TAR=${DOC_IMG_NAME}.tar
ACCESS_PORT=8080
LOG_FILE=${DOC_IMG_NAME}.log

echo "----------------------"  >> $LOG_FILE
date >> $LOG_FILE
echo "*** Terminate any running docker containers ..."
( docker ps -q | xargs -i docker kill {} ) >> $LOG_FILE

echo "*** Removing existing $DOC_IMG_NAME docker image ..."
( docker images max-html-image -q | xargs -i docker rmi --force {} ) >> $LOG_FILE

echo "*** Building $DOC_IMG_NAME docker image ..."
( docker build -t $DOC_IMG_NAME . ) >> $LOG_FILE

#echo "*** Saving $DOC_IMG_NAME as $DOC_IMG_TAR ..."
#( docker save --output $DOC_IMG_TAR max-html-image:v1 ) >> $LOG_FILE

echo "*** Starting container for  $DOC_IMG_NAME ..."
( docker run -d -p ${ACCESS_PORT}:80 $DOC_IMG_NAME ) >> $LOG_FILE

echo "ATTENTION: Open URL http://${HOSTNAME}:${ACCESS_PORT} in Web browser to check how it works"

