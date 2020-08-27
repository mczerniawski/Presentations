#region Simple
$invocationStartTime = [DateTime]::UtcNow
$object = Get-Process
$invocationEndTime = [DateTime]::UtcNow

Import-Module ALTools -Force

$PSConfEUKeysPath = 'C:\AdminTools\PSConfEU\Keys.dat'
$PSConfKeys = Import-Clixml -Path $PSConfEUKeysPath

$writeToLogAnalyticsSplat = @{
    ALWorkspaceID       = $PSConfKeys.WorkspaceData.ALWorkspaceID
    invocationStartTime = $invocationStartTime
    PSObject            = $object
    ALTableIdentifier   = 'PSConf2020Demo' #Your name for Azure Logs
    invocationEndTime   = $invocationEndTime
    WorkspacePrimaryKey = $PSConfKeys.WorkspaceData.WorkspacePrimaryKey
}

Write-ToLogAnalytics @writeToLogAnalyticsSplat -Verbose

#endregion

#region VM Inventory

#region function
function Get-VMInventory {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true,
            ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [String[]]
        $ComputerName,
    
        [Parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName)]
        [switch]
        $Cluster,
    
        [Parameter(Mandatory = $false)]
        [System.Management.Automation.Credential()]
        $Credential = [System.Management.Automation.PSCredential]::Empty
    
    )
    
    begin {
        
        $connProperties = @{
            ComputerName = $ComputerName
        }
        if ($Credential) {
            $connProperties.Credential = $Credential
        }
        if ($Cluster) {
            $Nodes = Invoke-Command @connProperties -ScriptBlock {
                Get-ClusterNode | where-object { $PSItem.State -eq 'Up' } |
                select-object -ExpandProperty Name
            }
            $connProperties.ComputerName = $Nodes
        }
    }
    
    process {
        Invoke-Command @connProperties -ThrottleLimit 32 -ScriptBlock {
            Get-VM | ForEach-Object {
                Write-Verbose "Procesing VM {$($PSItem.VMName)}"
                Write-Verbose "    Getting VM {$($PSItem.VMName)} disk information"
                $disks = Get-VHD -VMId $PSItem.VMId -ComputerName $PSItem.ComputerName
                $diskCount = $disks | Measure-Object | Select-Object -ExpandProperty Count
                $diskCurrentSize = $disks | Measure-Object -Sum -Property FileSize | Select-Object -ExpandProperty Sum
                $diskMaximumSize = $disks | Measure-Object -Sum -Property Size | Select-Object -ExpandProperty Sum
                Write-Verbose "    Getting VM {$($PSItem.VMName)} network information"
                $NetworkAdapters = @()
                $NetworkAdapters = Get-VMNetworkAdapter -VMName $PSItem.VMName | ForEach-Object {
                     $NetAdapterProps = $PSitem
                     $VlanList = $PSItem | Get-VMNetworkAdapterVlan
                     [pscustomobject]@{
                         IPAddress = $NetAdapterProps | Select-Object -expandproperty IPAddresses | where-object {$PSitem -notmatch ':'}
                         SwitchName = $NetAdapterProps.SwitchName
                         MacAddress = $NetAdapterProps.MacAddress
                         AccessVlanId = $VlanList.AccessVlanId
                         NativeVlanId = $VlanList.NativeVlanId
                         VlanMode = $vlanlist.OperationMode
                     }
               
                }
                [pscustomobject]@{
                    Name                 = $PSItem.Name
                    ComputerName         = $PSItem.ComputerName
                    DynamicMemoryEnabled = $PSItem.DynamicMemoryEnabled
                    MemoryMinimum        = [System.Math]::Round($PSItem.MemoryMinimum / 1GB, 2)
                    MemoryMaximum        = [System.Math]::Round($PSItem.MemoryMaximum / 1GB, 2)
                    MemoryAssigned       = [System.Math]::Round($PSItem.MemoryAssigned / 1GB, 2)
                    MemoryStatus         = $PSItem.MemoryStatus
                    ProcessorCount       = $PSItem.ProcessorCount
                    DisksCount           = $diskCount
                    DiskCurrentSize      = [System.Math]::Round($diskCurrentSize / 1GB, 2)
                    DiskMaximumSize      = [System.Math]::Round($diskMaximumSize / 1GB, 2)
                    State                = $PSitem.State
                    Uptime               = $PSItem.Uptime
                    Version              = $PSItem.Version
                    CreationTime         = $PSItem.CreationTime
                    Path                 = $PSItem.Path
                    AutomaticStartAction = $PSItem.AutomaticStartAction
                    AutomaticStartDelay = $PSItem.AutomaticStartDelay
                    AutomaticStopAction = $PSItem.AutomaticStopAction
                    IntegrationServicesState= $PSItem.IntegrationServicesState
                    IntegrationServicesVersion= $PSitem.IntegrationServicesVersion
                    NetworkAdapters =  $NetworkAdapters 
        
                }
            }
        }
    }
}
#endregion


Import-Module ALTools -Force

$PSConfEUKeysPath = 'C:\AdminTools\PSConfEU\Keys.dat'
$PSConfKeys = Import-Clixml -Path $PSConfEUKeysPath

$Creds = Get-Credential 
$invocationStartTime = [DateTime]::UtcNow
$object = Get-VMInventory -ComputerName OBJPLTHV6 -Credential $Creds
$invocationEndTime = [DateTime]::UtcNow

$writeToLogAnalyticsSplat = @{
    ALWorkspaceID       = $PSConfKeys.WorkspaceData.ALWorkspaceID
    invocationStartTime = $invocationStartTime
    PSObject            = $object
    ALTableIdentifier   = 'VMInventory' #Your name for Azure Logs
    invocationEndTime   = $invocationEndTime
    WorkspacePrimaryKey = $PSConfKeys.WorkspaceData.WorkspacePrimaryKey
}

Write-ToLogAnalytics @writeToLogAnalyticsSplat -Verbose

#endregion
