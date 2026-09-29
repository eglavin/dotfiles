# Fresh Windows Install Scripts

## Usage

By default the run script will only install items without a tag:

```ps1
.\run.ps1
```

To include items with a tag you can include a `-Tags` argument while running:

```ps1
.\run.ps1 -Tags "optional","media"
```

## Tags
<!-- TAGS START MARKER -->

- `ai`
- `all`
- `mise`
- `neovim`
- `optional`
- `vscode`
- `work`

<!-- TAGS END MARKER -->

## Apps
<!-- APPS LIST MARKER -->

### Redistributes

```ps1
winget install --id=Microsoft.DirectX
winget install --id=Microsoft.VCRedist.2005.x86
winget install --id=Microsoft.VCRedist.2005.x64
winget install --id=Microsoft.VCRedist.2008.x86
winget install --id=Microsoft.VCRedist.2008.x64
winget install --id=Microsoft.VCRedist.2010.x86
winget install --id=Microsoft.VCRedist.2010.x64
winget install --id=Microsoft.VCRedist.2012.x86
winget install --id=Microsoft.VCRedist.2012.x64
winget install --id=Microsoft.VCRedist.2013.x86
winget install --id=Microsoft.VCRedist.2013.x64
winget install --id=Microsoft.VCRedist.2015+.x86
winget install --id=Microsoft.VCRedist.2015+.x64
```

### Information

```ps1
winget install --id=ALCPU.CoreTemp
winget install --id=AntibodySoftware.WizTree
winget install --id=CPUID.CPU-Z
winget install --id=CPUID.HWMonitor
winget install --id=CrystalDewWorld.CrystalDiskInfo
winget install --id=CrystalDewWorld.CrystalDiskMark
winget install --id=NirSoft.BlueScreenView
winget install --id=TechPowerUp.GPU-Z
```

### Tools and utilities

```ps1
winget install --id=Bitwarden.Bitwarden
winget install --id=Deskflow.Deskflow
winget install --id=Giorgiotani.Peazip
winget install --id=Iterate.Cyberduck
winget install --id=LocalSend.LocalSend
winget install --id=Malwarebytes.Malwarebytes
winget install --id=MHNexus.HxD
winget install --id=Microsoft.PowerToys
winget install --id=NirSoft.WakeMeOnLan
winget install --id=NordVPN.NordVPN
winget install --id=Tailscale.Tailscale
winget install --id=WiresharkFoundation.Wireshark
```

### Browsers

```ps1
winget install --id=Google.Chrome
winget install --id=Mozilla.Firefox
winget install --id=Mozilla.Firefox.DeveloperEdition
winget install --id=Zen-Team.Zen-Browser
```

### Text and IDE's

```ps1
winget install --id=Microsoft.VisualStudioCode --scope="machine" --override="/SILENT /SP- /MERGETASKS='!runcode,!desktopicon,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath'"
winget install --id=Neovim.Neovim
winget install --id=Notepad++.Notepad++
winget install --id=Obsidian.Obsidian
winget install --id=SublimeHQ.SublimeText.4
winget install --id=TheDocumentFoundation.LibreOffice
winget install --id=ZedIndustries.Zed
```

### Command line tools

```ps1
winget install --id=ajeetdsouza.zoxide
winget install --id=BurntSushi.ripgrep.MSVC
winget install --id=dandavison.delta
winget install --id=Git.Git
winget install --id=GitHub.cli
winget install --id=Gyan.FFmpeg
winget install --id=JanDeDobbeleer.OhMyPosh
winget install --id=jdx.mise
winget install --id=JesseDuffield.lazygit
winget install --id=jqlang.jq
winget install --id=junegunn.fzf
winget install --id=Microsoft.PowerShell
winget install --id=MikeFarah.yq
winget install --id=tree-sitter.tree-sitter-cli
winget install --id=yt-dlp.yt-dlp
```

### Development tools

```ps1
winget install --id=Amazon.AWSCLI
winget install --id=DBBrowserForSQLite.DBBrowserForSQLite
winget install --id=Docker.DockerDesktop
winget install --id=Google.AndroidStudio
winget install --id=Microsoft.AzureCLI
winget install --id=Microsoft.AzureFunctionsCoreTools
winget install --id=Microsoft.AzureStorageExplorer
winget install --id=Microsoft.SQLServerManagementStudio
winget install --id=MongoDB.DatabaseTools
winget install --id=NVAccess.NVDA
winget install --id=Postman.Postman
winget install --id=RedHat.Podman
winget install --id=TPGi.CCAe
```

### AI tools

```ps1
winget install --id=Anthropic.Claude
winget install --id=Anthropic.ClaudeCode
```

### Creative

```ps1
winget install --id=Audacity.Audacity
winget install --id=BlenderFoundation.Blender
winget install --id=NickeManarin.ScreenToGif
winget install --id=OBSProject.OBSStudio
winget install --name="Affinity Designer 2"
winget install --name="Affinity Photo 2"
winget install --name="Affinity Publisher 2"
```

### Entertainment

```ps1
winget install --id=DOSBox.DOSBox
winget install --id=Plex.Plex
winget install --id=Sky.SkyGo
winget install --id=Spotify.Spotify
winget install --id=Valve.Steam
winget install --id=VideoLAN.VLC
```

### Work

```ps1
winget install --id=Microsoft.Teams
```
