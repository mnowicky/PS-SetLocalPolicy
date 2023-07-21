#Use either of the following, for HKLM and HKCU respectively.
#$MachineDir = "$env:windir\system32\GroupPolicy\Machine\registry.pol"
#$UserDir = "$env:windir\system32\GroupPolicy\User\registry.pol"
#RegPath starts after HKLM or HKCU in reg.

write-host("Setting local group policy via registry change")
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
