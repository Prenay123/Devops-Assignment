# -----------------------------------------------
# VPC Module - variables.tf
# -----------------------------------------------

variable "project_name" {
  description = "Name of the project, used for resource naming"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone for the public subnet"
  type        = string
}
