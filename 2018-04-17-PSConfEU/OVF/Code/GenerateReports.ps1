$date = Get-Date -Format yyyyMMdd_HHmm
$ConfigurationFolder = 'C:\AdminTools\OVF'

$LogFolder = Join-Path -Path $ConfigurationFolder -ChildPath 'Logs'
$LogFile = Join-Path -Path $LogFolder -ChildPath ("{0}_Reports.log" -f $date)
Set-LogConfiguration -LogLevel Info -LogFile $LogFile 

$Tests = Get-ChildItem -Path (Join-Path -Path $ConfigurationFolder -ChildPath 'Output') -Directory | Select-Object -ExpandProperty FullName
foreach ($test in $Tests) {
    $outputFolder = Join-Path -Path "$ConfigurationFolder\Report" -ChildPath (Split-Path $test -Leaf)
    $null = New-Item $outputFolder -Force -ItemType Directory
    Invoke-POVFReportUnit -InputFolder $test -OutputFolder $outputFolder
}