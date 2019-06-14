#!/usr/bin/env bash

set -e

wget -q https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
sudo dpkg -E -i ./amazon-cloudwatch-agent.deb

cat config-file-template.json | "s/container-test-1/${1}/g" > /opt/aws/amazon-cloudwatch-agent/etc/config-file.json

cp credentials /opt/aws/amazon-cloudwatch-agent/etc/

echo "[credentials]
    shared_credential_file = \"/opt/aws/amazon-cloudwatch-agent/etc/\"
" > /opt/aws/amazon-cloudwatch-agent/etc/common-config.toml

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
    -a fetch-config \
    -m onPremise \
    -c file:/opt/aws/amazon-cloudwatch-agent/etc/config-file.json \
    -s
