/*
helps avoid hardcoding values and makes it easier to update and maintain configurations. Allows you to reuse code 
and is essential for managing large infrastructure configurations.
Contains declaration of variables, name, type, description and keys that can be referenced by other resources.

Flag variables involving secrets as sensitive. Used to redact secret values from the output when a terraform
plan is ran. Use a separate .tfvars file called secrets.tfvars to store secret values. 
*/


variable "trusted_ip_address" {
    sensitive = true
}
    

variable "trusted_ip_address2" {
    sensitive = true
}


# App Stream Userpool
variable "ad-user-email" {
    sensitive = true
}

variable "first-name" {
    sensitive = true
}

variable "last-name" {
    sensitive = true
}


# Directory Service
variable "dir_domain_name" {
    sensitive = true
}

variable "dir_admin_password" {
    sensitive = true
}


#variable "dir_computer_ou" {}



/*

#VPC
variable "vpc_cidr" {}

variable "public_subnet_cidr_az1" {}
variable "public_subnet_cidr_az2" {}

variable "private_subnet_cidr_az1" {}
variable "private_subnet_cidr_az2" {}

*/
