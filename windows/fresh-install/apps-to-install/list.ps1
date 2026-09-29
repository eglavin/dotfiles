$listOfGroups = @(
  @{
    Label = 'Redistributes'
    Apps  = @(
      @{ Id = 'Microsoft.DirectX' },
      @{ Id = 'Microsoft.VCRedist.2005.x86' },
      @{ Id = 'Microsoft.VCRedist.2005.x64' },
      @{ Id = 'Microsoft.VCRedist.2008.x86' },
      @{ Id = 'Microsoft.VCRedist.2008.x64' },
      @{ Id = 'Microsoft.VCRedist.2010.x86' },
      @{ Id = 'Microsoft.VCRedist.2010.x64' },
      @{ Id = 'Microsoft.VCRedist.2012.x86' },
      @{ Id = 'Microsoft.VCRedist.2012.x64' },
      @{ Id = 'Microsoft.VCRedist.2013.x86' },
      @{ Id = 'Microsoft.VCRedist.2013.x64' },
      @{ Id = 'Microsoft.VCRedist.2015+.x86' },
      @{ Id = 'Microsoft.VCRedist.2015+.x64' }
    )
  },
  @{
    Label = 'Information'
    Apps  = @(
      @{ Id = 'ALCPU.CoreTemp' },
      @{ Id = 'AntibodySoftware.WizTree' },
      @{ Id = 'CPUID.CPU-Z' },
      @{ Id = 'CPUID.HWMonitor' },
      @{ Id = 'CrystalDewWorld.CrystalDiskInfo' },
      @{ Id = 'CrystalDewWorld.CrystalDiskMark' },
      @{ Id = 'NirSoft.BlueScreenView' },
      @{ Id = 'TechPowerUp.GPU-Z' }
    )
  },
  @{
    Label = 'Tools and utilities'
    Apps  = @(
      @{ Id = 'Bitwarden.Bitwarden' },
      @{ Id = 'Deskflow.Deskflow' },
      @{ Id = 'Giorgiotani.Peazip' },
      @{ Id = 'Iterate.Cyberduck'; Tags = @('all', 'optional') },
      @{ Id = 'LocalSend.LocalSend'; Tags = @('all', 'optional') },
      @{ Id = 'Malwarebytes.Malwarebytes' },
      @{ Id = 'MHNexus.HxD'; Tags = @('all') },
      @{ Id = 'Microsoft.PowerToys'; Tags = @('all', 'optional') },
      @{ Id = 'NirSoft.WakeMeOnLan'; Tags = @('all', 'optional') },
      @{ Id = 'NordVPN.NordVPN'; Tags = @('all') },
      @{ Id = 'Tailscale.Tailscale'; Tags = @('all', 'optional') },
      @{ Id = 'WiresharkFoundation.Wireshark'; Tags = @('all') }
    )
  },
  @{
    Label = 'Browsers'
    Apps  = @(
      @{ Id = 'Google.Chrome'; Tags = @('all', 'optional', 'work') },
      @{ Id = 'Mozilla.Firefox' },
      @{ Id = 'Mozilla.Firefox.DeveloperEdition'; Tags = @('all', 'optional', 'work') },
      @{ Id = 'Zen-Team.Zen-Browser'; Tags = @('all', 'optional') }
    )
  },
  @{
    Label = "Text and IDE's"
    Apps  = @(
      @{
        Id      = 'Microsoft.VisualStudioCode';
        Options = $(
          '--scope="machine"',
          "--override=`"/SILENT /SP- /MERGETASKS='!runcode,!desktopicon,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath'`""
        );
        Tags    = @('all', 'optional', 'work', "vscode")
      },
      @{ Id = 'Neovim.Neovim'; Tags = @('all', 'optional', 'neovim', 'work') },
      @{ Id = 'Notepad++.Notepad++' },
      @{ Id = 'Obsidian.Obsidian'; Tags = @('all', 'optional', 'work') },
      @{ Id = 'SublimeHQ.SublimeText.4'; Tags = @('all') },
      @{ Id = 'TheDocumentFoundation.LibreOffice'; Tags = @('all', 'work') }
      @{ Id = 'ZedIndustries.Zed'; Tags = @('all') }
    )
  },
  @{
    Label = 'Command line tools'
    Apps  = @(
      @{ Id = 'ajeetdsouza.zoxide' },
      @{ Id = 'BurntSushi.ripgrep.MSVC' },
      @{ Id = 'dandavison.delta' },
      @{ Id = 'Git.Git' },
      @{ Id = 'GitHub.cli'; Tags = @('all', 'optional') },
      @{ Id = 'Gyan.FFmpeg'; Tags = @('all') },
      @{ Id = 'JanDeDobbeleer.OhMyPosh' },
      @{ Id = 'jdx.mise'; Tags = @('all', 'optional', 'mise', 'work') },
      @{ Id = 'JesseDuffield.lazygit'; Tags = @('all', 'optional') },
      @{ Id = 'jqlang.jq'; Tags = @('all', 'optional') },
      @{ Id = 'junegunn.fzf' },
      @{ Id = 'Microsoft.PowerShell' },
      @{ Id = 'MikeFarah.yq'; Tags = @('all', 'optional') },
      @{ Id = 'tree-sitter.tree-sitter-cli'; Tags = @('all', 'optional', 'neovim', 'work') },
      @{ Id = 'yt-dlp.yt-dlp'; Tags = @('all') }
    )
  },
  @{
    Label = 'Development tools'
    Apps  = @(
      @{ Id = 'Amazon.AWSCLI'; Tags = @('all') },
      @{ Id = 'DBBrowserForSQLite.DBBrowserForSQLite'; Tags = @('all', 'optional', 'work') },
      @{ Id = 'Docker.DockerDesktop'; Tags = @('all') },
      @{ Id = 'Google.AndroidStudio'; Tags = @('all') },
      @{ Id = 'Microsoft.AzureCLI'; Tags = @('all', 'work') },
      @{ Id = 'Microsoft.AzureFunctionsCoreTools'; Tags = @('all', 'work') },
      @{ Id = 'Microsoft.AzureStorageExplorer'; Tags = @('all', 'work') },
      @{ Id = 'Microsoft.SQLServerManagementStudio'; Tags = @('all', 'work') },
      @{ Id = 'MongoDB.DatabaseTools'; Tags = @('all') },
      @{ Id = 'NVAccess.NVDA'; Tags = @('all', 'optional', 'work') },
      @{ Id = 'Postman.Postman'; Tags = @('all', 'work') },
      @{ Id = 'RedHat.Podman'; Tags = @('all', 'optional', 'work') },
      @{ Id = 'TPGi.CCAe'; Tags = @('all', 'optional', 'work') }
    )
  },
  @{
    Label = 'AI tools'
    Apps  = @(
      @{ Id = 'Anthropic.Claude'; Tags = @('all', 'ai') }
      @{ Id = 'Anthropic.ClaudeCode'; Tags = @('all', 'ai') }
    )
  },
  @{
    Label = 'Creative'
    Apps  = @(
      @{ Id = 'Audacity.Audacity'; Tags = @('all', 'optional') },
      @{ Id = 'BlenderFoundation.Blender'; Tags = @('all') },
      @{ Id = 'NickeManarin.ScreenToGif'; Tags = @('all', 'optional', 'work') },
      @{ Id = 'OBSProject.OBSStudio'; Tags = @('all', 'optional') },
      @{ Name = 'Affinity Designer 2'; Tags = @('all') },
      @{ Name = 'Affinity Photo 2'; Tags = @('all') },
      @{ Name = 'Affinity Publisher 2'; Tags = @('all') }
    )
  },
  @{
    Label = 'Entertainment'
    Apps  = @(
      @{ Id = 'DOSBox.DOSBox'; Tags = @('all') },
      @{ Id = 'Plex.Plex'; Tags = @('all') },
      @{ Id = 'Sky.SkyGo'; Tags = @('all') },
      @{ Id = 'Spotify.Spotify'; Tags = @('all') },
      @{ Id = 'Valve.Steam'; Tags = @('all') },
      @{ Id = 'VideoLAN.VLC' }
    )
  },
  @{
    Label = 'Work'
    Apps  = @(
      @{ Id = 'Microsoft.Teams'; Tags = @('all', 'work') }
    )
  }
)
