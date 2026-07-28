# -----------------------------------------------
# Keypair Module - variables.tf
# -----------------------------------------------

variable "key_name" {
  description = "Name of the AWS Key Pair"
  type        = string
}

variable "public_key_path" {
  description = "Path to the public key file (.pub)"
  type        = string
}
