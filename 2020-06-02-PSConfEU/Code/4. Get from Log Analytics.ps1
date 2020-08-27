$ApplicationCreds = Get-Credential -UserName 'a25c02db-439d-4267-8d2e-babae46d7ae8' -Message 'Provide Secret for AppID'

$PSConfKeys = Import-Clixml -Path $PSConfEUKeysPath
#$PSConfKeys | Add-Member -MemberType NoteProperty -Name 'ApplicationCreds' -Value $ApplicationCreds
#$PSConfKeys | Export-CLIXml -path $PSConfEUKeysPath

Login-AzureRmAccount -Credential $PSConfKeys.ApplicationCreds -ServicePrincipal -Tenant $PSConfKeys.TenantID


#region Sample 1
$query = @"
pChecksAD_CL
| where TimeGenerated > ago(30d)
| summarize ChecksPassed = (count(Passed_b == 'True')),
         ChecksFailed = (count(Passed_b == 'False'))
         by Describe_s
| sort by ChecksFailed
"@
$queryResults = Invoke-AzureRmOperationalInsightsQuery -WorkspaceId $PSConfKeys.WorkspaceData.ALWorkspaceID -Query $query
$queryResults.Results

$queryResults.Results | Get-Member

$queryResults.Results | where-object Describe_s -eq 'Verify [backup status] in forest {arcontest.pl}'

#endregion

#region Sample 2
$query = @"
let TimeG = 30d;
let Passed = (
pChecksAD_CL
| where TimeGenerated  > ago(TimeG) and Passed_b == 'True'
| project Describe_s, Context_s ,
          Passed_bTrue=Passed_b  ,
          TimeGeneratedPassed = TimeGenerated ,
          Name_s , FailureMessage_s , Target_s
);
let Failed = (
pChecksAD_CL
   | where TimeGenerated  > ago(TimeG) and Passed_b == 'False'
   | project Describe_s, Context_s ,
            Passed_bFalse = Passed_b ,
            TimeGeneratedFalse = TimeGenerated,
            Name_s , FailureMessage_s , Target_s
);
Passed | join kind=inner Failed on Name_s
| extend HowLongAgoH = ( now() - TimeGeneratedPassed )/ 1h,
         HowLongAgoD = ( now() - TimeGeneratedPassed )/ 1d
| project Describe_s, Context_s ,  Name_s , FailureMessage_s ,Passed_bTrue , Passed_bFalse,
          Target_s, TimeGeneratedPassed, TimeGeneratedFalse,
          ChecksTimeDifference = TimeGeneratedPassed - TimeGeneratedFalse,
          HowLongAgoH, HowLongAgoD
| sort by HowLongAgoH asc
"@
$queryResults = Invoke-AzureRmOperationalInsightsQuery -WorkspaceId $PSConfKeys.WorkspaceData.ALWorkspaceID -Query $query
$queryResults.Results

#endregion


#region Sample 3
$query = @"
VMInventory_CL
| where TimeGenerated > ago(15m)
"@
$queryResults = Invoke-AzureRmOperationalInsightsQuery -WorkspaceId $PSConfKeys.WorkspaceData.ALWorkspaceID -Query $query
$queryResults.Results

#endregion