#!/bin/bash
# -----------------------------------------------
# Userdata script: Setup Docker, Git, & Bootstrap App
# -----------------------------------------------

#!/bin/bash
set -eux

# Update system
dnf update -y

# Install Git
dnf install -y git

# Install Docker
dnf install -y docker

# Enable Docker
systemctl enable docker
systemctl start docker

# Add ec2-user to docker group
usermod -aG docker ec2-user

# Install Docker Buildx
mkdir -p /usr/libexec/docker/cli-plugins

curl -SL https://github.com/docker/buildx/releases/download/v0.21.1/buildx-v0.21.1.linux-amd64 \
-o /usr/libexec/docker/cli-plugins/docker-buildx

chmod +x /usr/libexec/docker/cli-plugins/docker-buildx

# Install Docker Compose Plugin
mkdir -p /usr/libexec/docker/cli-plugins

curl -SL https://github.com/docker/compose/releases/download/v2.39.1/docker-compose-linux-x86_64 \
-o /usr/libexec/docker/cli-plugins/docker-compose

chmod +x /usr/libexec/docker/cli-plugins/docker-compose

# Verify installation
docker --version
docker compose version
docker buildx version

# Clone application
REPO_URL="https://github.com/Prenay123/Devops-Assignment.git"
APP_DIR="/home/ec2-user/app"

git clone "$REPO_URL" "$APP_DIR"

chown -R ec2-user:ec2-user "$APP_DIR"

cd "$APP_DIR/devops"

docker compose up -d --build

echo "Docker installation and application bootstrapping complete."

