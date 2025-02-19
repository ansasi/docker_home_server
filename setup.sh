#!/bin/bash

# Update package list and upgrade installed packages
sudo apt update
sudo apt upgrade -y

# Install prerequisite packages
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common \
    python3-pip

# Install Docker using the convenience script
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Add the current user to the Docker group
sudo usermod -aG docker $USER

# Install Docker Compose
sudo pip3 install docker-compose

# Create basic networks for docker reverse proxy (traefik)
sudo docker network create proxy

# Create necessary directories for volume mounts
mkdir -p /path/to/jellyfin/config
mkdir -p /path/to/jellyfin/cache
mkdir -p /path/to/media
mkdir -p /nextcloud/html
...

# Set appropriate permissions for the directories (optional)
sudo chown -R $USER:$USER /path/to/
sudo chown -R $USER:$USER /nextcloud/
...

# Notify the user to log out and back in
echo "Installation complete!"
echo "Please log out and log back in for the group changes to take effect."
echo "Also, ensure that you've replaced all placeholder paths and passwords in your Docker Compose file before deploying."
