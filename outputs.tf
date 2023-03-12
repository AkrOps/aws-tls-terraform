output "acm_cert_arn" {
  description = "ARN of the server cert imported into ACM"
  value       = try(aws_acm_certificate.this[0].arn, null)
}

output "cert_sans" {
  description = "Certificate Subject Alternative Names"
  value       = tls_cert_request.leaf.dns_names
}

output "cert_ip_sans" {
  description = "Certificate Subject Alternative Names"
  value       = tls_cert_request.leaf.ip_addresses
}

output "secrets_manager_arn" {
  description = "ARN of secrets_manager secret"
  value       = try(aws_secretsmanager_secret.tls[0].arn, null)
}

output "cmk_id" {
  description = "ID of the KMS key used to encrypt the secrets (if one was created)"
  value       = try(aws_kms_key.this[0].key_id, null)
}
