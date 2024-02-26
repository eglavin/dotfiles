# Powershell Profile

## Prerequisites

This powershell profile has been designed for Powershell 7+ and [Oh-My-Posh](https://ohmyposh.dev) which can be optionally installed using winget:

```ps1
winget install --id=Microsoft.PowerShell
winget install --id=JanDeDobbeleer.OhMyPosh
```

## Installation

This dotfiles repo is expected to be installed to the home path for the user installing it.

The following command will create a junction sym linking it to the dotfiles location.

```ps1
$HOME_PATH = "$(Resolve-Path ~)"
New-Item `
  -ItemType Junction `
  -Path "$HOME_PATH\Documents\PowerShell\" `
  -Target "$HOME_PATH\dotfiles\.config\powershell\"
```

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
