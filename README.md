# ECM
Powershell scripts for file share analysis, automating content type creation and or search schema, and other such ECM tasks
wget -Uri https://github.com/AtrionIMandW/ECM/archive/master.zip -Outfile .\master.zip
$shell_app=new-object -com shell.application
$filename = "master.zip"
$zip_file = $shell_app.namespace((Get-Location).Path + "\$filename")
$destination = $shell_app.namespace((Get-Location).Path)
$destination.Copyhere($zip_file.items())
I"M BREAKING THIS!!~!!!!!
