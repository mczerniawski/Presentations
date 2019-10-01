throw 'Dont run with F5'

#region Import Modules
Import-Module -Name C:\Repos\Git\PPoShTools\PPoShTools -Force
Import-Module -Name C:\Repos\git\PPoShOVF\PPoShOVF -Force
Import-Module -Name C:\Repos\GIT\PPoShOVFDiagnostics\PPoShOVFDiagnostics -Force
#endregion

#region Credentials
  
  #$DemoCredentials =Get-Credential -Message 'POVF Demo'
  #$DemoCredentials | Export-Clixml -Path C:\AdminTools\POVFDemo.Pass 

$DemoCredentials = Import-Clixml -Path C:\AdminTools\POVFDemo.Pass 
#endregion

$ConfigurationFolder = 'C:\AdminTools\SODO_15032018\Configuration'
$OutputFolder = 'C:\AdminTools\SODO_15032018\Output'

#region AD
$paramsAD = @{
  ServiceConfiguration = "$ConfigurationFolder\AD"
  POVFServiceName = 'AD'
  Show = 'All'
  Credential = $DemoCredentials
  ReportFilePrefix = 'objectivity'
}

Invoke-POVFDiagnostics @paramsAD
#endregion

#region DHCP
$paramsDHCP = @{
  ServiceConfiguration = "$ConfigurationFolder\DHCP"
  POVFServiceName = 'DHCP'
  Show = 'All'
  Credential = $DemoCredentials
  ReportFilePrefix = 'objectivity'
  Tag = 'Reservation'
  #Node = 'OBJPLDHCP1'
  OutputFolder = "$OutputFolder\DHCP_20180315"
}
Invoke-POVFDiagnostics @paramsDHCP
Invoke-Item $paramsDHCP.OutputFolder
#endregion DHCP


#region S2D
$paramsS2D = @{
  ServiceConfiguration = "$ConfigurationFolder\S2D"
  POVFServiceName = 'S2D'
  Show = 'All'
  Credential = $DemoCredentials
  ReportFilePrefix = 'objectivity'
  #TestType = 'Comprehensive'
  #Tag = @('Operational')
  #NodeName = 'OBJPLWHV5'
  WriteToEventLog = $true
  EventSource = 'S2D'
  EventIDBase = 1000
  OutputFolder = "$OutputFolder\S2D_20180315"
}
Invoke-POVFDiagnostics @paramsS2D


Invoke-POVFReportUnit -InputFolder $paramsS2D.OutputFolder
Invoke-Item -Path "$($paramsS2D.OutputFolder)\Index.html"
#show html report
#endregion