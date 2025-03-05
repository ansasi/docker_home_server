# Docker Home Server

This project contains the configuration files for a Docker-based home server setup.

Technologies used:

- Ansible. For provisioning.
- Docker. For containerization.
- Docker Compose. For managing multi-container applications.

## Project Deployment

For deplying the project, follow these steps:

1. Clone the repository.

2. Cd into the `ansible` directory.

   ```bash
   cd ansible
   ```

3. Fill the ansible vars file located in `ansible/group_vars/all.yml` with the necessary values.

4. Run the Ansible playbook.

   ```bash
   ansible-playbook -i inventory/hosts.ini site.yml
   ```

## Deployment Instructions

## Services Overview

These are the services included in the Docker Home Server setup:

| Service     | URL             | Purpose       |
|-------------|-----------------|---------------|
| Portainer   | <https://portainer.sheetgenius.app>      | Container management and monitoring tool.                     |
| Traefik     | <https://traefik-dashboard.sheetgenius.app>        | Reverse proxy and SSL termination for web services.            |
| Pihole      | <https://pihole.sheetgenius.app>             | Network-wide ad blocker and DNS server.                       |
| Home Assistant | <https://homeassistant.sheetgenius.app>       | Home automation platform for smart devices.                   |
| Watchtower  | N/A             | Automatic updates for Docker containers.                      |

## Future Services

| Service     | Type | Description      |
|-------------|--------- | ---------|
| Nextcloud   | Media | Self-hosted cloud storage. |
| Grafana     | Monitoring | Monitoring and visualization tool. |
| Uptime Kuma | Monitoring | Website uptime monitoring tool. |

## TODO

- Secrets management. Have a proper secrets manager tool. Some options:
  - Vault (Hashicorp).
  - 1Password.
  - Bitwarden.
- Monitoring and alerting. Set up monitoring and alerting for the services.
  - Prometheus + Grafana.
  - Gotify.  
