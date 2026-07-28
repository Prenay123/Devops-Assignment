# -----------------------------------------------
# Keypair Module - outputs.tf
# -----------------------------------------------

output "key_name" {
  description = "The name of the created Key Pair"
  value       = aws_key_pair.main.key_name
}

output "key_pair_id" {
  description = "The ID of the created Key Pair"
  value       = aws_key_pair.main.id
}
