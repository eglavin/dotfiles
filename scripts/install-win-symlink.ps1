function CreateLink {
  param (
    [string]$ItemType = "SymbolicLink",
    [string]$Path,
    [string]$Target
  )

  if (Test-Path $Path) {
    Write-Host "Path already exists: $Path target: $Target"
  }
  else {
    Write-Host "Creating link: $Path for target: $Target"
    New-Item `
      -ItemType $ItemType `
      -Path $Path `
      -Target $Target
  }
}


# Setup Windows Terminal
$windowsTerminalProfileLocation = "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState";
# Test if terminal profile already exists, If it exists, backup the current profile.
if (Test-Path "$windowsTerminalProfileLocation\settings.json" -PathType Leaf) {
  $dateTime = Get-Date -Format 'yyyy_MM_ddTHH_mm_ss.fffffff'
  Move-Item `
    -Path "$windowsTerminalProfileLocation\settings.json" `
    -Destination "$windowsTerminalProfileLocation\settings.json.$dateTime.bak"
}
# Create a symbolic link to the settings.json file.
New-Item `
  -ItemType SymbolicLink `
  -Path "$windowsTerminalProfileLocation\settings.json" `
  -Target "$HOME\dotfiles\windows-terminal\settings.json"


# Setup Powershell Profile
CreateLink `
  -ItemType "Junction" `
  -Path "$HOME\Documents\PowerShell" `
  -Target "$HOME\dotfiles\.config\powershell"


# Setup Vim
CreateLink `
  -Path "$HOME\.vimrc" `
  -Target "$HOME\dotfiles\.vimrc"
CreateLink `
  -ItemType "Junction" `
  -Path "$HOME\.vim" `
  -Target "$HOME\dotfiles\.vim"


# Setup Neovim
CreateLink `
  -ItemType "Junction" `
  -Path "$HOME\AppData\Local\nvim" `
  -Target "$HOME\dotfiles\.config\nvim"


# Setup gitconfig
CreateLink `
  -Path "$HOME\.gitconfig" `
  -Target "$HOME\dotfiles\.gitconfig"
CreateLink `
  -Path "$HOME\.gitignore_global" `
  -Target "$HOME\dotfiles\.gitignore_global"
