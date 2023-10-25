#Use output to reference sensitive variables. Flagging variable as sensitive causes Terraform to redact values in logs.


output "trusted_ip_address" {
  description = "trusted_ip_address"
  value       = "${var.trusted_ip_address}"
  sensitive   = true
}

output "trusted_ip_address2" {
  description = "trusted_ip_address2"
  value       = "${var.trusted_ip_address2}"
  sensitive   = true
}


output "ad-user-email" {
  description = "ad-user-email"
  value       = "${var.ad-user-email}"
  sensitive   = true
}


output "first-name" {
  description = "first-name"
  value       = "${var.first-name}"
  sensitive   = true
}


output "last-name" {
  description = "last-name"
  value       = "${var.last-name}"
  sensitive   = true
}



output "dir_domain_name" {
  description = "dir_domain_name"
  value       = "${var.dir_domain_name}"
  sensitive   = true
}


output "dir_admin_password" {
  description = "dir_admin_password"
  value       = "${var.dir_admin_password}"
  sensitive   = true
}


