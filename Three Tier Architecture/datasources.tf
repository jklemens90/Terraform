#Data sources allow Terraform to use information defined outside of Terraform, such as AWS by fetching data from API
#allows Terraform to use existing data/resources.



data "aws_ami" "Windows-2019" {
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["801119661308"] # Canonical 
}



#data source for WindowsSQL Server AMI for the EC2 DB instances. 

data "aws_ami" "Windows-2019-SQLServer" {
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-SQL_2019_Standard*"]
  }
  filter {
    name   = "virtualization-type" 
    values = ["hvm"]
  }
  owners = ["801119661308"] # Canonical 
}









# use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}


/*

data "template_file" "user_data2" {
  template = file("${ThreeTierArchitecture}/user_data2.ps1")
}

*/