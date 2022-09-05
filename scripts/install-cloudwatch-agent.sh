#!/bin/bash

HOME="/home/ubuntu/"
APPS_DIR="${HOME}/apps"
SCRIPTS_DIR="${HOME}/server-manage/scripts"

echo "
#### init apps directory ####
"
mkdir -p $APPS_DIR
cd $APPS_DIR

echo "
#### install cloudwatch-agent ####
...
"
sudo wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
sudo dpkg -i -E ./amazon-cloudwatch-agent.deb
rm -f ./amazon-cloudwatch-agent*

echo "
#### Copy amazon-cloudwatch-agent.json ####
...
"
cd $SCRIPTS_DIR
sudo cp ../configs/amazon-cloudwatch-agent.json /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

echo "
#### successfully installed!! ####
"

# startup cloudwatch-agent
cd $SCRIPTS_DIR
sudo ./startup-cloudwatch-agent.sh


