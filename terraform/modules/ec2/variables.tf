# -----------------------------------------------
# EC2 Module - variables.tf
# -----------------------------------------------

variable "project_name" {
  description = "Name of the project, used for resource naming"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type (e.g. t3.micro)"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be launched"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID to attach to the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Name of the AWS Key Pair for SSH access"
  type        = string
}

variable "user_data" {
  description = "User data script to run on instance launch"
  type        = string
  default     = null
}
