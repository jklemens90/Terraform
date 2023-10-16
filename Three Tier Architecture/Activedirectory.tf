/*
Add AWS Microsoft AD resource and use SSM to automate adding all computers to AD.

The directory has to be created first before instances can be added. Instances need an IAM instance profile attached
to them before they can be added to AD

Note: AD creation can take 20-40 minutes 
*/



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


data "aws_secretsmanager_secret_version" "ad-creds2" {
  # Fill in the name you gave to your secret
  secret_id = "ad-creds2"
}

#Use jsondecode to parse in the secret
locals {
  ad-creds2 = jsondecode(
    data.aws_secretsmanager_secret_version.ad-creds2.secret_string
  )
}


/*
#SSM document and SSM association resource to add newly created instances to Active Directory 
#EC2 instances must have an instance profile declared which allows EC2 to communicate with SSM and AD


#Connect to AWS Directory service
data "aws_directory_service_directory" "three-tier-directory" {
  directory_id = "d-XXXXXXXXXXXXX"
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

#Associate policy to instance
resource "aws_ssm_association" "windows_server" {
  name = aws_ssm_document.ad-join-domain.name
  targets {
    key    = "InstanceIds"
    values = ["i-XXXXXXXXXXXX"]
  }
}
*/