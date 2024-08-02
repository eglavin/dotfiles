# dotfiles

## Installation (Linux/Mac)

Requirements: `Git` and `Stow`

These can be installed with apt by using this command: `sudo apt install git stow`, or with brew by using this command: `brew install git stow`.

These dotfiles expect to be stored in the `~/dotfiles` location. To download, install and activate use the following commands:

```sh
git clone https://github.com/eglavin/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow .
```

## Installation (Windows)

Requirements: `Git` `Powershell 7+`

The `create-symlinks.ps1` file in the scripts folder will take care of linking supported files to the correct location. To download, install and activate use the following commands:

```ps1
git clone https://github.com/eglavin/dotfiles.git ~/dotfiles
~/dotfiles/scripts/create-symlinks.ps1
```

## References

- [Youtube - Stow has forever changed the way I manage my dotfiles (Dreams of Autonomy)](https://www.youtube.com/watch?v=y6XCebnB9gs)
- [WSL - Git Credential Manager Setup](https://learn.microsoft.com/en-us/windows/wsl/tutorials/wsl-git#git-credential-manager-setup)
