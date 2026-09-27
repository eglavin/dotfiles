# Ansible playbook

## Prerequisites

Requirements: `Python` and [`Ansible`](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

### Install with apt

```sh
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

The `prepare-ubuntu.sh` script will run these steps for you.

### Install with brew

```sh
brew install ansible
```

## Usage

The `run.sh` script will install the required collections and run the playbook for you, stopping to prompt you for your sudo password.

Alternatively you can run it manually with the following commands:

```sh
ansible-galaxy collection install -r ./requirements.yml
ansible-playbook ./main.yml --ask-become-pass
```

## Packages

Package lists live in `vars/`:

- `vars/macos.yml`: installed with Homebrew
- `vars/ubuntu.yml`: system packages installed with apt, and CLI tools installed from their latest GitHub release into `~/.local/opt` and linked into `~/.local/bin`

Programming languages are managed by mise (`~/.config/mise/config.toml`).
