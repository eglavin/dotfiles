param (
  [switch] $Run
)

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
  Write-Warning "You need to run this script as an Administrator"
  exit
}

# Get the current timestamp now so all backup files have the same timestamp
$BackupTimestamp = [System.Math]::Truncate((Get-Date -Date ((Get-Date).ToUniversalTime()) -UFormat %s))

function ConfirmAction {
  param (
    [string] $Title
  )

  $Choices = '&Yes', '&No'

  $Decision = $Host.UI.PromptForChoice($Title, "", $Choices, 1)
  return $Decision -eq 0
}

function CreateLink {
  param (
    [string] $Type, # SymbolicLink or Junction
    [string] $Path,
    [string] $Target
  )

  if (Test-Path $Path) {
    $PathIsLink = [bool]((Get-Item $Path -Force -ea SilentlyContinue).Attributes -band [IO.FileAttributes]::ReparsePoint)
    if ($PathIsLink -eq $false) {
      if (ConfirmAction -Title "Would you like to backup $($Path)?") {
        $BackupPath = "$Path.$BackupTimestamp.bak"

        Write-Host "Moving file $Path -> $BackupPath"

        if ($Run) {
          Move-Item -Path $Path -Destination $BackupPath
          New-Item -Path $Path -Target $Target -ItemType $Type
        }
      }
      else {
        Write-Host "Skipping $Path"
      }
    }
    else {
      Write-Host "Link already exists $Path"
    }
  }
  else {
    Write-Host "Creating symlink $Path -> $Target"

    if ($Run) {
      New-Item -Path $Path -Target $Target -ItemType $Type
    }
  }

  Write-Host ""
}

$SystemLinks = @(
  # Windows Terminal
  @{
    Type   = "SymbolicLink";
    Path   = "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json";
    Target = "$HOME\dotfiles\windows-terminal\settings.json";
  }

  # Powershell
  @{
    Type   = "Junction";
    Path   = "$HOME\Documents\PowerShell";
    Target = "$HOME\dotfiles\.config\powershell";
  },

  # Vim + Neovim
  @{
    Type   = "SymbolicLink";
    Path   = "$HOME\.vimrc";
    Target = "$HOME\dotfiles\.vimrc";
  },
  @{
    Type   = "Junction";
    Path   = "$HOME\.vim";
    Target = "$HOME\dotfiles\.vim";
  },
  @{
    Type   = "Junction";
    Path   = "$HOME\AppData\Local\nvim";
    Target = "$HOME\dotfiles\.config\nvim";
  },

  # Git
  @{
    Type   = "SymbolicLink";
    Path   = "$HOME\.gitconfig";
    Target = "$HOME\dotfiles\.gitconfig";
  },
  @{
    Type   = "SymbolicLink";
    Path   = "$HOME\.gitignore_global";
    Target = "$HOME\dotfiles\.gitignore_global";
  }
);

foreach ($SystemLink in $SystemLinks) {
  CreateLink `
    -Type $SystemLink.Type `
    -Path $SystemLink.Path `
    -Target $SystemLink.Target
}
