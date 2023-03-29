output "akp_id" {
  value = aws_key_pair.tf-key-pair.id
}

output "tls_priv_key" {
  value = tls_private_key.rsa.private_key_openssh
}