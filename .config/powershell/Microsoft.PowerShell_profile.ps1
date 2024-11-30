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
  $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
  if (Test-Path -Path $ChocolateyProfile -PathType Leaf) {
    Import-Module "$ChocolateyProfile"
  }

  # winget
  if (Test-Path -Path "$PROFILE_DIR\Modules\Microsoft.WinGet.Client" -PathType Container) {
    Import-Module -Name Microsoft.WinGet.Client
  }
  Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
    [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
    $Local:word = $wordToComplete.Replace('"', '""')
    $Local:ast = $commandAst.ToString().Replace('"', '""')
    winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
      [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
  }
}

############################################

if (Test-Path -Path "$env:USERPROFILE\.local\bin" -PathType Container) {
  [System.Environment]::SetEnvironmentVariable(
    'Path',
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

# fnm
if (Get-Command -Name fnm -ErrorAction SilentlyContinue) {
  fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
  fnm completions --shell powershell | Out-String | Invoke-Expression
}

# pnpm
if (Test-Path -Path "$PROFILE_DIR\.pnpm-tab-completion.ps1" -PathType Leaf) {
  . "$PROFILE_DIR\.pnpm-tab-completion.ps1"
}

############################################
