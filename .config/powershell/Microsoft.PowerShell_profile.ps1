# Initialisation

$PROFILE_DIR = Split-Path -parent $PROFILE;
$env:POSH_GIT_ENABLED = $true

Set-Alias g git -Option AllScope
Set-PSReadLineOption -HistoryNoDuplicates -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView

if (Get-Module -ListAvailable -Name Posh-Git) {
  Import-Module -Name Posh-Git
}
if (Get-Command -Name oh-my-posh -ErrorAction SilentlyContinue) {
  oh-my-posh init pwsh --config "$PROFILE_DIR/hotstick.minimal.omp.json" | Invoke-Expression
}

# Include my aliases
. "$PROFILE_DIR/aliases.ps1"

# Check for a local profile
if (Test-Path -Path "$PROFILE_DIR\Microsoft.PowerShell_profile.local.ps1" -PathType Leaf) {
  . "$PROFILE_DIR\Microsoft.PowerShell_profile.local.ps1"
}
