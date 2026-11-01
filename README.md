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

Creating the following file will allow you to source your own additions: `~/.zshrc.local`

## Installation (Windows)

Requirements: `Git` and `Powershell 7+`

These requirements can be installed with winget using this command: `winget install Git.Git Microsoft.PowerShell`.

The `create-symlinks.ps1` file in the windows folder will take care of linking supported files to the correct location. To download, install and activate, use the following commands from an elevated prompt:

```ps1
git clone https://github.com/eglavin/dotfiles.git ~/dotfiles
~/dotfiles/windows/create-symlinks.ps1 -Run
```

### Local Powershell Overrides

Creating the following file will allow you to source your own additions: `~/dotfiles/.config/powershell/Microsoft.PowerShell_profile.local.ps1`

## Optional fonts install with fontget

Requirements: [`fontget`](https://github.com/Graphixa/FontGet#installation)

```ps1
fontget add nerd.fira-code
fontget add nerd.jetbrains-mono
fontget add nerd.meslo-lg
```

## References

- [Youtube - Stow has forever changed the way I manage my dotfiles (Dreams of Autonomy)](https://www.youtube.com/watch?v=y6XCebnB9gs)
- [WSL - Git Credential Manager Setup](https://learn.microsoft.com/en-us/windows/wsl/tutorials/wsl-git#git-credential-manager-setup)
