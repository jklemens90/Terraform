
#a provider is a plugin that enables interaction with an API. Cloud provider and SaaS providers.


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}




provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "vscode"
}


/*  Add alias provider for us-east-2 for shared services resources

provider "aws" {
  region  = "us-east-1"
  profile = "vscode"
  alias   = "vscode"
}



provider "aws" {
  region  = "us-east-2"
  shared_credentials_file = "~/.aws/credentials"
  profile = "shared-services"
  alias   = "shared-services"
}

*/
