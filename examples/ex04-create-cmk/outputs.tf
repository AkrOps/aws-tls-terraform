output "cmk_id" {
  description = "The ID of the newly created KMS CMK (Customer Managed Key) used to encrypt Secrets Manager secrets."
  value = module.tls_certs.cmk_id
}
