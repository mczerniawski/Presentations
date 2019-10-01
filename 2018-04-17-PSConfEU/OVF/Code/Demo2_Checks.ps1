throw 'Dont run with F5'

#region Import Modules
Import-Module -Name C:\Repos\Git\PPoShTools\PPoShTools -Force
Import-Module -Name C:\Repos\git\PPoShOVF\PPoShOVF -Force
Import-Module -Name C:\Repos\GIT\PPoShOVFDiagnostics\PPoShOVFDiagnostics -Force
#endregion

#region Credentials
  
  #$DemoCredentials =Get-Credential -Message 'POVF Demo'
  #$DemoCredentials | Export-Clixml -Path C:\AdminTools\POVFDemo.Pass 

$DemoCredentials = Import-Clixml -Path C:\AdminTools\Tests\OVF\POVFDemo.Pass 
#endregion

$RootFolder = 'C:\AdminTools\Tests\OVF'
$ConfigurationFolder = Join-Path -Path $RootFolder -ChildPath 'Configuration'
$OutputFolder = Join-Path -Path $RootFolder -ChildPath 'Output'

#region AD
$paramsAD = @{
  ServiceConfiguration = "$ConfigurationFolder\AD"
  POVFServiceName = 'AD'
  Show = 'All'
  Credential = $DemoCredentials
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
  OutputFolder = "$OutputFolder\DHCP"
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
  OutputFolder = "$OutputFolder\S2D"
}
Invoke-POVFDiagnostics @paramsS2D

$ReportFolder = Join-Path -Path $RootFolder -ChildPath 'Report'
Invoke-POVFReportUnit -InputFolder $paramsAD.OutputFolder -OutputFolder "$ReportFolder\AD"
Invoke-POVFReportUnit -InputFolder $paramsDHCP.OutputFolder -OutputFolder "$ReportFolder\DHCP"
Invoke-POVFReportUnit -InputFolder $paramsS2D.OutputFolder -OutputFolder "$ReportFolder\S2D"
Invoke-Item -Path "$ReportFolder\S2D\Index.html"
#show html report
#endregion

#region
Invoke-Item -Path "$RootFolder\Demo\Demo2.mp4"
Invoke-Item -Path "$ReportFolder\AD\Index.html"
Invoke-Item -Path "$ReportFolder\DHCP\Index.html"
Invoke-Item -Path "$ReportFolder\S2D\Index.html"
#endregion


###### GOTO DEMO3