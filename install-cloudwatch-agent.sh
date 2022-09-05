#!/bin/bash

HOME="/home/ubuntu/"
APPS_DIR="${HOME}/apps"
SCRIPTS_DIR="${HOME}/server-manage"

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
#### Create amazon-cloudwatch-agent.json ####
...
"
sudo touch /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
sudo bash -c 'cat << EOF > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
{
        "agent": {
                "metrics_collection_interval": 60,
                "run_as_user": "root"
        },
        "metrics": {
                "metrics_collected": {
                        "disk": {
                                "measurement": [
                                        "used_percent",
                                        "used",
                                        "total"
                                ],
                                "metrics_collection_interval": 60,
                                "resources": [
                                        "*"
                                ]
                        },
                        "mem": {
                                "measurement": [
                                        "mem_used_percent",
                                        "mem_total",
                                        "mem_used"
                                ],
                                "metrics_collection_interval": 60
                        }
                }
        }
}
EOF'

echo "
#### successfully installed!! ####
"

# startup cloudwatch-agent
cd $SCRIPTS_DIR
sudo ./startup-cloudwatch-agent.sh


