throw 'Dont run with F5'

# Start with Presentation

ii 'C:\Users\mczerniawski\OneDrive\Prezentacje\PSUG_20191120\WEF_MateuszCzerniawski_PSUG.pptx'

#GitHub repo

Start-process 'https://github.com/mczerniawski/WEFTools'

# Prepare GPO as a starting point for GPO policies
code 'C:\Repos\Private-GIT\WEFTools\docs\GPO_prepare.md'

# Prepare Azure Log Analytics workspace
code 'C:\Repos\Private-GIT\WEFTools\docs\Deploy-AzureLog-Workspace.md'

# Deploy Windows Event Forwarding in automated way
code 'C:\Repos\Private-GIT\WEFTools\docs\Deploy.md'

# Deploy Tools on WEC server 
code 'C:\Repos\Private-GIT\WEFTools\docs\DeployWEF.md'

#Switch to RemoteLab
    # Show the Lab
    # Show WEC Events, schedule task and Log Folder
    # Run demorun.ps1
    # Show definition
code 'C:\Repos\Private-GIT\WEFTools\WEFTools\Configuration\Definitions\OSCrash.json'

# Azure Log Analytics and basic KQL
code 'C:\Repos\Private-GIT\psconf\Palantir\ALQuery.md'

Start-process 'https://portal.azure.com/#@arcon.net.pl/resource/subscriptions/5c5be126-0e1c-4fc6-b68c-d14fc89c3f6d/resourceGroups/RG-LogAnalytics/providers/Microsoft.OperationalInsights/workspaces/LA-CustomLogs/logs'

#Azure Monitor sample
Start-Process 'https://portal.azure.com/#blade/Microsoft_Azure_Monitoring/AzureMonitoringBrowseBlade/alertsV2'

## and Teams notification:
Start-Process 'https://teams.microsoft.com/_#/conversations/WEC%20Alerts?threadId=19:afe6fc99f48245ba8eb4e18680b5985c@thread.skype&ctx=channel'

# Azure Dashboard sample
Start-Process 'https://portal.azure.com/#@arcon.net.pl/dashboard/private/82caa346-4355-4ea7-8181-52af152103cb'

# PowerBI Dashboard and how to replace subscriptionID
ii 'C:\Users\mczerniawski\OneDrive\Prezentacje\PSUG_20191120\WEF_MateuszCzerniawski_PSUG.pptx'

#Cost and billing
Start-Process 'https://portal.azure.com/#blade/Microsoft_Azure_CostManagement/Menu/costanalysis'
