param(
	[switch]$InstallServer
)

Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

if ($InstallServer) {
	Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
	Start-Service -Name sshd
	Set-Service -Name sshd -StartupType 'Automatic'

	Get-Service -Name sshd | Format-Table -Property Name, Status, StartType
}
