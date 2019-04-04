<powershell>
#Install CodeDeploy Agent
Set-ExecutionPolicy RemoteSigned
Import-Module AWSPowerShell
$REGION = (ConvertFrom-Json (Invoke-WebRequest -Uri http://169.254.169.254/latest/dynamic/instance-identity/document -UseBasicParsing).Content).region
New-Item -Path c:\temp -ItemType "directory" -Force 
powershell.exe -Command Read-S3Object -BucketName aws-codedeploy-$REGION -Key latest/codedeploy-agent.msi -File c:\temp\codedeploy-agent.msi 
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "ServicesPipeTimeout" -Value 120000 -PropertyType DWORD -Force
c:\temp\codedeploy-agent.msi /quiet /l c:\temp\host-agent-install-log.txt

#install AWS CLI
$storageDir = "c:\temp"
$webclient = New-Object System.Net.WebClient
$url = "https://s3.amazonaws.com/aws-cli/AWSCLI64PY3.msi"
$file = "$storageDir\awscli.msi"
$webclient.DownloadFile($url,$file)
sleep 60
c:\temp\awscli.msi /quiet /l c:\temp\awscli-log.txt
</powershell>