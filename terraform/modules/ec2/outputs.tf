# -----------------------------------------------
# EC2 Module - outputs.tf
# -----------------------------------------------

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.main.id
}

output "public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.main.public_ip
}

output "public_dns" {
  description = "The public DNS name of the EC2 instance"
  value       = aws_instance.main.public_dns
}

output "private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.main.private_ip
}
