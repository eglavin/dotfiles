$windowsTerminalProfileLocation = "$env:LocalAppData/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState";

# Test if terminal profile already exists, If it exists, backup the current profile.
if (Test-Path "$windowsTerminalProfileLocation/settings.json" -PathType Leaf) {
	$dateTime = Get-Date -Format 'yyyy_MM_ddTHH_mm_ss.fffffff'
	Move-Item "$windowsTerminalProfileLocation/settings.json" "$windowsTerminalProfileLocation/settings.json.$dateTime.bak"
}

# Create a symbolic link to the settings.json file.
New-Item `
	-ItemType SymbolicLink `
	-Path "$windowsTerminalProfileLocation/settings.json" `
	-Target "$HOME/dotfiles/windows-terminal/settings.json"
