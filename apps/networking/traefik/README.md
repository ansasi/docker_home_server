# Traefik

## Introduction

Traefik is a popular reverse proxy that integrates well with Docker to manage and automate SSL certificates, routing, and load balancing.

## Installation Steps

1. Create a Docker Compose file referencing the official Traefik image.
2. Map ports 80 and 443 to expose HTTP and HTTPS.
3. Mount a configuration file and a volume for SSL certificates.
4. Include labels for Traefik to manage containers automatically.
5. Create a password using `htpasswd` for the Traefik dashboard.
   1. Install `apache2-utils` package.
   2. Run `echo $(htpasswd -nb "<user>" "<password>") | sed -e s/\\$/\\$\\$/g` to generate a password hash.

## Usage Examples in other Docker Compose Files

### Portainer

```yaml
---

---
networks:
  frontend:
    external: true

volumes:
  portainer-data:
    driver: local

services:
  portainer:
    image: portainer/portainer-ce
    container_name: portainer
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer-data:/data
    networks:
      - frontend
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.portainer.entrypoints=websecure"
      - "traefik.http.routers.portainer.rule=Host(`portainer.sheetgenius.app`)"
      - "traefik.http.routers.portainer.tls=true"
      - "traefik.http.routers.portainer.tls.certresolver=cloudflare"
      - "traefik.http.services.portainer.loadbalancer.server.port=9000"
    restart: unless-stopped
```

### Grafana

```yaml

---
networks:
  frontend:
    external: true

volumes:
  grafana-data:
    driver: local

services:
  grafana:
    image: grafana/grafana
    container_name: grafana
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin  # TODO: Replace with a secure password
    volumes:
      - grafana-data:/var/lib/grafana
    networks:
      - frontend
    labels:
      - traefik.enable=true
      - traefik.http.routers.grafana-http.entrypoints=web
      - traefik.http.routers.grafana-http.rule=Host(`grafana.sheetgenius.app`)
      - traefik.http.routers.grafana-https.entrypoints=websecure
      - traefik.http.routers.grafana-https.rule=Host(`grafana.sheetgenius.app`)
      - traefik.http.routers.grafana-https.tls=true
      - traefik.http.routers.grafana-https.tls.certresolver=cloudflare
    restart: unless-stopped
```
