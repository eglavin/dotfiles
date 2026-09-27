# Script to generate a list of `winget` install commands for a given list of packages
#

param (
  [switch]$InstallAll,
  [switch]$Update
)

#region Lists

$redistributes = @{
  Label = "Redistributes"
  List  = @(
    @{ Id = "Microsoft.DirectX" },
    @{ Id = "Microsoft.VCRedist.2005.x86" },
    @{ Id = "Microsoft.VCRedist.2005.x64" },
    @{ Id = "Microsoft.VCRedist.2008.x86" },
    @{ Id = "Microsoft.VCRedist.2008.x64" },
    @{ Id = "Microsoft.VCRedist.2013.x86" },
    @{ Id = "Microsoft.VCRedist.2013.x64" },
    @{ Id = "Microsoft.VCRedist.2015+.x86" },
    @{ Id = "Microsoft.VCRedist.2015+.x64" }
  )
}

$information = @{
  Label = "Information"
  List  = @(
    @{ Id = "ALCPU.CoreTemp" },
    @{ Id = "AntibodySoftware.WizTree" },
    @{ Id = "CPUID.CPU-Z" },
    @{ Id = "CPUID.HWMonitor" },
    @{ Id = "CrystalDewWorld.CrystalDiskInfo" },
    @{ Id = "CrystalDewWorld.CrystalDiskMark" },
    @{ Id = "NirSoft.BlueScreenView" },
    @{ Id = "TechPowerUp.GPU-Z" }
  )
}

