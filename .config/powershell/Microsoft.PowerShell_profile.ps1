$PROFILE_DIR = Split-Path -parent $PROFILE;

. "$PROFILE_DIR/aliases.ps1"

if (Test-Path -Path "$PROFILE_DIR/Microsoft.PowerShell_profile.local.ps1" -PathType Leaf) {
  . "$PROFILE_DIR/Microsoft.PowerShell_profile.local.ps1"
}

############################################

Set-PSReadLineOption -HistoryNoDuplicates -PredictionSource HistoryAndPlugin

# Posh-Git
if (Get-Module -ListAvailable -Name Posh-Git) {
  $env:POSH_GIT_ENABLED = $true
  Import-Module -Name Posh-Git
}

# oh-my-posh
if (Get-Command -Name oh-my-posh -ErrorAction SilentlyContinue) {
  oh-my-posh init pwsh --config "$PROFILE_DIR/hotstick.minimal.omp.json" | Invoke-Expression
}

# Remove background color directories when listing files
$PSStyle.FileInfo.Directory = "`e[34m"

############################################

# chocolatey
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# zoxide
if (Get-Command -Name zoxide -ErrorAction SilentlyContinue) {
  Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

# fnm
if (Get-Command -Name fnm -ErrorAction SilentlyContinue) {
  fnm env | Out-String | Invoke-Expression
  fnm completions --shell=power-shell | Out-String | Invoke-Expression
}

# pnpm
if (Get-Command -Name pnpm -ErrorAction SilentlyContinue) {
  pnpm completion pwsh | Out-String | Invoke-Expression
}

############################################
