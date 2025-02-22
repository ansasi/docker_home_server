# Docker Compose Setup for Portainer (and Optional Watchtower)

This repository contains a Docker Compose configuration that deploys [Portainer CE](https://www.portainer.io/) for managing your Docker environment. There is also an optional [Watchtower](https://containrrr.dev/watchtower/) configuration (commented out) for automatic container updates.

## Table of Contents

- [Docker Compose Setup for Portainer (and Optional Watchtower)](#docker-compose-setup-for-portainer-and-optional-watchtower)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Services](#services)
    - [Portainer](#portainer)
    - [Watchtower (Optional)](#watchtower-optional)
  - [Volumes and Networks](#volumes-and-networks)
    - [Volumes](#volumes)
    - [Networks](#networks)
  - [Traefik Labels](#traefik-labels)
  - [Usage](#usage)

## Overview

This Docker Compose file (version 3.8) sets up a containerized environment using Docker. It includes:
- **Portainer**: A lightweight management UI that allows you to easily manage your Docker environments.
- **Watchtower (optional)**: A tool to automatically update your running containers whenever a new image is available (this section is commented out by default).

The configuration also defines a dedicated volume for Portainer data and a custom network for management purposes.

## Services

### Portainer

The **Portainer** service is configured with:
- **Image**: `portainer/portainer-ce`
- **Container Name**: `portainer`
- **Volumes**:
  - Bind mount the Docker socket to enable Docker management.
  - A named volume (`portainer-data`) to persist Portainer data.
- **Networks**: Attached to the `management` network.
- **Ports**: Exposes Portainer's web UI on port `9000` (mapped to the host).
- **Traefik Labels**: Configured for Traefik reverse proxy with TLS using a Cloudflare certificate resolver.
- **Restart Policy**: `unless-stopped` to ensure the container restarts automatically if it exits unexpectedly.

### Watchtower (Optional)

The **Watchtower** service (currently commented out) is set up to:
- Monitor your running containers.
- Automatically update them when new images are available.
- Remove old images and volumes to save disk space.
- Use a custom schedule (e.g., run at 4 AM daily).

To enable Watchtower:
1. Uncomment the Watchtower section.
2. Adjust any environment variables as needed.

## Volumes and Networks

### Volumes

- **portainer-data**: A named volume using the local driver to persist Portainer's data.

### Networks

- **management**: A user-defined bridge network that ensures the services can communicate securely.  
  The network is set to be attachable and is not internal, allowing external access if needed. There are commented out IPAM settings if you wish to customize the subnet and gateway.

## Traefik Labels

The Portainer service includes several labels for integration with [Traefik](https://traefik.io/). These labels:
- Enable Traefik for the container.
- Define the router for Portainer with TLS enabled.
- Set the entrypoint (`websecure`) and certificate resolver (`cloudflare`).
- Map the router rule to the host `portainer.sheetgenius.app`.
- Specify the backend service port (`9000`).

Ensure that your Traefik instance is properly configured to use these labels and that DNS for `portainer.sheetgenius.app` points to your Traefik instance.

## Usage

1. **Install Docker and Docker Compose**

   Ensure that you have [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/) installed on your system.

2. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/your-repo.git
   cd your-repo

3. **Create Necessary Directories**

    Create the necessary directories for persistent volumes:
    ```bash
    mkdir -p portainer/data
    ```

4. **Review and Adjust Configuration**

    - **Traefik Labels**: Update the Traefik labels in the `docker-compose.yml` file to match your setup.
    - **Watchtower (Optional)**: Uncomment the Watchtower service if you want to enable automatic updates.
    - **Network Configuration**: Modify the network settings if needed.
    - **Portainer Data Volume**: Adjust the volume mapping if necessary.
    - **Portainer Port**: Change the host port if needed.

5. **Start the Stack**

    Run the following command to start the services:
    ```bash
    docker-compose up -d
    ```
