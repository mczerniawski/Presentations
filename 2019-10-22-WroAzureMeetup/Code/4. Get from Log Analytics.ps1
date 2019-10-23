
$creds = Get-Credential -UserName '07b2b360-b620-4efa-9eb2-f9e3dbda8616' -Message 'Provide Secret for AppID'
'/6Q6O39FNAqJ.......g[IkHAJr'
Login-AzureRmAccount -Credential $creds -ServicePrincipal -Tenant '6ab316a......7893bcfe'
$query = @"
pChecksAD_CL
| where TimeGenerated > ago(30d)
| summarize ChecksPassed = (count(Passed_b == 'True')),
         ChecksFailed = (count(Passed_b == 'False'))
         by Describe_s
| sort by ChecksFailed
"@
$queryResults = Invoke-AzureRmOperationalInsightsQuery -WorkspaceId 'c7eae.....85e0a4' -Query $query
$queryResults.Results

