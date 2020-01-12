throw 'Dont run with F5'

# Start with Presentation

Invoke-Item 'C:\Repos\Private-GIT\Presentations-Private\SoDo-20191205\SoDO_20191205.pptx'

#GitHub repo

Start-Process msedge.exe 'https://github.com/mczerniawski/ALTools'

# Next Steps
code 'C:\Repos\Private-GIT\Presentations-Private\SoDo-20191205\1. Create AL Workspace.md'
code 'C:\Repos\Private-GIT\Presentations-Private\SoDo-20191205\2. Get-WorkspaceID-PrimaryKey.md'
code 'C:\Repos\Private-GIT\Presentations-Private\SoDo-20191205\3. SendLogs.ps1'
code 'C:\Repos\Private-GIT\Presentations-Private\SoDo-20191205\4. Get from Log Analytics.ps1'
code 'C:\Repos\Private-GIT\Presentations-Private\SoDo-20191205\5. SampleQueries.md'

# Sample Dashboards
Invoke-Item 'C:\Repos\Private-GIT\pChecksAD\pChecksAD\bin\DashBoard\pChecksADDashboard.pbix'
Invoke-Item 'C:\Repos\Private-GIT\WEFTools\WEFTools\bin\Dashboard\WEFDashboard.pbix' 