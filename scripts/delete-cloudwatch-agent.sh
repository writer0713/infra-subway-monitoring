#!/bin/bash

sudo systemctl disable amazon-cloudwatch-agent
sudo dpkg -r amazon-cloudwatch-agent
sudo rm -rf /opt/aws

echo "
#### Done... ####
"