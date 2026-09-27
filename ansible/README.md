# Ansible playbook

## Prerequisites

Requirements: `Python` and [`Ansible`](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

### Install with apt

On Ubuntu, use the Ansible PPA for a recent version:

```sh
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

On Debian, the distribution package is fine:

```sh
sudo apt install ansible
```

The `prepare-debian.sh` script will run the right steps for either. On Debian, your user needs to be in the `sudo` group (`usermod -aG sudo <user>` as root) for the playbook to run.

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
- `vars/debian.yml` (Debian, Ubuntu and derivatives): system packages installed with apt, and CLI tools installed from their latest GitHub release into `~/.local/opt` and linked into `~/.local/bin`

Items can have a list of `tags`, and are then only installed when one of those tags is requested. Items without `tags` are always installed. Any tag name works, so you can make your own groups:

```yaml
apt_packages:
  - name: git
  - name: nmap
    tags: [optional]
```

Include `all` when passing tags, otherwise only tasks tagged with the given tags run:

```sh
./run.sh --tags all,optional
```

Programming languages are managed by mise (`~/.config/mise/config.toml`). They are only installed when the `mise_tools` tag is requested, otherwise run `mise install` manually later. mise itself is an optional package, so it needs to be installed first (or in the same run):

```sh
./run.sh --tags all,optional,mise_tools
```
