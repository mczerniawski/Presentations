throw 'Dont run with F5'
$RootFolder = 'C:\AdminTools\Tests\OVF'

#region EventLog
Invoke-Item -Path "$RootFolder\Demo\Demo4.mp4"

#endregion


#region ScheduleTask & OMS
code "$RootFolder\Demo\Scheduled\"

psedit "$RootFolder\Demo\Scheduled\InvokeOVFTests.ps1"
psedit "$RootFolder\Demo\Scheduled\GenerateReports.ps1"

psedit "$RootFolder\Demo\Scheduled\Logs\20180409_1200_OVFS2D.log"

Invoke-Item "$RootFolder\Demo\Scheduled\Report\S2D\index.html"



###### OMS
Invoke-Item -Path "$RootFolder\Demo\Demo5.mp4"

#endregion

####BACK to Presentation#####