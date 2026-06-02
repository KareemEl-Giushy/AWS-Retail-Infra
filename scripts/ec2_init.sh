# !/bin/bash

apt update

apt upgrade

sudo snap install amazon-ssm-agent --classic

sudo systemctl start snap.amazon-ssm-agent.amazon-ssm-agent.service
