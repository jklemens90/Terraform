/*
helps avoid hardcoding values and makes it eaiser to update and maintain configurations. Allows you to reuse code 
and is essential for managing large infrastructure configurations.
Contains declaration of variables, name, type, description and keys that can be referenced by other resources.
*/


/*

#VPC
variable "vpc_cidr" {}

variable "public_subnet_cidr_az1" {}
variable "public_subnet_cidr_az2" {}

variable "private_subnet_cidr_az1" {}
variable "private_subnet_cidr_az2" {}

*/

variable "trusted_ip_address" {}
variable "trusted_ip_address2" {}

# App Stream Userpool
variable "ad-user-email" {}
variable "first-name" {}
variable "last-name" {}


# Directory Service
variable "dir_domain_name" {}
variable "dir_admin_password" {}
#variable "dir_computer_ou" {}

