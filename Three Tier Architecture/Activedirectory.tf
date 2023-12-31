/*
Add AWS Microsoft AD resource and use SSM to automate adding all computers to the directory.

The directory has to be created first before instances can be added. 

Note: AD creation can take 20-40 minutes 
*/




resource "aws_directory_service_directory" "three-tier-directory" {  
  name     = "${var.dir_domain_name}"
  password = "${var.dir_admin_password}"
  #set secrets from AWS Secrets Manager
  #name     = "${var.dir_domain_name}" 
  #password = local.ad-creds2.password
  edition  = "Standard"
  type     = "MicrosoftAD"
   

  vpc_settings {
    vpc_id     = aws_vpc.shared-services.id
    subnet_ids = [aws_subnet.shared-private-us-east-1a.id, aws_subnet.shared-private-us-east-1b.id]
  }


  tags = {
    Project = "three-tier"
  }
}


#SSM document and SSM association resource created to add newly created instances to Active Directory 
#EC2 instances must have an instance profile declared which allows EC2 to communicate with SSM and AD

#Connect to AWS Directory service
data "aws_directory_service_directory" "three-tier-directory" {
  directory_id = aws_directory_service_directory.three-tier-directory.id
}


#AD Join
resource "aws_ssm_document" "ad-join-domain" {
  name          = "ad-join-domain"
  document_type = "Command"
  content = jsonencode(
    {
      "schemaVersion" = "2.2"
      "description"   = "aws:domainJoin"
      "mainSteps" = [
        {
          "action" = "aws:domainJoin",
          "name"   = "domainJoin",
          "inputs" = {
            "directoryId" : data.aws_directory_service_directory.three-tier-directory.id,
            "directoryName" : data.aws_directory_service_directory.three-tier-directory.name,  
            #"directoryOU": "${var.dir_computer_ou}",                 
            "dnsIpAddresses" : sort(data.aws_directory_service_directory.three-tier-directory.dns_ip_addresses)
          }
        }
      ]
    }
  )
}

#Use wildcard to Associate policy to all instances in AWS account. 
resource "aws_ssm_association" "windows_server" {
  name = aws_ssm_document.ad-join-domain.name
  targets {
    key    = "InstanceIds"
    values = ["*"]
  }
}



