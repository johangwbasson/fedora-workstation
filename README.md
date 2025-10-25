# Fedora 42 KDE Provisioning Playbook

Ansible playbook to provision a Fedora 42 KDE machine with base system configuration and repository setup.

## Project Structure

```
.
├── bootstrap.sh              # Install Ansible prerequisites
├── run.sh                    # Execute the provisioning playbook
├── inventory.ini             # Ansible inventory configuration
├── requirements.yml          # Ansible collection dependencies
├── .ansible-lint             # Ansible-lint configuration
├── playbooks/
│   └── main.yml              # Main provisioning playbook
└── roles/
    └── base/                 # Base role for system configuration
        ├── tasks/main.yml    # Role tasks
        ├── handlers/main.yml # Role handlers
        ├── defaults/main.yml # Role default variables
        ├── templates/        # Jinja2 templates
        ├── files/            # Static files
        └── vars/             # Role variables
```

## Guiding Principles

Based on CLAUDE.md best practices:

- **Idempotent**: All roles are designed to be safely run multiple times
- **Single Responsibility**: Each role has a focused, well-defined purpose
- **Self-contained**: Extra files and configurations are kept within the role
- **Linted**: Playbooks are validated with ansible-lint before execution

## Prerequisites

- Fedora 42 system
- sudo access
- Internet connectivity

## Quick Start

### 1. Bootstrap the Environment

Install Ansible and required dependencies:

```bash
./bootstrap.sh
```

This will:
- Update the system
- Install Ansible and essential tools
- Install ansible-lint for validation
- Download required Ansible collections

### 2. Run the Provisioning Playbook

Execute the main provisioning playbook:

```bash
./run.sh
```

This will:
- Validate the playbook with ansible-lint
- Check syntax with ansible-playbook
- Execute the full provisioning playbook

## Available Roles

### base

Installs and configures base system components:

- RPM Fusion Free repository
- RPM Fusion Nonfree repository
- DNF fastest mirror configuration

**Tags**: `base`

Run only the base role:

```bash
ansible-playbook -i inventory.ini playbooks/main.yml -t base -v
```

## Manual Commands

### Validate Playbook Syntax

```bash
ansible-lint playbooks/main.yml
ansible-playbook -i inventory.ini playbooks/main.yml --syntax-check
```

### Run with Specific Tags

```bash
ansible-playbook -i inventory.ini playbooks/main.yml -t base -v
```

### Run with Specific Verbosity

```bash
# Show variable debugging information
ansible-playbook -i inventory.ini playbooks/main.yml -vv

# Show very detailed debugging information
ansible-playbook -i inventory.ini playbooks/main.yml -vvv
```

### Check Mode (Dry Run)

See what would change without making changes:

```bash
ansible-playbook -i inventory.ini playbooks/main.yml --check
```

## Configuration

### Inventory

Edit `inventory.ini` to configure:
- Target hosts
- Connection methods
- User credentials

### Collections

Manage Ansible collections in `requirements.yml`. Install with:

```bash
ansible-galaxy collection install -r requirements.yml
```

### Ansible Lint Rules

Customize linting rules in `.ansible-lint`. See [ansible-lint documentation](https://ansible.readthedocs.io/projects/lint/) for available rules.

## Troubleshooting

### Permission Denied

Ensure you have sudo access. The playbook requires elevated privileges.

### Connection Issues

Verify `ansible_connection` and `ansible_user` settings in `inventory.ini`.

### Role Not Found

Run bootstrap to ensure collections are installed:

```bash
./bootstrap.sh
```

## Adding New Roles

To add a new role:

1. Create role structure:
   ```bash
   ansible-galaxy role init roles/new_role_name
   ```

2. Add tasks to `roles/new_role_name/tasks/main.yml`

3. Include in `playbooks/main.yml`:
   ```yaml
   roles:
     - role: new_role_name
       tags:
         - new_role_name
   ```

4. Run ansible-lint to validate:
   ```bash
   ansible-lint playbooks/main.yml
   ```

## Resources

- [Ansible Documentation](https://docs.ansible.com/)
- [Ansible Best Practices](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html)
- [ansible-lint Documentation](https://ansible.readthedocs.io/projects/lint/)
- [Fedora Documentation](https://docs.fedoraproject.org/)

## License

This playbook is provided as-is for Fedora 42 KDE provisioning.
