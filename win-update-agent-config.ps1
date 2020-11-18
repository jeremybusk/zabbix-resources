$config_file="C:\Program Files\zabbix\zabbix_agent2.conf"
$newline='UserParameter=get[*],powershell.exe -NoProfile -File C:\Program Files\zabbix\get.ps1 $1'
(Get-Content $config_file) -replace '^.*UserParameter.*','' | ? {$_.trim() -ne "" } | Set-Content $config_file
Add-Content -Path $config_file -Value $newline
restart-service -name "Zabbix Agent 2"
