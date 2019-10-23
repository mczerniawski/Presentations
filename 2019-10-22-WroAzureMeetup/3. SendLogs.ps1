#region Simple

$invocationStartTime = [DateTime]::UtcNow
$object = Get-Process
$invocationEndTime = [DateTime]::UtcNow


$writeToLogAnalyticsSplat = @{
    ALWorkspaceID       = 'c7e.......ccd85e0a4'
    invocationStartTime = $invocationStartTime
    PSObject            = $object
    ALTableIdentifier   = 'AzureMeetup' #Your name for Azure Logs
    invocationEndTime   = $invocationEndTime
    WorkspacePrimaryKey = 'eNsD1mOYeTTY8........oAKlOPeWpEixCa7bOoYmh2wHMqYUA=='
}

Write-ToLogAnalytics @writeToLogAnalyticsSplat -Verbose
#endregion

#region VM Inventory

#region function
function Get-VMInventory {
    <#
    .SYNOPSIS
    Retrieves detailed information about VMs from Hyper-V host or cluster
    
    .DESCRIPTION
    Retrieves information about a VM, it's disk, path, current resources and network properties.
    Will query Hyper-V host or all nodes in a cluster if [$Cluster] is provided. Accepts [$Credential] parameter.
    
    .PARAMETER ComputerName
    Hyper-V host or cluster name
    
    .PARAMETER Cluster
    Set to true if cluster is to be queried
    
    .PARAMETER Credential
    Optional Credential parameter
    
    .EXAMPLE
    Get-VMInventory -ComputerName 'HVHost1' | Format-Table -AutoSize
    Name          ComputerName DynamicMemoryEnabled MemoryMinimum MemoryMaximum MemoryAssigned MemoryStatus ProcessorCount DisksCount DiskCurrentSize
    ----          ------------ -------------------- ------------- ------------- -------------- ------------ -------------- ---------- --------------
    Mgmt          HVHost1                   False           0,5          1024              0                           4          1          23,99
    Router-VyOS   HVHost1                   False          0,25          1024              0                           1          1            0,5
    S1_DC1        HVHost1                    True             1             2              0                           2          1          25,06
    S1_DC2        HVHost1                    True           0,5             2              0                           2          1           29,1
    WEC           HVHost1                   False           0,5          1024              0                           6          2          49,08
    .EXAMPLE
    Get-VMInventory -Computer 'HVCluster1' -Cluster -Credential (Get-Credential) | Format-Table -AutoSize
    Name          ComputerName DynamicMemoryEnabled MemoryMinimum MemoryMaximum MemoryAssigned MemoryStatus ProcessorCount DisksCount DiskCurrentSize 
    ----          ------------ -------------------- ------------- ------------- -------------- ------------ -------------- ---------- ---------------
    HVNode3-VyOS  HVNode3                   False           0,5          1024              1                           1          1            0,91
    OT-PLCON0     HVNode1                   False           0,5          1024              2                           1          1           29,91
    OT-PLDHCP0    HVNode2                   False           0,5          1024              2                           1          1           19,94
    OT-PLPDC0     HVNode4                   False           0,5          1024              2                           1          1           21,04
    OT-PLSDC0     HVNode5                   False           0,5          1024              2                           1          1           23,88
 
    .NOTES
    #>
    
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
        Invoke-Command @connProperties -ScriptBlock {
            $SelectObjectFilter = @(
                @{name = 'IPAddress'; e = { $PSItem.IPAddresses -notmatch ':' } },
                @{name = 'SwitchName'; e = { $PSItem.SwitchName } },
                @{name = 'MacAddress'; e = { $Psitem.MacAddress } }
            )
            Get-VM | ForEach-Object {
                Write-Verbose "ProcesiFng VM {$($PSItem.VMName)}"
                Write-Verbose "Getting VM {$($PSItem.VMName)} disk information"
                $disks = Get-VHD -VMId $PSItem.VMId -ComputerName $PSItem.ComputerName
                $diskCount = $disks | Measure-Object |
                Select-Object -ExpandProperty Count
                $diskCurrentSize = $disks | Measure-Object -Sum -Property FileSize |
                Select-Object -ExpandProperty Sum
                $diskMaximumSize = $disks | Measure-Object -Sum -Property Size |
                Select-Object -ExpandProperty Sum
                Write-Verbose "Getting VM {$($PSItem.VMName)} network information"
                $NetworkAdapters = @( Get-VMNetworkAdapter $PSItem |
                    Select-Object $SelectObjectFilter)
                [pscustomobject]@{
                    Name                       = $PSItem.Name
                    ComputerName               = $PSItem.ComputerName
                    DynamicMemoryEnabled       = $PSItem.DynamicMemoryEnabled
                    MemoryMinimum              = [System.Math]::Round($PSItem.MemoryMinimum / 1GB, 2)
                    MemoryMaximum              = [System.Math]::Round($PSItem.MemoryMaximum / 1GB, 2)
                    MemoryAssigned             = [System.Math]::Round($PSItem.MemoryAssigned / 1GB, 2)
                    MemoryStatus               = $PSItem.MemoryStatus
                    ProcessorCount             = $PSItem.ProcessorCount
                    DisksCount                 = $diskCount
                    DiskCurrentSize            = [System.Math]::Round($diskCurrentSize / 1GB, 2)
                    DiskMaximumSize            = [System.Math]::Round($diskMaximumSize / 1GB, 2)
                    State                      = $PSitem.State
                    Uptime                     = $PSItem.Uptime
                    Version                    = $PSItem.Version
                    CreationTime               = $PSItem.CreationTime
                    Path                       = $PSItem.Path
                    AutomaticStartAction       = $PSItem.AutomaticStartAction
                    AutomaticStartDelay        = $PSItem.AutomaticStartDelay
                    AutomaticStopAction        = $PSItem.AutomaticStopAction
                    IntegrationServicesState   = $PSItem.IntegrationServicesState
                    IntegrationServicesVersion = $PSitem.IntegrationServicesVersion
                    NetworkAdapters            = $NetworkAdapters
                }
            }
        }
    }
}
#endregion

$invocationStartTime = [DateTime]::UtcNow
$object = Get-VMInventory
$invocationEndTime = [DateTime]::UtcNow

$writeToLogAnalyticsSplat = @{
    ALWorkspaceID       = 'c7eae39...........d85e0a4'
    invocationStartTime = $invocationStartTime
    PSObject            = $object
    ALTableIdentifier   = 'AzureMeetup' #Your name for Azure Logs
    invocationEndTime   = $invocationEndTime
    WorkspacePrimaryKey = 'eNsD1mOYeTTY8MP7JtE.........xCa7bOoYmh2wHMqYUA=='
}

Write-ToLogAnalytics @writeToLogAnalyticsSplat -Verbose
#endregion
