#In this example, local OS info is examined, and local group policies applied based on OS.
#Local policy is modified via registry modification. 
#HKLM machine based policies are stored here: "$env:windir\system32\GroupPolicy\Machine\registry.pol"
#HKCU user based policies are stored here: $UserDir = "$env:windir\system32\GroupPolicy\User\registry.pol"
# In this example, 2 policies are modified via registry items RpcOverTCP and RpcOverNamedPipes. 

$osInfo = Get-CimInstance Win32_OperatingSystem | Select-Object Caption, Version, OSArchitecture, CSName
write-host("Detected OS Version: " + $osInfo.Caption)
if($osInfo.Caption -eq "Microsoft Windows 11 Pro"){
	write-host("Setting local policy fix for Win11 network printing")
	$MachineDir = "$env:windir\system32\GroupPolicy\Machine\registry.pol"
	$RegPath = 'Software\Policies\Microsoft\Windows NT\Printers\RPC'
	$RegName1 = 'RpcOverTCP'
	$RegName2 = 'RpcOverNamedPipes'
	$RegData1 = '0'
	$RegData2 = '1'
	$RegType = 'DWord'
	
	Set-PolicyFileEntry -Path $MachineDir -Key $RegPath -ValueName $RegName1 -Data $RegData1 -Type $RegType
	Set-PolicyFileEntry -Path $MachineDir -Key $RegPath -ValueName $RegName2 -Data $RegData2 -Type $RegType
	write-host("Local RPC print policies set, done.")
}
