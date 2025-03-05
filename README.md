# Docker Home Server

This project contains the configuration files for a Docker-based home server setup.

Technologies used:

- Ansible. For provisioning.
- Docker. For containerization.
- Docker Compose. For managing multi-container applications.

## Project Structure

The 


## Project Deployment

This project consists of multiple services, each deployed as a Docker container using `docker-compose`. Below, you'll find detailed information about the deployment process and descriptions of each service.

## Deployment Instructions


## Services Overview

These are the services included in the Docker Home Server setup:

| Service     | URL                          | Purpose                                                      |
|-------------|------------------------------|----------------------------------------------------------------|
| Portainer   | https://localhost:9000        | Container management and monitoring tool.                     |
| Traefik     | http://localhost:8080        | Reverse proxy and SSL termination for web services.            |


## Future Services

| Service     | Description                                                                                                           | Usage                                                                                                                                            |
|-------------|-----------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| Home Assistant | Home Assistant is an open-source home automation platform that focuses on local control and privacy. It allows you to control smart devices, set up automations, and monitor your home environment. | After deployment, access the Home Assistant web interface to configure your smart home devices, create automations, and monitor sensors. It supports a wide range of integrations and customizations. |
| Pi-hole     | Pi-hole is a network-wide ad blocker that protects your devices from unwanted ads, trackers, and malware. It runs on a Raspberry Pi or other devices and blocks ads at the DNS level. | After deployment, configure your devices to use Pi-hole as the DNS server. It will block ads and trackers across your network, improving privacy and security. Access the Pi-hole web interface to monitor statistics and manage blocklists. |
| Duplicati  | Duplicati is a backup software designed for securely storing encrypted, compressed backups. It supports a variety of backends, including cloud services, FTP, and WebDAV. | After configuring, use Duplicati to schedule backups of your important files and data. Set up encryption and backup destinations using its web-based interface. |
| Ariang     | Ariang is a web-based user interface for managing Aria2, a lightweight download manager that supports HTTP/FTP/SFTP, BitTorrent, and Metalink. | Use Ariang to control and manage downloads via Aria2. It supports advanced download functionalities such as segmented downloads, resumable transfers, and multi-source downloading. |
| Kestra     | Kestra is a workflow automation tool that allows you to define, schedule, and monitor complex data processing pipelines. It supports various data sources, transformations, and actions. | Use Kestra to automate data processing tasks, such as ETL jobs, data migrations, and report generation. Define workflows using a visual editor and monitor their execution through the web interface. |
| Ofelia     | Ofelia is a job scheduler that allows you to run periodic tasks, such as backups, maintenance scripts, and other automated processes. It provides a simple web interface for managing cron jobs. | Use Ofelia to schedule and automate recurring tasks on your server. Define job schedules, commands, and notifications through the web UI. |

## Additional Configuration

Some services, such as Nextcloud, Jellyfin, and qBittorrent, require additional configuration after deployment. Please refer to the official documentation for each service for more details on setting up users, security options, and other advanced features.

## TODO

- Secrets management. Have a proper secrets manager tool. Some options:
  - Vault (Hashicorp).
