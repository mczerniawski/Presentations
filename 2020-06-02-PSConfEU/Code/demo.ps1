throw 'Dont run with F5'

# Start with Presentation

Invoke-Item 'C:\Users\mczerniawski\OneDrive\Prezentacje\PSConfEU\2020\AL\CZERNIAWSKI_CaptainKusto.pptx'

#GitHub repo

Start-Process msedge.exe 'https://github.com/mczerniawski/ALTools'

# Next Steps
code 'C:\Users\mczerniawski\OneDrive\Prezentacje\PSConfEU\2020\AL\1. Create AL Workspace.md' 
code 'C:\Users\mczerniawski\OneDrive\Prezentacje\PSConfEU\2020\AL\2. Get-WorkspaceID-PrimaryKey.md'
code 'C:\Users\mczerniawski\OneDrive\Prezentacje\PSConfEU\2020\AL\3. SendLogs.ps1'
code 'C:\Users\mczerniawski\OneDrive\Prezentacje\PSConfEU\2020\AL\4. Get from Log Analytics.ps1'
code 'C:\Users\mczerniawski\OneDrive\Prezentacje\PSConfEU\2020\AL\5. SampleQueries.md'
code 'C:\Users\mczerniawski\OneDrive\Prezentacje\PSConfEU\2020\AL\6. Remove data from Log Analytics.md'


# Code
Import-Module ALTools
$Path = Get-Module -Name ALTools | Select-Object -ExpandProperty ModuleBase
code ('{0}\Public\Write-ToLogAnalytics.ps1' -f $Path)
code ('{0}\Private\Export-ObjectToLogAnalytics.ps1' -f $Path)
code ('{0}\Private\Get-LogAnalyticsSignature.ps1' -f $Path)

# Sample Dashboards
Invoke-Item 'C:\Repos\Private-GIT\pChecksAD\pChecksAD\bin\DashBoard\pChecksADDashboard.pbix'
Invoke-Item 'C:\Repos\Private-GIT\WEFTools\WEFTools\bin\Dashboard\WEFDashboard.pbix' 

# Create Azure Dashboard
Start-Process msedge.exe 'https://portal.azure.com/#@arcon.net.pl/resource/subscriptions/5c5be126-0e1c-4fc6-b68c-d14fc89c3f6d/resourceGroups/RG-LogAnalytics/providers/Microsoft.OperationalInsights/workspaces/LA-CustomLogs/Overview'
 # (View Designer)
# Create PowerBI