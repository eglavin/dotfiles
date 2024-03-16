$PROFILE_DIR = Split-Path -parent $PROFILE;

# Include my aliases
. "$PROFILE_DIR/aliases.ps1"

# Defined PS ReadLine options
Set-PSReadLineOption -HistoryNoDuplicates -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView

# Set up Posh-Git
if (Get-Module -ListAvailable -Name Posh-Git) {
  $env:POSH_GIT_ENABLED = $true
  Import-Module -Name Posh-Git
}

# Set up Oh-My-Posh
if (Get-Command -Name oh-my-posh -ErrorAction SilentlyContinue) {
  oh-my-posh init pwsh --config "$PROFILE_DIR/hotstick.minimal.omp.json" | Invoke-Expression
}

# Check for a local profile
if (Test-Path -Path "$PROFILE_DIR/Microsoft.PowerShell_profile.local.ps1" -PathType Leaf) {
  . "$PROFILE_DIR/Microsoft.PowerShell_profile.local.ps1"
}

# Override the default directory colour
$PSStyle.FileInfo.Directory = "`e[34m"

# Import the Chocolatey Profile that contains the necessary code to enable tab-completions to function for `choco`.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
