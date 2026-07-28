#!/bin/bash
# =============================================================
# server-setup.sh
# Run this ONCE on your EC2 instance to prepare it for CI/CD
# Usage: bash server-setup.sh <YOUR_GITHUB_REPO_URL>
# Example: bash server-setup.sh https://github.com/yourname/devops-app.git
# =============================================================

set -e

REPO_URL="${1}"
APP_DIR="$HOME/app"

if [ -z "$REPO_URL" ]; then
  echo "❌ Usage: bash server-setup.sh <YOUR_GITHUB_REPO_URL>"
  exit 1
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Step 1: Update system packages"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
sudo yum update -y

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Step 2: Install Git"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
sudo yum install -y git

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Step 3: Install Docker"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
sudo amazon-linux-extras install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Step 4: Install Docker Compose V2"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 \
  -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

# Verify
docker compose version

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Step 5: Clone repository to ~/app"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ -d "$APP_DIR" ]; then
  echo "📁 ~/app already exists, pulling latest instead..."
  cd "$APP_DIR" && git pull origin main
else
  git clone "$REPO_URL" "$APP_DIR"
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Step 6: Initial Docker build & start"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
cd "$APP_DIR"
docker compose up -d --build

echo ""
echo "✅ Server setup complete!"
echo ""
echo "🔑 NEXT STEP — Add these 3 GitHub Secrets to your repository:"
echo "   Settings → Secrets and variables → Actions → New repository secret"
echo ""
echo "   EC2_HOST            → $(curl -s http://169.254.169.254/latest/meta-data/public-ipv4 2>/dev/null || echo '<your-ec2-public-ip>')"
echo "   EC2_USER            → ec2-user"
echo "   EC2_SSH_PRIVATE_KEY → (paste your private key .pem file content)"
echo ""
echo "🌐 Your app should now be live at: http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4 2>/dev/null || echo '<your-ec2-public-ip>')"
