param (
  [switch] $Run
)

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
  Write-Warning "You need to run this script as an Administrator"
  exit
}

# Get the current timestamp now so all backup files have the same timestamp
$BackupTimestamp = [System.Math]::Truncate((Get-Date -Date ((Get-Date).ToUniversalTime()) -UFormat %s))

if (-not $Run) {
  Write-Host "Running in dry-run mode. Use the -Run flag to make changes." -ForegroundColor Yellow
  Write-Host ""
}

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
    [string] $Directory = "", # Directory to create if it doesn't exist
    [string] $Path,
    [string] $Target
  )

  if ("" -ne $Directory -and (-not (Test-Path $Directory))) {
    Write-Host "Creating directory $Directory"

    if ($Run) {
      New-Item -Path $Directory -ItemType Directory
    }
  }


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
    Type   = "Junction";
    Path   = "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState";
    Target = "$HOME\dotfiles\windows\terminal";
  }

  # Alacritty
  @{
    Type   = "Junction";
    Path   = "$env:AppData\alacritty";
    Target = "$HOME\dotfiles\.config\alacritty";
  },

  # Powershell
  @{
    Type   = "Junction";
    Path   = "$HOME\Documents\PowerShell";
    Target = "$HOME\dotfiles\.config\powershell";
  },

  # Vim + Neovim
  @{
    Type   = "Junction";
    Path   = "$HOME\.vim";
    Target = "$HOME\dotfiles\.vim";
  },
  @{
    Type   = "Junction";
    Path   = "$env:LocalAppData\nvim";
    Target = "$HOME\dotfiles\.config\nvim";
  },

  # mise
  @{
    Type   = "Junction";
    Path   = "$HOME\.config\mise";
    Target = "$HOME\dotfiles\.config\mise";
  },

  # Git
  @{
    Type   = "SymbolicLink";
    Path   = "$HOME\.gitconfig";
    Target = "$HOME\dotfiles\.gitconfig";
  },

  # yt-dlp
  @{
    Type      = "SymbolicLink";
    Directory = "$env:AppData\yt-dlp";
    Path      = "$env:AppData\yt-dlp\config";
    Target    = "$HOME\dotfiles\.config\yt-dlp\config";
  }
);

foreach ($SystemLink in $SystemLinks) {
  CreateLink `
    -Type $SystemLink.Type `
    -Directory $SystemLink.Directory `
    -Path $SystemLink.Path `
    -Target $SystemLink.Target
}
