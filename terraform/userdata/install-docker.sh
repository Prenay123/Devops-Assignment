#!/bin/bash
# -----------------------------------------------
# Userdata script: Install Docker on Amazon Linux 2
# -----------------------------------------------

set -e

# Update system packages
yum update -y

# Install Docker
amazon-linux-extras install docker -y

# Start and enable Docker service
systemctl start docker
systemctl enable docker

# Add ec2-user to docker group so it can run docker without sudo
usermod -aG docker ec2-user

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "Docker installation complete."
