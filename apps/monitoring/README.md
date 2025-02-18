# Monitoring Stack Docker Compose

This repository provides a Docker Compose configuration that sets up a comprehensive monitoring stack. The stack includes tools for uptime monitoring, real-time system performance, metric collection, dashboard visualization, and network speed testing. Below is an overview of each service, configuration details, and instructions on how to get started.

## Table of Contents

- [Monitoring Stack Docker Compose](#monitoring-stack-docker-compose)
  - [Table of Contents](#table-of-contents)
  - [Services Overview](#services-overview)
    - [Uptime Kuma](#uptime-kuma)
    - [Netdata](#netdata)
    - [Grafana](#grafana)
    - [Prometheus](#prometheus)
    - [OpenSpeedTest](#openspeedtest)
  - [Networks](#networks)
  - [Installation](#installation)
    - [Prerequisites](#prerequisites)
    - [Steps](#steps)
  - [Troubleshooting](#troubleshooting)

## Services Overview

### Uptime Kuma

- **Image:** `louislam/uptime-kuma:latest`
- **Container Name:** `uptimekuma`
- **Description:**  
  Uptime Kuma is a self-hosted monitoring tool that allows you to keep track of the uptime of your websites and services.
- **Volumes:**
  - `./monitoring/uptime-kuma/data` → `/app/data` (Persistent storage for uptime data)
  - `/var/run/docker.sock` → `/var/run/docker.sock` (Allows monitoring of Docker containers)
- **Ports:**  
  - Maps container port `3001` to host port `8160`
- **Restart Policy:** `unless-stopped`
- **Network:** Connected to the custom network `netmonitor`

---

### Netdata

- **Image:** `netdata/netdata`
- **Container Name:** `netdata`
- **Description:**  
  Netdata provides real-time performance monitoring and health visualization of your system and applications.
- **Capabilities & Security:**
  - Adds `SYS_PTRACE` capability for advanced monitoring.
  - Uses `apparmor:unconfined` to relax security restrictions for full functionality.
- **Volumes:**
  - `/proc` → `/host/proc:ro`
  - `/sys` → `/host/sys:ro`
  - `/etc/os-release` → `/host/etc/os-release:ro`
  - `/etc/passwd` → `/host/etc/passwd:ro`
  - `/etc/group` → `/host/etc/group:ro`
  - *(Optional: Uncomment additional volumes to customize Netdata configuration and storage)*
- **Ports:**  
  - Maps container port `19999` to host port `8166`
- **Restart Policy:** `unless-stopped`
- **Network:** Connected to the custom network `netmonitor`

---

### Grafana

- **Image:** `grafana/grafana-oss:latest`
- **Container Name:** `grafana`
- **Description:**  
  Grafana is a powerful dashboard tool that visualizes metrics collected from Prometheus and other sources.
- **Volumes:**
  - `./monitoring/grafana/data` → `/var/lib/grafana` (Stores dashboards, data sources, and configuration)
- **Ports:**  
  - Maps container port `3000` to host port `8164`
- **Restart Policy:** `unless-stopped`
- **Network:** Connected to the custom network `netmonitor`

---

### Prometheus

- **Image:** `prom/prometheus:latest`
- **Container Name:** `prometheus`
- **Description:**  
  Prometheus is a leading open-source system for collecting metrics and generating alerts.
- **Command:**
  - Uses the command `--config.file=/etc/prometheus` to specify the configuration file location.
- **Volumes:**
  - `/etc/prometheus` (Host directory for Prometheus configuration)
  - `./monitoring/prometheus/data` → `/prometheus` (Persistent storage for metrics data)
- **Ports:**  
  - Maps container port `9090` to host port `8163`
- **Restart Policy:** `unless-stopped`
- **Network:** Connected to the custom network `netmonitor`

---

### OpenSpeedTest

- **Image:** `openspeedtest:latest`
- **Container Name:** `openspeedtest`
- **Description:**  
  OpenSpeedTest provides a web-based interface for testing your network speed and performance.
- **Ports:**  
  - Maps container port `3000` to host port `8161`
  - Maps container port `3001` to host port `8162`
- **Restart Policy:** `unless-stopped`
- **Network:** Connected to the custom network `netmonitor`

---

## Networks

All services are connected to a custom Docker network named `netmonitor` with the following configuration:

- **Driver:** `bridge`
- **Attachable:** `true`
- **Internal:** `false`
- **IPAM Configuration:**
  - **Subnet:** `172.50.0.0/16`  
    *(Change this to a preferred range if necessary)*
  - **Gateway:** `172.50.0.1`

---

## Installation

### Prerequisites

- **Docker Engine:** [Installation Guide](https://docs.docker.com/engine/install/)
- **Docker Compose:** [Installation Guide](https://docs.docker.com/compose/install/)

### Steps

1. **Clone the Repository:**

   ```bash
   git clone https://your-repository-url.git
   cd your-repository-directory
   ```

2. **Create Necessary Directories for Persistent Volumes:**

   Ensure that the following directories exist on your host machine:

   ```bash
   mkdir -p monitoring/uptime-kuma/data
   mkdir -p monitoring/grafana/data
   mkdir -p monitoring/prometheus/data
   ```

3. **Review & Adjust Configuration:**

   - **Network Subnet:**  
     Edit the subnet in the docker-compose.yml file if it conflicts with your existing network configuration.
   - **Prometheus Config:**  
     Ensure that a valid Prometheus configuration file is available in `/etc/prometheus` on your host.
   - **Optional Netdata Configurations:**  
     Uncomment additional volume mappings in the Netdata service if you wish to customize its configuration.

4. **Start the Stack:**

   From the directory containing the docker-compose.yml file, run:

   ```bash
   docker-compose up -d
   ```

5. **Access the Services:**

   Open your browser and navigate to the following URLs (replace `your-host` with your server's IP or domain):

   - **Uptime Kuma:** [http://your-host:8160](http://your-host:8160)
   - **Netdata:** [http://your-host:8166](http://your-host:8166)
   - **Grafana:** [http://your-host:8164](http://your-host:8164)
   - **Prometheus:** [http://your-host:8163](http://your-host:8163)
   - **OpenSpeedTest:** [http://your-host:8161](http://your-host:8161)  
     *(Also accessible via port 8162 for an alternative interface if configured)*

6. **Viewing Logs:**

   To check logs for a specific service, run:

   ```bash
   docker-compose logs -f <service_name>
   ```

   Replace `<service_name>` with one of: `uptimekuma`, `netdata`, `grafana`, `prometheus`, or `openspeedtest`.

## Troubleshooting

- **Port Conflicts:**  
  Verify that the host ports (`8160`, `8161`, `8162`, `8163`, `8164`, `8166`) are not already in use.

- **Persistent Data Issues:**  
  Confirm that the host directories for volumes exist and have the correct permissions.

- **Network Configuration:**  
  Ensure the custom network `netmonitor` does not conflict with other Docker networks. Adjust the subnet if necessary.

- **Configuration Files:**  
  For Prometheus, ensure that the `/etc/prometheus` directory on your host contains a valid configuration file.

- **Service-Specific Logs:**  
  Use `docker-compose logs -f <service_name>` to view real-time logs and diagnose issues.
