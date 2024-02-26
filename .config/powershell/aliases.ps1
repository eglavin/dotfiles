# Directory

# Remove built in powershell alias if exists
if (Get-Alias -Name ls -ErrorAction SilentlyContinue) {
  Remove-Item -force alias:ls
}

function .. { Set-Location .. }
function cdl ([string] $dir = '.') {
  Set-Location $dir
  Get-ChildItem | Format-Wide -AutoSize
}
function l { Get-ChildItem $args | Format-Wide -AutoSize }
function ls { Get-ChildItem $args | Format-Wide -AutoSize }
function la { Get-ChildItem -Force $args | Format-Wide -AutoSize }
function ll { Get-ChildItem -Force $args }
function lt { Get-ChildItem -Force $args | Sort-Object LastWriteTime -Descending }

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

function c. { code . }
function ci. { code-insiders . }
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

function e. { explorer . }
function ipme { Write-Host (Invoke-WebRequest ifconfig.me/ip).Content.Trim() }
function wt. { wt -d . }
Set-Alias pn pnpm -Option AllScope
Set-Alias g git -Option AllScope

# Docker

function dce { docker exec -it $args bash }
function dcl { docker-compose logs -f }
function dcp { docker-compose pull }
function dcr {
  docker-compose stop
  docker-compose up -d
}
function dcrm { docker-compose rm -f -s }
function dcs { docker-compose stop }
function dcup { docker-compose up -d }
