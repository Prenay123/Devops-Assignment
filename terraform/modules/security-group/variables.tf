# -----------------------------------------------
# Security Group Module - variables.tf
# -----------------------------------------------

variable "project_name" {
  description = "Name of the project, used for resource naming"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}
