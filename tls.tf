# Generate the CA cert private key
resource "tls_private_key" "ca" {
  algorithm = "RSA"
  rsa_bits  = var.ca_rsa_bits
}

# Generate the CA self-signed cert
resource "tls_self_signed_cert" "ca" {
  private_key_pem = tls_private_key.ca.private_key_pem

  subject {
    common_name = var.ca_cert_common_name
  }

  validity_period_hours = var.ca_validity_period_hours

  allowed_uses = [
    "cert_signing",
    "crl_signing",
  ]

  is_ca_certificate = true
}

# Generate the leaf/server cert private key
resource "tls_private_key" "leaf" {
  algorithm = "RSA"
  rsa_bits  = var.leaf_rsa_bits
}

# Generate the leaf/server cert signing request (CSR)
resource "tls_cert_request" "leaf" {
  private_key_pem = tls_private_key.leaf.private_key_pem

  subject {
    common_name = var.leaf_cert_common_name
  }

  dns_names = var.dns_sans

  ip_addresses = var.ip_sans
}

# Generate the leaf/server cert signed by the CA
resource "tls_locally_signed_cert" "leaf" {
  cert_request_pem   = tls_cert_request.leaf.cert_request_pem
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem

  validity_period_hours = var.leaf_validity_period_hours

  allowed_uses = var.leaf_cert_allowed_uses
}
