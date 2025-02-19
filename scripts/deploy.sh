#!/bin/bash
set -e

# Define playbook paths
PLAYBOOK_DIR="ansible/playbooks"
INSTALL_PLAYBOOK="${PLAYBOOK_DIR}/install-docker.yml"
DEPLOY_PLAYBOOK="${PLAYBOOK_DIR}/deploy-docker-apps.yml"

# Usage function to display help
usage() {
  echo "Usage: $0 [--install-docker | --deploy | --all] [--app <app_name>]"
  echo ""
  echo "Options:"
  echo "  --install-docker   Run the playbook to install Docker and Docker Compose."
  echo "  --deploy           Run the playbook to deploy Docker Compose apps."
  echo "  --all              Run both installation and deployment playbooks."
  echo "  --app <app_name>   (Optional) When used with --deploy or --all, deploy only the specified app."
  exit 1
}

# Check if ansible-playbook is installed
if ! command -v ansible-playbook &> /dev/null; then
  echo "Error: ansible-playbook is not installed. Please install Ansible."
  exit 1
fi

# Parse command-line arguments
if [ "$#" -eq 0 ]; then
  usage
fi

ACTION=""
APP_NAME=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --install-docker)
      ACTION="install-docker"
      shift
      ;;
    --deploy)
      ACTION="deploy"
      shift
      ;;
    --all)
      ACTION="all"
      shift
      ;;
    --app)
      if [ -n "$2" ]; then
        APP_NAME="$2"
        shift 2
      else
        echo "Error: --app requires an argument."
        usage
      fi
      ;;
    *)
      echo "Invalid option: $1"
      usage
      ;;
  esac
done

# Execute playbooks based on chosen action
if [[ "$ACTION" == "install-docker" || "$ACTION" == "all" ]]; then
  echo "Running Docker installation playbook..."
  ansible-playbook "$INSTALL_PLAYBOOK"
fi

if [[ "$ACTION" == "deploy" || "$ACTION" == "all" ]]; then
  echo "Running Docker Compose apps deployment playbook..."
  if [ -n "$APP_NAME" ]; then
    ansible-playbook "$DEPLOY_PLAYBOOK" -e "app_name=$APP_NAME"
  else
    ansible-playbook "$DEPLOY_PLAYBOOK"
  fi
fi
