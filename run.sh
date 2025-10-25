#!/bin/bash
# Run script for Ansible provisioning
# Executes the main playbook

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Running Fedora 42 KDE Provisioning Playbook ==="

# Check if .vars.yml exists
if [ ! -f "$SCRIPT_DIR/.vars.yml" ]; then
    echo "ERROR: .vars.yml file not found!"
    echo ""
    echo "Creating .vars.yml from .vars_example.yml..."
    cp "$SCRIPT_DIR/.vars_example.yml" "$SCRIPT_DIR/.vars.yml"
    echo ""
    echo "⚠️  Please configure the following variables in .vars.yml:"
    echo "   - git_name: Your full name (for git config)"
    echo "   - git_email: Your email address (for git config)"
    echo "   - username: Your system username"
    echo ""
    echo "Once configured, run this script again."
    exit 1
fi

# Lint the playbook first
echo "Validating playbook syntax with ansible-lint..."
ansible-lint playbooks/main.yml || {
    echo "Error: ansible-lint validation failed"
    exit 1
}

# Check playbook syntax
echo "Checking playbook syntax..."
ansible-playbook -i inventory.ini playbooks/main.yml --syntax-check

# Run the playbook
echo "Executing provisioning playbook..."
ansible-playbook -i inventory.ini playbooks/main.yml -v --ask-become-pass

echo "=== Provisioning complete ==="
