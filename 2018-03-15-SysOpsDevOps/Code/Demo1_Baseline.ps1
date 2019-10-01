throw 'Dont run with F5'

#region Import Modules
Import-Module -Name C:\Repos\Git\PPoShTools\PPoShTools -Force
Import-Module -Name C:\Repos\git\PPoShOVF\PPoShOVF -Force
Import-Module -Name C:\Repos\GIT\PPoShOVFDiagnostics\PPoShOVFDiagnostics -Force
#endregion
#region Credentials
  
  #$DemoCredentials =Get-Credential -Message 'POVF Demo'
  #$DemoCredentials | Export-Clixml -Path C:\AdminTools\Tests\OVF\POVFDemo.Pass 

$DemoCredentials = Import-Clixml -Path C:\AdminTools\Tests\OVF\POVFDemo.Pass 
#endregion

$RootFolder = 'C:\AdminTools\Tests\OVF'
$ConfigurationFolder = Join-Path -Path $RootFolder -ChildPath 'Configuration'
Invoke-Item $ConfigurationFolder
#region Baseline
$POVFBaselineAD = @{
 ComputerName = 'objplpdc1.objectivity.co.uk' 
 Credential = $DemoCredentials 
 POVFConfigurationFolder = "$ConfigurationFolder\AD"
}
New-POVFBaselineAD @POVFBaselineAD


$POVFBaselineDHCP = @{
 ComputerName = 'objpldhcp1.objectivity.co.uk' 
 Credential = $DemoCredentials 
 POVFConfigurationFolder = "$ConfigurationFolder\DHCP"
}
New-POVFBaselineDHCP @POVFBaselineDHCP


$POVFBaselineS2D = @{
 ClusterName = 'objplwhvcl0.objectivity.co.uk' 
 Credential = $DemoCredentials 
 POVFConfigurationFolder = "$ConfigurationFolder\S2D"
}
New-POVFBaselineS2DCluster @POVFBaselineS2D

#endregion

Invoke-Item -Path "$RootFolder\Demo\Demo1.mp4"
