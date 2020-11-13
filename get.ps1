# Simple cli metric getter for Windows powershell
# edit C:\Program Files\zabbix\zabbix_agent2.conf
# UserParameter=get[*],powershell.exe -NoProfile -File C:\Program Files\zabbix\get.ps1 $1
# restart-service "Zabbix Agent 2"

$function=$Args[0]

if(-not($function)) {
  write-host "Usage: <metric function to execute>"
  write-host "Example: battery-status"
  exit
}


function return1() {
  # simple test return function
  echo 1
}


function battery-count() {
  $count = @(Get-CimInstance -ClassName Win32_Battery).Count
  "Installed batteries: $count"
}


function hasBattery(){
  # test for battery:
  $hasBattery = @(Get-CimInstance -ClassName Win32_Battery).Count -gt 0
  "Has battery: $hasBattery"
}


function get_battery_charge(){
  $charge = Get-CimInstance -ClassName Win32_Battery | Select-Object -ExpandProperty EstimatedChargeRemaining
  "Current Charge: $charge %."
}


function get_battery_charge_mult(){
  # get battery charge for one or more batteries:
  $charge = Get-CimInstance -ClassName Win32_Battery | Measure-Object -Property EstimatedChargeRemaining -Average | Select-Object -ExpandProperty Average
  "Current Charge: $charge %."
}


function get_battery_runtime(){
  $runtime = Get-CimInstance -ClassName Win32_Battery | Measure-Object -Property EstimatedRunTime -Average | Select-Object -ExpandProperty Average

  if ($runtime -eq 71582788) {
    # this specific value indicates AC power:
    'AC Power'
  }else{
    # return runtime in hours:
    'Estimated Runtime: {0:n1} hours.' -f ($runtime/60)
  }
}


function battery-status() {
  $BatteryStatus = @{
    Name = 'BatteryStatusText'
    Expression = {
      $value = $_.BatteryStatus

      switch([int]$value)
      {
        1          {'Battery Power'}
        2          {'AC Power'}
        3          {'Fully Charged'}
        4          {'Low'}
        5          {'Critical'}
        6          {'Charging'}
        7          {'Charging and High'}
        8          {'Charging and Low'}
        9          {'Charging and Critical'}
        10         {'Undefined'}
        11         {'Partially Charged'}
        default    {"$value"}
      }
    }
  }

  Get-CimInstance -ClassName Win32_Battery | Select-Object -Property DeviceID, BatteryStatus, $BatteryStatus

}


function main() {
  if ($function -eq "battery-status"){
    (battery-status)."BatteryStatus"
  }elseif ($function -eq "return1"){
    return1
  }else{
    write-host "E: Metric function $function is not supported!"
    battery-count
  }
}


main
