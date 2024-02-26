# dotfiles

## Installation

Requirements:

- Git
- Stow

Which can be installed with this command.

```sh
sudo apt install git stow
```

To download and install this dotfile use the following commands to clone the repo and activate stow.

```sh
git clone https://github.com/eglavin/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow .
```

### Usage on windows

The `install-win-symlink.ps1` file in the scripts folder will take care of linking the required files and folders.

```ps1
git clone https://github.com/eglavin/dotfiles.git ~/dotfiles
~/dotfiles/scripts/install-win-symlink.ps1
```

## References

[Youtube - Stow has forever changed the way I manage my dotfiles (Dreams of Autonomy)](https://www.youtube.com/watch?v=y6XCebnB9gs)
