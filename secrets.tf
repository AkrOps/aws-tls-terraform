resource "aws_secretsmanager_secret" "tls" {
  name                    = "${var.project_id}-tls-secret"
  description             = "${var.project_id} TLS certs and private keys"
  kms_key_id              = var.kms_key_id
  recovery_window_in_days = var.recovery_window
  tags                    = var.tags
}

locals {
  tls_data = {
    ca_cert = base64encode(tls_self_signed_cert.ca.cert_pem)
    cert    = base64encode(tls_locally_signed_cert.leaf.cert_pem)
    privkey = base64encode(tls_private_key.leaf.private_key_pem)
  }

  secret = jsonencode(local.tls_data)
}

resource "aws_secretsmanager_secret_version" "tls" {
  secret_id     = aws_secretsmanager_secret.tls.id
  secret_string = local.secret
}
