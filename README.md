# dotfiles

## Installation (Linux/Mac)

Requirements: `Git` and `Stow`

These requirements can be installed with apt by using this command: `sudo apt install git stow` or with brew using this command: `brew install git stow`.

These dotfiles expect to be stored in the `~/dotfiles` location. To download, install and activate, use the following commands:

```sh
git clone https://github.com/eglavin/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow .
```

### Local Zsh Overrides

Creating the following file in the following location will allow you to source your own additions to the profile: `~/.zshrc.local`

## Installation (Windows)

Requirements: `Git` and `Powershell 7+`

The `create-symlinks.ps1` file in the scripts folder will take care of linking supported files to the correct location. To download, install and activate, use the following commands:

```ps1
git clone https://github.com/eglavin/dotfiles.git ~/dotfiles
~/dotfiles/scripts/create-symlinks.ps1
```

Optional enhancements: `Oh-My-Posh` and `Posh-Git`. Which can be installed using the following commands:

```ps1
winget install --id=JanDeDobbeleer.OhMyPosh
Install-Module -Name "posh-git" -Scope CurrentUser -Force
```

Using oh-my-posh, we can use the following commands to setup some of the fonts used, which need to be installed from an administrator terminal:

```ps1
oh-my-posh font install FiraCode
oh-my-posh font install JetBrainsMono
oh-my-posh font install Meslo
```

### Local Powershell Overrides

Creating the following file in the following location will allow you to source your own additions to the profile: `~/.config/powershell/Microsoft.PowerShell_profile.local.ps1`

## References

- [Youtube - Stow has forever changed the way I manage my dotfiles (Dreams of Autonomy)](https://www.youtube.com/watch?v=y6XCebnB9gs)
- [WSL - Git Credential Manager Setup](https://learn.microsoft.com/en-us/windows/wsl/tutorials/wsl-git#git-credential-manager-setup)
