# Directory

function .. { Set-Location .. }
function cdl {
  param (
    [string]$dir
  )
  if ($dir) {
    Set-Location $dir
  }
  Get-ChildItem | Sort-Object Name | Format-Wide -AutoSize
}
# Remove built in windows powershell alias if exists
if (Get-Alias -Name ls -ErrorAction SilentlyContinue) {
  Remove-Item -force alias:ls
  function ls { Get-ChildItem $args | Sort-Object Name | Format-Wide -AutoSize }
}
function ll { Get-ChildItem $args | Sort-Object Name }
function l { Get-ChildItem -Force $args | Sort-Object Name }
function la { Get-ChildItem -Force $args | Sort-Object Name }
function lt { Get-ChildItem -Force $args | Sort-Object LastWriteTime -Descending }

function Get-FolderSize {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string]$Path
  )

  if (Test-Path $Path) {
    # Calculate total bytes by summing the length of all files recursively
    $totalBytes = (Get-ChildItem -Path $Path -Recurse -File -ErrorAction SilentlyContinue |
      Measure-Object -Property Length -Sum).Sum

    # If the folder is empty, $totalBytes will be null
    if ($null -eq $totalBytes) { $totalBytes = 0 }

    # Define the human-readable conversion logic
    $units = "B", "KB", "MB", "GB", "TB"
    $index = 0
    $size = $totalBytes

    while ($size -ge 1024 -and $index -lt $units.Length - 1) {
      $size /= 1024
      $index++
    }

    # Return a custom object for easy manipulation later
    return [PSCustomObject]@{
      Path       = $Path
      Size       = "{0:N2}" -f $size
      Unit       = $units[$index]
      Formatted  = ("{0:N2} {1}" -f $size, $units[$index])
      TotalBytes = $totalBytes
    }
  }
  else {
    Write-Warning "Path '$Path' does not exist."
  }
}

# Git

function gitwhoami {
  Write-Host "Name: $(git config --global user.name)"
  Write-Host "Email: $(git config --global user.email)"
}
function gitpb { git push -u origin (git branch --show) }
function gitor {
  $url = git config --get remote.origin.url
  if ($url -Match "@") {
    Start-Process "https://$($url.Split("@")[1])" # Fix for Azure Devops repos with config url like https://{org}@{url}
  }
  else {
    Start-Process $url
  }
}

# Editor

function UseNvimOrVim {
  if (Get-Command nvim -errorAction SilentlyContinue) {
    nvim $args
  }
  else {
    vim $args
  }
}
Set-Alias vi UseNvimOrVim -Option AllScope
Set-Alias vim UseNvimOrVim -Option AllScope

function c. {
  if ($args) {
    code $args
  }
  else {
    code .
  }
}
function ci. {
  if ($args) {
    code-insiders $args
  }
  else {
    code-insiders .
  }
}
function GetVisualStudioLocation {
  # Determining Installed Visual Studio Path for 2017 https://stackoverflow.com/a/54729540
  return Get-ItemPropertyValue `
    -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\devenv.exe" `
    -Name "(Default)";
}
function vs { Start-Process (GetVisualStudioLocation) . }
function vsp. {
  $sln = Get-ChildItem *.sln
  if (!$sln) {
    Write-Error "No solution file found"
  }
  else {
    Start-Process (GetVisualStudioLocation) $($sln)[0]
  }
}

# Shell

function e. {
  if ($args) {
    explorer $args
  }
  else {
    explorer .
  }
}
function ipme { Write-Host (Invoke-WebRequest ifconfig.me/ip).Content.Trim() }
function wt. {
  if ($args) {
    wt -d $args
  }
  else {
    wt -d .
  }
}
function pncp {
  pnpm run typecheck
  pnpm run lint:check
  pnpm run test run
}
Set-Alias pn pnpm -Option AllScope
Set-Alias g git -Option AllScope

function which {
  Get-Command -Name $args -ErrorAction SilentlyContinue |
  Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# Docker

function dce { docker exec -it $args bash }
function dclogs { docker compose logs -f }
function dcpull { docker compose pull }
function dcrestart {
  docker compose stop
  docker compose up -d
}
function dcrm { docker compose rm -f -s }
function dcstop { docker compose stop }
function dcup { docker compose up -d }
