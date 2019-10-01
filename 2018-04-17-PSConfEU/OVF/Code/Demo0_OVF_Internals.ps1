throw 'Dont run with F5'

#region show folder layout
code C:\Repos\GIT\PPoShOVF
code C:\Repos\GIT\PPoShOVFDiagnostics
#endregion


$RootFolder = 'C:\AdminTools\Tests\OVF'

#region Show Baseline
Invoke-Item "$RootFolder\Configuration\AD"
code "$RootFolder\Configuration"

#endregion

#region Show GenerateConfig
psedit C:\Repos\GIT\PPoShOVFDiagnostics\PPoShOVFDiagnostics\Public\Baseline\AD\Get-POVFConfigurationAD.ps1
psedit C:\Repos\GIT\PPoShOVFDiagnostics\PPoShOVFDiagnostics\Public\Baseline\DHCP\New-POVFBaselineDHCP.ps1
psedit C:\Repos\GIT\PPoShOVFDiagnostics\PPoShOVFDiagnostics\Public\Baseline\S2D\New-POVFBaselineS2DCluster.ps1
#endregion


#region AD Tests
psedit C:\Repos\GIT\PPoShOVFDiagnostics\PPoShOVFDiagnostics\Diagnostics\AD\Simple\AD.Simple.Operational.Tests.ps1
psedit C:\Repos\GIT\PPoShOVFDiagnostics\PPoShOVFDiagnostics\Diagnostics\AD\Simple\AD.Simple.Configuration.Tests.ps1
#endregion

#region DHCP Tests
psedit C:\Repos\GIT\PPoShOVFDiagnostics\PPoShOVFDiagnostics\Diagnostics\DHCP\Simple\DHCP.Simple.General.Operational.Tests.ps1
psedit C:\Repos\GIT\PPoShOVFDiagnostics\PPoShOVFDiagnostics\Diagnostics\DHCP\Simple\DHCP.Simple.Node.Operational.Tests.ps1
psedit C:\Repos\GIT\PPoShOVFDiagnostics\PPoShOVFDiagnostics\Diagnostics\DHCP\Comprehensive\DHCP.Comprehensive.Node.Configuration.Tests.ps1
psedit C:\Repos\GIT\PPoShOVFDiagnostics\PPoShOVFDiagnostics\Diagnostics\DHCP\Comprehensive\DHCP.Comprehensive.Node.Reservations.Operational.Tests.ps1
#endregion

#region S2D Tests
psedit C:\Repos\GIT\PPoShOVFDiagnostics\PPoShOVFDiagnostics\Diagnostics\S2D\Simple\S2D.Simple.Cluster.Operational.Tests.ps1
psedit C:\Repos\GIT\PPoShOVFDiagnostics\PPoShOVFDiagnostics\Diagnostics\S2D\Comprehensive\S2D.Comprehensive.Nodes.Configuration.Tests.ps1
#endregion

###### BACK TO PRESENTATION ###############

