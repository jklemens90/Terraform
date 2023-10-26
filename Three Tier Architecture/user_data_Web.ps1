<powershell>
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

# Create a website
$SiteName = "johnklemens.com"
$PhysicalPath = "C:\inetpub\${SiteName}"
New-Item -Path $PhysicalPath -ItemType Directory
New-Website -Name $SiteName -PhysicalPath $PhysicalPath -Port 80 -Force
</powershell>

#Install IIS on web servers and create website