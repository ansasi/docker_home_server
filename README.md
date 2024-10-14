# Project Deployment

This project consists of multiple services, each deployed as a Docker container using `docker-compose`. Below, you'll find detailed information about the deployment process and descriptions of each service.

## Deployment Instructions

To deploy the project, follow these steps:

1. Create a directory to store the project files:

    ```bash
    mkdir -p /home/username/Projects
    ```

2. Navigate to the created directory:

    ```bash
    cd /home/username/Projects
    ```

3. Clone the project repository:

    ```bash
    git clone <repository url>
    ```

4. Navigate to the project directory:

    ```bash
    cd /home/username/Projects/ProjectName
    ```

5. Start all services using Docker Compose:

    ```bash
    docker-compose up -d
    ```

## Services Overview

Each service is designed to fulfill a specific role within the project. Below is a detailed explanation of each service:
| Service     | URL                          | Purpose                                                                                                      | Usage                                                                                                      |
|-------------|------------------------------|--------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------|
| Portainer   | `https://<device-ip>:9443`   | Portainer is a powerful management tool for Docker environments. It provides an easy-to-use web interface to manage Docker containers, images, volumes, and networks. | Visit the Portainer web UI to monitor and control your Docker containers. It simplifies the deployment and maintenance of Dockerized applications. |
| Jellyfin    | `http://<device-ip>:8096`    | Jellyfin is an open-source media server that allows you to manage and stream your media, including movies, TV shows, and music. | Access the Jellyfin web interface to organize your media library and start streaming content across your devices. It supports various clients and devices. |
| Nextcloud   | `https://<device-ip>`        | Nextcloud is a self-hosted file sync and share solution with powerful collaboration capabilities. It provides cloud storage, file sharing, calendar, contacts, and more. | After deployment, visit the Nextcloud web interface to manage your personal cloud. You can sync files across multiple devices, collaborate with others, and access a variety of Nextcloud apps. |
| MariaDB     | N/A                          | MariaDB serves as the backend database for Nextcloud and other services requiring SQL-based data storage. It provides a reliable and efficient storage solution. | MariaDB is managed automatically within the Docker environment, and it stores all database-related data, such as Nextcloud users and files metadata. |
| qBittorrent | `http://<device-ip>:8080`    | qBittorrent is a cross-platform free and open-source BitTorrent client. It supports modern features such as magnet links, bandwidth scheduling, and torrent search engine integration. | Use the web UI to manage your torrents. Upload torrent files or paste magnet links to start downloading and seeding files. Ensure proper configuration of upload/download limits. |
| PhotoPrism  | `http://<device-ip>:2342`    | PhotoPrism is an AI-powered photo management app that automatically organizes your photos, making it easier to search and browse by content. | Visit the PhotoPrism interface to organize, view, and share your photo collection. It automatically categorizes photos and can detect duplicate or similar images. |

## Future Services

| Service     | Description                                                                                                           | Usage                                                                                                                                            |
|-------------|-----------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| Home Assistant | Home Assistant is an open-source home automation platform that focuses on local control and privacy. It allows you to control smart devices, set up automations, and monitor your home environment. | After deployment, access the Home Assistant web interface to configure your smart home devices, create automations, and monitor sensors. It supports a wide range of integrations and customizations. |
| Pi-hole     | Pi-hole is a network-wide ad blocker that protects your devices from unwanted ads, trackers, and malware. It runs on a Raspberry Pi or other devices and blocks ads at the DNS level. | After deployment, configure your devices to use Pi-hole as the DNS server. It will block ads and trackers across your network, improving privacy and security. Access the Pi-hole web interface to monitor statistics and manage blocklists. |
| Prometheus  | Prometheus is an open-source monitoring and alerting toolkit designed for collecting and storing metrics from various systems. It provides powerful querying and visualization capabilities. | After deployment, configure Prometheus to scrape metrics from your services and systems. Create custom dashboards and alerts to monitor performance and health metrics. It integrates with Grafana for advanced visualization. |
| Grafana     | Grafana is a powerful data visualization and monitoring tool that integrates with various data sources, including databases, APIs, and IoT devices. It allows you to create dashboards and alerts for monitoring systems and services. | After deployment, configure Grafana to connect to your data sources and create custom dashboards to visualize metrics and data. It supports plugins and integrations with popular monitoring tools like Prometheus and InfluxDB. |
| Duplicati  | Duplicati is a backup software designed for securely storing encrypted, compressed backups. It supports a variety of backends, including cloud services, FTP, and WebDAV. | After configuring, use Duplicati to schedule backups of your important files and data. Set up encryption and backup destinations using its web-based interface. |
| Ariang     | Ariang is a web-based user interface for managing Aria2, a lightweight download manager that supports HTTP/FTP/SFTP, BitTorrent, and Metalink. | Use Ariang to control and manage downloads via Aria2. It supports advanced download functionalities such as segmented downloads, resumable transfers, and multi-source downloading. |

## Additional Configuration

Some services, such as Nextcloud, Jellyfin, and qBittorrent, require additional configuration after deployment. Please refer to the official documentation for each service for more details on setting up users, security options, and other advanced features.

## Security Considerations

- **Port and Access Control:** Ensure that you configure proper firewall rules to control access to each service. Only expose necessary services to external networks and secure them with HTTPS.
- **Passwords:** Replace all placeholder passwords in the `docker-compose.yml` file with strong, unique passwords before deploying the services.
- **SSL/TLS:** Use proper SSL/TLS certificates for services accessible over the internet (such as Nextcloud or Portainer) to secure data in transit.
