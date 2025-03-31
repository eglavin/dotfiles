$Path = "HKLM:HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor"
$Value = "$PSScriptRoot\auto-run.bat"

# Check if the registry key already exists
$ExistingValue = Get-ItemProperty -Path $Path -Name AutoRun -ErrorAction SilentlyContinue
if ($ExistingValue) {
	if ($ExistingValue.AutoRun -eq $Value) {
		Write-Host "AutoRun registry key already exists with the same value. No changes made."
		exit
	}

	# Prompt the user for confirmation to overwrite
	Write-Host "AutoRun registry key already exists.`nCurrent value: $($ExistingValue.AutoRun)"
	$ShouldOverwrite = Read-Host "Do you want to overwrite it? (Y/N)"
	if ($ShouldOverwrite.ToLower() -eq 'y') {
		Write-Host "Overwriting AutoRun registry key value..."
		Set-ItemProperty -Path $Path -Name AutoRun -Value $Value
	} else {
		Write-Host "Operation cancelled. No changes made."
		exit
	}
}
else {
	Write-Host "AutoRun registry key does not exist. Creating it..."
	New-ItemProperty -Path $Path -Name AutoRun -Value $Value -PropertyType String
}
