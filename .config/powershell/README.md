# Powershell Profile

## Prerequisites

This powershell profile has been designed for Powershell 7+ and [Oh-My-Posh](https://ohmyposh.dev) which can be optionally installed using winget:

```ps1
winget install --id=Microsoft.PowerShell
winget install --id=JanDeDobbeleer.OhMyPosh
```

## Installation

Use the `dotfiles/scripts/install-win-symlink.ps1` script to link files and folders.

## Post-Install Powershell Modules (Optional)

The following Powershell Modules are also optional to install:

- [Posh-Git](https://github.com/dahlbyk/posh-git)

```ps1
Install-Module -Name "posh-git" -Scope CurrentUser -Force
```

## Fonts (Optional)

Setup terminal fonts using Oh-My-Posh in an administrator window.

Fonts to be installed:

- [FiraCode](https://github.com/tonsky/FiraCode)
- [Meslo](https://github.com/andreberg/Meslo-Font)

```ps1
oh-my-posh font install FiraCode
oh-my-posh font install Meslo
```

## Local Overrides

Creating the following file in this folder allows adding local overrides to this profile.

`Microsoft.PowerShell_profile.local.ps1`
