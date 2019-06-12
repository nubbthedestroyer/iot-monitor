#!/usr/bin/env bash

wget -q https://s3.amazonaws.com/amazoncloudwatch-agent/redhat/amd64/latest/amazon-cloudwatch-agent.rpm
sudo rpm -U ./amazon-cloudwatch-agent.rpm

cat config-file-template.json | "s/container-test-1/${1}/g" > config-file.json

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
    -a fetch-config \
    -m onPremise \
    -c file:`pwd`/config-file.json \
    -s