$tools = @{
  Label = "Tools"
  List  = @(
    @{ Id = "Armin2208.WindowsAutoNightMode" },
    @{ Id = "Bitwarden.Bitwarden" },
    @{ Id = "Giorgiotani.Peazip" },
    @{ Id = "Malwarebytes.Malwarebytes" },
    @{ Id = "Notepad++.Notepad++" },
    @{},
    @{ Id = "Alacritty.Alacritty"; Tags = @('optional') },
    @{ Id = "AutoHotkey.AutoHotkey"; Tags = @('optional') },
    @{ Id = "Devolutions.RemoteDesktopManager"; Tags = @('optional') },
    @{ Id = "File-New-Project.EarTrumpet"; Tags = @('optional') },
    @{ Id = "Iterate.Cyberduck"; Tags = @('optional') },
    @{ Id = "Microsoft.Teams"; Tags = @('optional') },
    @{ Id = "Microsoft.PowerToys"; Tags = @('optional') },
    @{ Id = "Microsoft.VisualStudioCode"; Options = "--force --scope machine --override '/SILENT /SP- /MERGETASKS=`"!runcode,!desktopicon,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath`"'"; Tags = @('optional') },
    @{ Id = "Neovim.Neovim"; Tags = @('optional') },
    @{ Id = "NordVPN.NordVPN"; Tags = @('optional') },
    @{ Id = "SublimeHQ.SublimeText.4"; Tags = @('optional') },
    @{ Id = "WiresharkFoundation.Wireshark"; Tags = @('optional') }
  )
}

$cli = @{
  Label = "CLI"
  List  = @(
    @{ Id = "Microsoft.PowerShell" },
    @{ Id = "JanDeDobbeleer.OhMyPosh" },
    @{ Id = "Git.Git" },
    @{ Id = "dandavison.delta" },
    @{ Id = "BurntSushi.ripgrep.MSVC" },
    @{ Id = "junegunn.fzf" },
    @{ Id = "ajeetdsouza.zoxide" },
    @{ Id = "jdx.mise" },
    @{},
    @{ Id = "Gyan.FFmpeg"; Tags = @('optional') },
    @{ Id = "JesseDuffield.lazygit"; Tags = @('optional') },
    @{ Id = "jqlang.jq"; Tags = @('optional') },
    @{ Id = "MikeFarah.yq"; Tags = @('optional') },
    @{ Id = "Schniz.fnm"; Tags = @('optional') },
    @{ Id = "yt-dlp.yt-dlp"; Tags = @('optional') }
  )
}

$development = @{
  Label = "Development"
  List  = @(
    @{ Id = "Amazon.AWSCLI"; Tags = @('optional') },
    @{ Id = "DBBrowserForSQLite.DBBrowserForSQLite"; Tags = @('optional') },
    @{ Id = "Docker.DockerDesktop"; Tags = @('optional') },
    @{ Id = "Google.AndroidStudio"; Tags = @('optional') },
    @{ Id = "Microsoft.AzureCLI"; Tags = @('optional') },
    @{ Id = "Microsoft.AzureFunctionsCoreTools"; Tags = @('optional') },
    @{ Id = "Microsoft.AzureStorageExplorer"; Tags = @('optional') },
    @{ Id = "Microsoft.SQLServerManagementStudio"; Tags = @('optional') },
    @{ Id = "MongoDB.DatabaseTools"; Tags = @('optional') },
    @{ Id = "NVAccess.NVDA"; Tags = @('optional') },
    @{ Id = "Postman.Postman"; Tags = @('optional') },
    @{ Id = "RedHat.Podman"; Tags = @('optional') }
  )
}

$browsers = @{
  Label = "Browsers"
  List  = @(
    @{ Id = "Mozilla.Firefox" },
    @{},
    @{ Id = "Google.Chrome.Dev"; Tags = @('optional') },
    @{ Id = "Google.Chrome"; Tags = @('optional') },
    @{ Id = "Microsoft.Edge.Dev"; Tags = @('optional') },
    @{ Id = "Mozilla.Firefox.DeveloperEdition"; Tags = @('optional') },
    @{ Id = "Zen-Team.Zen-Browser"; Tags = @('optional') }
  )
}

$productivity = @{
  Label = "Productivity"
  List  = @(
    @{ Id = "Audacity.Audacity"; Tags = @('optional') },
    @{ Id = "BlenderFoundation.Blender"; Tags = @('optional') },
    @{ Id = "NickeManarin.ScreenToGif"; Tags = @('optional') },
    @{ Id = "Notion.Notion"; Tags = @('optional') },
    @{ Id = "OBSProject.OBSStudio"; Tags = @('optional') },
    @{ Id = "TheDocumentFoundation.LibreOffice"; Tags = @('optional') },
    @{ Id = "XnSoft.XnViewMP"; Tags = @('optional') },
    @{ Name = "Affinity Designer 2"; Tags = @('optional') },
    @{ Name = "Affinity Photo 2"; Tags = @('optional') },
    @{ Name = "Affinity Publisher 2"; Tags = @('optional') }
  )
}

$entertainment = @{
  Label = "Entertainment"
  List  = @(
    @{ Id = "VideoLAN.VLC" },
    @{},
    @{ Id = "DOSBox.DOSBox"; Tags = @('optional') },
    @{ Id = "Plex.Plex"; Tags = @('optional') },
    @{ Id = "Sky.SkyGo"; Tags = @('optional') },
    @{ Id = "Spotify.Spotify"; Tags = @('optional') },
    @{ Id = "Valve.Steam"; Tags = @('optional') }
  )
}

$allLists = @(
  $redistributes,
  $information,
  $tools,
  $cli,
  $development,
  $browsers,
  $productivity,
  $entertainment
)

#endregion

# Create dynamic array to hold output. See: https://stackoverflow.com/a/33156229
$ListContent = New-Object System.Collections.Generic.List[System.Object]
$Priority1Items = New-Object System.Collections.Generic.List[System.Object]

ForEach ($list in $allLists) {
  Write-Host "Processing $($list.Label):"

  $ListContent.Add(@"

### $($list.Label)

``````ps1
"@)

  ForEach ($group in $list.List) {
    # If app id and name are empty, add a blank line
    if ($null -eq $group.Id -and $null -eq $group.Name) {
      $ListContent.Add("")
      continue
    }

    if ($Update) {
      Write-Host "  $($group.Id ? $group.Id : $group.Name)"

      $InstallScript = "winget install "
      if ($null -ne $group.Id) {
        $InstallScript += "--id=$($group.Id)"
      }
      elseif ($null -ne $group.Name) {
        $InstallScript += "--name=`"$($group.Name)`""
      }

      if ($null -ne $group.Options) {
        $InstallScript += " $($group.Options)"
      }

      $ListContent.Add($InstallScript + ";")

      if ($group.Priority -eq 1) {
        $Priority1Items.Add($group.Id)
      }
    }

    if ($InstallAll) {
      Write-Host "  Installing: $($group.Id ? $group.Id : $group.Name)"

      if ($group.Id) {
        winget install --id=$($group.Id) $($group.Options);
      }
      else {
        winget install --name=$($group.Name) $($group.Options);
      }
    }
  }

  $ListContent.Add(@"
``````
"@)
}


if ($Update) {
  # Create a script to install the most used apps
  $MostUsedInstallScript = @"
`$ItemsToInstall = @(
  $($Priority1Items | ForEach-Object { "`"$_`"" } | Join-String -Separator ",`n  ")
)

`$ItemsToInstall | ForEach-Object {
  Write-Host "Installing: `$_"
  winget install --id=`$_
}
"@

  [System.IO.File]::WriteAllLines("$PSScriptRoot\install-most-used.ps1", $MostUsedInstallScript)


  # Update the README.md file
  $AppsMarker = "<!-- APPS LIST MARKER -->"

  $OldContent = [System.IO.File]::ReadAllText("$PSScriptRoot\README.md")
  $OldContentIndex = $OldContent.IndexOf($AppsMarker) + $AppsMarker.Length + 1

  $NewContent = $OldContent.Substring(0, $OldContentIndex)
  $NewContent += ($ListContent | Join-String -Separator "`n") + "`n"

  [System.IO.File]::WriteAllText("$PSScriptRoot\README.md", $NewContent)
}
