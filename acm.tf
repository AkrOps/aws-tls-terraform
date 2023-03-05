resource "aws_acm_certificate" "this" {
  count = var.import_leaf_cert_into_acm ? 1 : 0

  private_key       = tls_private_key.leaf.private_key_pem
  certificate_body  = tls_locally_signed_cert.leaf.cert_pem
  certificate_chain = tls_self_signed_cert.ca.cert_pem
}
