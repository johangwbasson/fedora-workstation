# Fedora 42 KDE Provisioning Playbook

Comprehensive Ansible playbook to provision a Fedora 42 KDE machine with complete system configuration, development tools, applications, and shell environments.

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

- **Idempotent**: All 30 roles are designed to be safely run multiple times without side effects
- **Single Responsibility**: Each role has a focused, well-defined purpose
- **Self-contained**: Extra files and configurations are kept within the role
- **Linted**: Playbooks are validated with ansible-lint before execution
- **Comprehensive**: Covers complete system provisioning from base configuration to development tools and applications
- **Error Handling**: Proper failed_when and changed_when conditions throughout all tasks
- **Guards**: Stat checks and when conditions prevent redundant operations

## Key Features

- **Multi-Source Package Management**: DNF, Flatpak, Yum Repository, Shell scripts
- **Conflict Resolution**: MEGASync via Flathub to avoid FFmpeg library conflicts
- **Shell Configuration**: Fish shell with NVM/Tide and Zsh with Oh My Zsh/Powerlevel10k
- **Development Tools**: Docker, Neovim, VS Code, LazyVim, LazyDocker, LazyGit
- **Security**: ClamAV antivirus, 1Password, Bitwarden, CleanBrowsing DNS
- **Desktop Applications**: Complete browser set, multimedia, office, and productivity tools
- **SSD Optimization**: Btrfs tuning for modern SSDs
- **System Hardening**: DNS filtering, antivirus scanning

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

The playbook includes **30 roles** organized into categories:

### System Configuration (6 roles)
- **base**: Core system setup (RPM Fusion repos, DNF config)
- **hostname**: Set system hostname
- **fonts**: Install system fonts (Fira Sans, JetBrains Mono)
- **btrfs_ssd**: Optimize Btrfs for SSD performance
- **clamav**: Install ClamAV antivirus with auto-update
- **cleanbrowsing_dns**: Configure CleanBrowsing DNS (Adult Filter)

### Development & CLI Tools (7 roles)
- **clitools**: Essential CLI tools (git, curl, wget, htop, fd-find, ripgrep, fzf, bat, etc.)
- **git**: Configure Git with user settings
- **docker**: Install Docker with user group access
- **lazydocker**: Docker TUI management tool
- **lazygit**: Git TUI management tool
- **lazyvim**: Neovim configuration with LazyVim starter
- **vscode**: Visual Studio Code editor

### Shell Environments (2 roles)
- **fish**: Fish shell with Oh My Fish, NVM plugin, Tide prompt
- **zsh**: Zsh shell with Oh My Zsh, Powerlevel10k, plugins

### Browsers (3 roles)
- **brave**: Brave browser
- **chrome**: Google Chrome browser
- **chromium**: Chromium browser

### GUI Applications (12 roles)
- **insomnia**: REST API client (via Flathub)
- **obsidian**: Markdown note-taking app (via Flathub)
- **slack**: Slack messaging client (via Flathub)
- **onlyoffice**: Office suite (via Flathub)
- **postman**: API testing tool (via Flathub)
- **spotify**: Spotify music client (via Flathub)
- **sublime_text**: Text editor
- **bitwarden**: Password manager (via Flathub)
- **megasync**: MEGA cloud storage (via Flathub)
- **onepassword**: Password manager
- **multimedia_codecs**: GStreamer, VLC, multimedia libraries

### System Services (1 role)
- **flatpak**: Flatpak runtime and Flathub repository

### Run Specific Roles

Run only tagged roles using the `-t` flag:

```bash
# Run single role
ansible-playbook -i inventory.ini playbooks/main.yml -t fish -v

# Run multiple roles
ansible-playbook -i inventory.ini playbooks/main.yml -t docker,vscode -v

# Run all roles
./run.sh
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
