#!/bin/bash
# -----------------------------------------------
# Userdata script: Setup Docker, Git, & Bootstrap App
# -----------------------------------------------

set -e

# Update system packages
yum update -y

# Install Git
yum install -y git

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

# Create symlink to match CI/CD expectations
ln -sf /usr/local/bin/docker-compose /usr/bin/docker-compose

# Define variables
REPO_URL="https://github.com/Prenay123/Devops-Assignment.git"
APP_DIR="/home/ec2-user/app"

# Bootstrap application
echo "Bootstrapping app from repository..."
git clone "$REPO_URL" "$APP_DIR"
chown -R ec2-user:ec2-user "$APP_DIR"

# Run initial docker-compose up as ec2-user
cd "$APP_DIR"
sudo -u ec2-user docker-compose up -d --build

echo "Docker installation and application bootstrapping complete."

