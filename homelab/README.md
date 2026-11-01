# Homelab updates

Ansible playbook to apt upgrade every machine on the network from one place. The `ansible` folder is for setting up the machine it runs on; this one manages the other machines over SSH.

## Hosts

Defined in `inventory.ini`, copy the example and add your own hosts:

```sh
cp inventory.ini.example inventory.ini
```

Hosts go in one of two groups:

- `ubuntu`: Ubuntu machines and VMs
- `proxmox`: Proxmox hosts (Debian based)

The Ubuntu hosts are updated one at a time, then the Proxmox hosts last. The Ubuntu hosts are rebooted automatically when needed; set `auto_reboot=false` on a host in the inventory to only report it instead. Proxmox hosts are never rebooted automatically since it would take the VMs down with it, the playbook only reports when it needs one.

The Proxmox host needs the `pve-no-subscription` repository enabled (and the enterprise one disabled) if there's no subscription, otherwise the apt update fails with a 401.

## Prerequisites

Run from WSL (or any Linux/macOS machine) with Ansible installed.

## Automation account

The playbook connects to every host as an `ansible` account, created by `bootstrap.sh`:

- Logs in with SSH keys only, one per control machine (`~/.ssh/ansible_homelab`, created on that machine's first run)
- Its password is locked, so it can't be logged into with a password over SSH, on the console, or with `su`
- Has passwordless sudo, so updates can run unattended

Each key is effectively root on every host, so never copy one between machines. A passphrase protects it if the machine is compromised, but means unattended runs need the key loaded into an agent first.

Run the bootstrap once on each control machine, from WSL's own filesystem or `/mnt/c`. It logs in with your own account on each host (`bootstrap_user` in the inventory) and asks for its sudo password:

```sh
./bootstrap.sh
```

If your accounts have different sudo passwords, run it per group of hosts with `--limit`, e.g. `./bootstrap.sh --limit pi-1,pi-2`. If WSL doesn't have an SSH key for your own accounts, add `--ask-pass` to log in with your password instead (needs `sshpass` installed).

The last task logs in as `ansible` and runs `sudo -n true`, so a successful run means the account works. Rerunning it is safe.

### Multiple control machines

`inventory.ini` is gitignored, so copy it to each control machine yourself. Then run `./bootstrap.sh` on each one: it adds that machine's key to the hosts and leaves the other machines' keys in place.

Each key's comment names the machine it was made on (`ansible@<hostname>`), which is how it's revoked. To remove a machine's access, e.g. a lost laptop, run this from any other control machine:

```sh
./bootstrap.sh -e revoke=old-laptop       # or several: -e revoke=old-laptop,old-desktop
```

It refuses to revoke the machine it's running on. To see which machines have access to a host: `sudo cat /home/ansible/.ssh/authorized_keys`.

Only schedule runs from one control machine. Two runs at the same time fight over the apt lock and one fails.

Once it works on every host, consider turning off SSH password login for all accounts, by adding `PasswordAuthentication no` to a file in `/etc/ssh/sshd_config.d/` and reloading sshd.

To remove the account from a host: `sudo userdel -r ansible && sudo rm /etc/sudoers.d/ansible`.

## Usage

```sh
ansible all -i inventory.ini -m ping  # check every host is reachable
./run.sh --check                     # dry run
./run.sh                             # update everything
./run.sh --limit webserver,pi-1      # update some hosts
```

If an Ubuntu 25.10+ host fails waiting for the sudo prompt, it's using sudo-rs, so add `ansible_become_exe=sudo.ws` to that host in the inventory.
