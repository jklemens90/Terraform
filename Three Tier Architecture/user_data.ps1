

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
<#
Rename-Computer -NewName "Server044" -Force -Restart
#>
#---------------------------------------




#---------------------------------------
#user data for initialize-volume ps1. needs revision

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