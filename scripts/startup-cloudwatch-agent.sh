#!/bin/bash

echo "
#### Start cloudwatch-agent ####
....
"

echo "
#### Cat config file ####
"
sudo cat /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
sudo systemctl status amazon-cloudwatch-agent

echo "
Success!!
"