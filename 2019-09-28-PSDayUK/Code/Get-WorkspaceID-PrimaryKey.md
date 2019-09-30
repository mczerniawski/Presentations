# Get WorkspaceID and PrimarySharedKey

To get the WorkspaceID and PrimarySharedKey of existing resources in Azure use below code:

```powershell
#Connect to your Azure Account
Connect-AzureRmAccount

#Select subscription where Log Analytics workspace should be created
Get-AzureRmSubscription | Out-GridView -PassThru | Select-AzureRmSubscription

#select resource Group
$resourceGroupName = Get-AzureRmResourceGroup | Out-GridView -PassThru

#retrieve workspace ID
$workspace = Get-AzureRmResource -ResourceType 'Microsoft.OperationalInsights/workspaces' | Out-GridView -PassThru
$workspace = Get-AzureRmOperationalInsightsWorkspace -ResourceGroupName $resourceGroupName.ResourceGroupName | Out-GridView -PassThru

#retrieve PrimaryKey and WorkspaceID
$PrimarySharedKey = Get-AzureRmOperationalInsightsWorkspaceSharedKeys -ResourceGroupName $resourceGroupName.ResourceGroupName -Name $workspace.Name | Select-Object -ExpandProperty PrimarySharedKey
$WorkspaceID = Get-AzureRmOperationalInsightsWorkspace -ResourceGroupName $resourceGroupName.ResourceGroupName -Name $workspace.name | Select-Object -ExpandProperty CustomerId | Select-Object -ExpandProperty Guid

$WorkspaceData = @{
    PrimarySharedKey = $PrimarySharedKey
    ALWorkspaceID = $WorkspaceID
}
```

## Export to XML file

If needed Export data to XML file:

```powershell
$WorkspaceData = @{
    PrimarySharedKey = $PrimarySharedKey
    WorkspaceID = $WorkspaceID
}

$WorkspaceDataPath = 'c:\AdminTools\Workspace.dat'
$WorkspaceData | Export-CLIXml -path $WorkspaceDataPath
```

## Import from XML file

Import later if needed

```powershell
$WorkspaceDataPath = 'c:\AdminTools\Workspace.dat'
$WorkspaceData =Import-CLIXml -path $WorkspaceDataPath
```
