
#---------------------------------------
<#

IIS install script works successfully in the OS, but I cant seem to get the user data script to initiate.

# user_data.ps1
<powershell>
Set-ExecutionPolicy RemoteSigned
Set-ExecutionPolicy Unrestricted

# Install IIS
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

# Create a website
$SiteName = "johnklemens.com"
$PhysicalPath = "C:\inetpub\${SiteName}"
New-Item -Path $PhysicalPath -ItemType Directory
New-Website -Name $SiteName -PhysicalPath $PhysicalPath -Port 80 -Force
</powershell>

#>
#---------------------------------------



#---------------------------------------
<#
Create powershell script to install Apache on web servers
#>

#---------------------------------------




#---------------------------------------
<#
Create powershell script which would create an Availability Group in SSMS and have the primary SQL node 
point to a secondary node in the other private subnet. 
#>
#---------------------------------------






#---------------------------------------
#works in OS but cant make it work via user data script
<#
Rename-Computer -NewName "Server044" -Force -Restart
#>
#---------------------------------------




#---------------------------------------
#user data for initialize-volume ps1. cant get it to work in OS or via user data script.

<#
 template = <<EOF
  <powershell>
  ${file("${path.module}/initialize-volume.ps1")}
  setup-volume -driveLetter D -label Application  
  </powershell>
  EOF
  #>
 #---------------------------------------


 #---------------------------------------------
 <#
 Create powershell script to install RSAT tools in OS on the AD management instance.
  #>