$PROFILE_DIR = Split-Path -parent $PROFILE;

Set-PSReadLineOption -HistoryNoDuplicates -PredictionSource HistoryAndPlugin

# Posh-Git
if (Test-Path -Path "$PROFILE_DIR\Modules\posh-git" -PathType Container) {
  $env:POSH_GIT_ENABLED = $true
  Import-Module -Name Posh-Git
}

# oh-my-posh
if (Get-Command -Name oh-my-posh -ErrorAction SilentlyContinue) {
  oh-my-posh init pwsh --config "$PROFILE_DIR\theme.omp.json" | Invoke-Expression
}

# Remove background color directories when listing files
$PSStyle.FileInfo.Directory = "`e[34m"

############################################
# Windows Specific Options

if ($IsWindows) {
  # chocolatey
  if (Test-Path -Path "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1" -PathType Leaf) {
    Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
  }
}

############################################

if (Test-Path -Path "$env:USERPROFILE\.local\bin" -PathType Container) {
  [System.Environment]::SetEnvironmentVariable(
    "Path",
    "$env:USERPROFILE\.local\bin;$env:Path",
    [System.EnvironmentVariableTarget]::Process
  )
}

if (Test-Path -Path "$PROFILE_DIR\Microsoft.PowerShell_profile.local.ps1" -PathType Leaf) {
  . "$PROFILE_DIR\Microsoft.PowerShell_profile.local.ps1"
}

. "$PROFILE_DIR\aliases.ps1"

############################################

# zoxide
if (Get-Command -Name zoxide -ErrorAction SilentlyContinue) {
  zoxide init powershell | Out-String | Invoke-Expression
}

# mise
if (Get-Command -Name mise -ErrorAction SilentlyContinue) {
  mise activate pwsh | Out-String | Invoke-Expression
}

############################################
