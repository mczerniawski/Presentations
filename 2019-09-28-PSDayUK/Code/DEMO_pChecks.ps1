throw 'Dont run with F5'


# Start with Presentation

Invoke-Item 'C:\AdminTools\PSDayUK2019\Pester + Azure.pptx'

#GitHub repo

Start-Process msedge.exe 'https://github.com/mczerniawski/pChecksAD'

# Basic module layout
code 'C:\Repos\Private-GIT\pChecksAD\pChecksAD\Index\AD.Checks.Index.json'
code 'C:\Repos\Private-GIT\pChecksAD\pChecksAD\Public\Invoke-pChecksAD.ps1'
code 'C:\Repos\Private-GIT\pChecksAD\pChecksAD\Private\Baseline\Get-pChecksBaselineConfigurationAD.ps1'

# Show BaseLineAD
code 'C:\AdminTools\PSDayUK2019\BaselineAD\General\arcontest.pl.Configuration.json'
code 'C:\AdminTools\PSDayUK2019\BaselineAD\Nodes\ARC-S1DC1.ARCONTEST.PL.Configuration.json'

# Deploy pChecksAD 
code 'C:\AdminTools\PSDayUK2019\Deploy_pChecksAD.ps1'

# Prepare Azure Log Analytics workspace
code 'C:\AdminTools\PSDayUK2019\Deploy_Workspace.ps1'

#######  Switch to RemoteLab
# Show the Lab
# Run create-ad-baseline.ps1

code 'C:\AdminTools\PSDayUK2019\Sample_Run.ps1'

#Demo1 if remote connectivity failed
Invoke-Item 'C:\AdminTools\PSDayUK2019\PESTER_Demo1.mp4'

# Azure Log Analytics and basic KQL
code 'C:\AdminTools\PSDayUK2019\ALQuery.md'

Start-process msedge.exe 'https://portal.azure.com/#@arcon.net.pl/resource/subscriptions/5c5be126-0e1c-4fc6-b68c-d14fc89c3f6d/resourceGroups/RG-LogAnalytics/providers/Microsoft.OperationalInsights/workspaces/LA-CustomLogs/logs'

#Azure Monitor sample
Start-Process msedge.exe 'https://portal.azure.com/#blade/Microsoft_Azure_Monitoring/AzureMonitoringBrowseBlade/alertsV2'

<#
pChecksAD_CL
   | where Passed_b == 'False'
   | project Describe_s, Context_s ,
            Passed_bFalse = Passed_b ,
            TimeGeneratedFalse = TimeGenerated,
            Name_s , FailureMessage_s , Target_s
#>

## and Teams notification:
Start-Process 'https://teams.microsoft.com/_#/conversations/pChecksAD?threadId=19:e1ea7e7b905840f3b5c93c8dd8744c43@thread.skype&ctx=channel'

# Azure Dashboard sample
Start-Process 'https://portal.azure.com/#@arcon.net.pl/dashboard/private/82caa346-4355-4ea7-8181-52af152103cb'


#Cost and billing
Start-Process msedge.exe 'https://portal.azure.com/#@arcon.net.pl/resource/subscriptions/5c5be126-0e1c-4fc6-b68c-d14fc89c3f6d/overview'

# PowerBI Dashboard and how to replace subscriptionID
Invoke-Item 'C:\AdminTools\PSDayUK2019\pChecksADDashboard.pbix'

#Demo2 if Azure connectivity failed
Invoke-Item 'C:\AdminTools\PSDayUK2019\PESTER_Demo2.mp4'


#Back to Slides
Invoke-Item 'C:\AdminTools\PSDayUK2019\Pester + Azure.pptx'