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

psedit "$ConfigurationFolder\AD1\NonNodeData\objectivity.co.uk.Configuration.json"
#region AD
$paramsAD = @{
  ServiceConfiguration = "$ConfigurationFolder\AD1"
  POVFServiceName = 'AD'
  Show = 'All'
  Credential = $DemoCredentials
  Tag = 'Configuration'
  ReportFilePrefix = 'objectivity'
  OutputFolder = "$OutputFolder\AD1"
}

Invoke-POVFDiagnostics @paramsAD
#endregion

$ReportFolder = Join-Path -Path $RootFolder -ChildPath 'Report'
Invoke-POVFReportUnit -InputFolder $paramsAD.OutputFolder -OutputFolder "$ReportFolder\AD1"
Invoke-Item -Path "$RootFolder\Demo\Demo3.mp4"
Invoke-Item -Path "$ReportFolder\AD1\Index.html"



##########GOTO DEMO4