/*
Add AWS Microsoft AD resource and use SSM to automate adding all computers to AD.

The directory has to be created first before instances can be added. Instances need an IAM instance profile attached
to them before they can be added to AD

Note: AD creation can take 20-40 minutes 
*/


/*

resource "aws_directory_service_directory" "three-tier-directory" {
  name     = "johnklemens.local"  
  #set secrets from AWS Secrets Manager
  password = local.ad-creds2.password
  edition  = "Standard"
  type     = "MicrosoftAD"
   

  vpc_settings {
    vpc_id     = aws_vpc.main.id
    subnet_ids = [aws_subnet.private-us-east-1a.id, aws_subnet.private-us-east-1b.id]
  }

  tags = {
    Project = "three-tier"
  }
}





#SSM document and SSM association resource to add newly created instances to Active Directory 
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
            "directoryName" : data.aws_directory_service_directory.three-tier-directory.name
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


*/