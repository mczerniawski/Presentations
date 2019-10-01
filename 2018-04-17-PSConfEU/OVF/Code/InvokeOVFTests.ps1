$date = Get-Date -Format yyyyMMdd_HHmm
$ConfigurationFolder = 'C:\AdminTools\OVF'
$LogFolder = Join-Path -Path $ConfigurationFolder -ChildPath 'Logs'


#region Import Modules
Import-Module -Name PPoShTools -Force
Import-Module -Name PPoShOVF -Force
Import-Module -Name PPoShOVFDiagnostics -Force
Import-Module -Name Pester -Force
#endregion
#region Credentials
$OVFCredentials = Import-Clixml -Path 'C:\AdminTools\OVF\OVF.Pass'
#endregion



$ConfigurationFolder = 'C:\AdminTools\OVF\Configuration'
$OutputFolder = 'C:\AdminTools\OVF\Output'

#region AD
$paramsAD = @{
  ServiceConfiguration = "$ConfigurationFolder\AD"
  POVFServiceName = 'AD'
  Tag = @('Operational')
  Show = 'All'
  Credential = $OVFCredentials
  ReportFilePrefix = 'objectivity'
  WriteToEventLog = $true
  EventSource = 'OVFAD'
  EventIDBase = 1010
  OutputFolder = "$OutputFolder\AD"
}
$LogFile = Join-Path -Path $LogFolder -ChildPath ("{0}_OVFAD.log" -f $date)
Set-LogConfiguration -LogLevel Info -LogFile $LogFile 
Invoke-POVFDiagnostics @paramsAD
#endregion

#region DHCP
$paramsDHCP = @{
  ServiceConfiguration = "$ConfigurationFolder\DHCP"
  POVFServiceName = 'DHCP'
  Tag = @('Operational')
  Show = 'All'
  Credential = $OVFCredentials
  ReportFilePrefix = 'objectivity'
  WriteToEventLog = $true
  EventSource = 'OVFDHCP'
  EventIDBase = 1020
  OutputFolder = "$OutputFolder\DHCP"
}
$LogFile = Join-Path -Path $LogFolder -ChildPath ("{0}_OVFDHCP.log" -f $date)
Set-LogConfiguration -LogLevel Info -LogFile $LogFile 
Invoke-POVFDiagnostics @paramsDHCP

#endregion DHCP


#region S2D
$paramsS2D = @{
  ServiceConfiguration = "$ConfigurationFolder\S2D"
  POVFServiceName = 'S2D'
  Show = 'All'
  Tag = @('Operational')
  Credential = $OVFCredentials
  ReportFilePrefix = 'objectivity'
  WriteToEventLog = $true
  EventSource = 'OVFS2D'
  EventIDBase = 1030
  OutputFolder = "$OutputFolder\S2D"
}
$LogFile = Join-Path -Path $LogFolder -ChildPath ("{0}_OVFS2D.log" -f $date)
Set-LogConfiguration -LogLevel Info -LogFile $LogFile 
Invoke-POVFDiagnostics @paramsS2D
