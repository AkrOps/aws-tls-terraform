resource "null_resource" "certs_local_output" {
  count = var.output_certs_locally ? 1 : 0

  triggers = {
    ca_cert      = tls_self_signed_cert.ca.cert_pem
    leaf_cert    = tls_locally_signed_cert.leaf.cert_pem
    leaf_privkey = tls_private_key.leaf.private_key_pem
  }

  provisioner "local-exec" {
    command = <<EOT
      echo '${tls_self_signed_cert.ca.cert_pem}' > ./ca_cert.pem
      echo '${tls_locally_signed_cert.leaf.cert_pem}' > ./leaf_cert.pem
      echo '${tls_private_key.leaf.private_key_pem}' > ./leaf_privkey.pem
    EOT
  }
}

# In case you only need to install the CA cert
resource "null_resource" "ca_cert_local_output" {
  count = var.output_ca_cert_locally && !var.output_certs_locally ? 1 : 0

  triggers = {
    ca_cert = tls_self_signed_cert.ca.cert_pem
  }

  provisioner "local-exec" {
    command = "echo '${tls_self_signed_cert.ca.cert_pem}' > ./ca_cert.pem"
  }
}
