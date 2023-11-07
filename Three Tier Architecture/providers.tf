
#a provider is a plugin that enables interaction with an API. Cloud provider and SaaS providers.


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.22.0"
    }
  }
}



provider "aws" {
  region                  = "us-east-1"  
  shared_credentials_files = ["~/.aws/credentials"]
  profile                 = "vscode"
}







/*
# Add alias provider for us-east-2

provider "aws" {
  region  = "us-east-2"
  profile = "shared-services"
  alias   = "shared-services"
}


When creating a resource that needs to be deployed into another region, make sure to add the following line which 
specifies the provider, profile, and region associated with it:

provider = aws.shared-services
*/
