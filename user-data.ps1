<powershell>
#Variables
$appdir = "c:\inetpub\test_app"
$file = "index.html"
$site = "test_app"
$id = "2"
$port = "8080:"
$bucket = "gltest-bucket"

#Install IIS and open port 8080 in firewall
Install-WindowsFeature -name Web-Server -IncludeManagementTools
netsh advfirewall firewall add rule name="Port 8080 for test_app" dir=in action=allow protocol=TCP localport=8080

#Download index.html
New-Item -Path $appdir -ItemType "directory" -Force
#Set-ExecutionPolicy RemoteSigned
#Import-Module AWSPowerShell
Read-S3Object -BucketName $bucket -Key $file -File $appdir\$file

#Deploy site
C:\Windows\System32\inetsrv\appcmd.exe add site /name:$site /id:$id /physicalPath:$appdir\ /bindings:http/*:$port

#Create users with administrative rights
New-LocalUser -AccountNeverExpires:$true -Password ( ConvertTo-SecureString -AsPlainText -Force 'somepassworD123@') -Name 'Admin2' | Add-LocalGroupMember -Group administrators
New-LocalUser -AccountNeverExpires:$true -Password ( ConvertTo-SecureString -AsPlainText -Force 'somepassworD123@') -Name 'Admin3' | Add-LocalGroupMember -Group administrators
</powershell>