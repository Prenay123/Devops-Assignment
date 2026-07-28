# -----------------------------------------------
# Security Group Module - outputs.tf
# -----------------------------------------------

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.main.id
}

output "security_group_name" {
  description = "The name of the security group"
  value       = aws_security_group.main.name
}
