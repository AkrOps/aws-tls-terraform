output "acm_cert_arn" {
  description = "ARN of the server cert imported into ACM"
  value       = try(aws_acm_certificate.this[0].arn, null)
}

output "cert_sans" {
  description = "Certificate Subject Alternative Names"
  value       = var.dns_sans
}

output "secrets_manager_arn" {
  description = "ARN of secrets_manager secret"
  value       = try(aws_secretsmanager_secret.tls[0].arn, null)
}
