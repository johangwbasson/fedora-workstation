#!/bin/bash
# Bootstrap script for Ansible provisioning
# Installs Ansible and required dependencies

set -e

echo "=== Fedora 42 KDE Machine Bootstrap ==="
echo "Installing Ansible and dependencies..."

# Update system
sudo dnf update -y

# Install Ansible, openssh-clients, and python development tools
sudo dnf install -y ansible openssh-clients python3-pip

# Install ansible-lint and other Ansible tools
pip install --user ansible-lint

# Install Ansible collections
ansible-galaxy collection install -r requirements.yml

echo "=== Bootstrap complete ==="
echo "To verify playbook syntax, run: ansible-lint"
echo "To provision the machine, run: ./run.sh"
