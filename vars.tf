variable "project_id" {
  type        = string
  description = "Name or prefix for every resource, e.g., \"client-project-env\""
}

variable "kms_key_id" {
  type        = string
  description = "ARN/ID of the AWS KMS CMK to be used by Secrets Manager. If unspecified, it defaults to AWS-managed key aws/secretsmanager."
  default     = null
}

variable "recovery_window" {
  type        = number
  description = "Number of days that Secrets Manager waits before it can delete the secret."
  default     = 0
}

variable "tags" {
  type        = map(string)
  description = "Tags for secrets manager secret."
  default = {
    "Name" = "tls-cert"
  }
}

variable "ca_validity_period_hours" {
  type        = number
  description = "Validity period for the CA certificate in hours."
  default     = 2160 # 90 days
}

variable "leaf_validity_period_hours" {
  type        = number
  description = "Validity period for the CA certificate in hours."
  default     = 720 # 30 days
}

variable "import_leaf_cert_into_acm" {
  type        = bool
  description = "Import the leaf/server certificate and key (and CA certificate) into ACM."
  default     = false
}

variable "save_to_secrets_manager" {
  type        = bool
  description = "Save the leaf/server certificate and key (and CA certificate) to Secrets Manager."
  default     = true
}

variable "output_certs_locally" {
  type        = bool
  description = "Output the leaf/server certificate and key (and CA certificate) locally."
  default     = false
}

variable "output_ca_cert_locally" {
  type        = bool
  description = "Output the CA certificate locally."
  default     = false
}

variable "ip_sans" {
  type        = list(string)
  description = "IP SANs (Subject Alternative Names) for TLS certs."
  default     = ["127.0.0.1"]
}

variable "dns_sans" {
  type        = list(string)
  description = "DNS SANs (Subject Alternative Names) for TLS certs."
  default     = ["localhost"]
  validation {
    condition     = length(var.dns_sans) > 0
    error_message = "At least one SAN must be provided."
  }
}

variable "leaf_cert_common_name" {
  type        = string
  description = "Common name for the leaf/server TLS cert, e.g., myapp.myorg.local."
  default     = "localhost"
}

variable "ca_cert_common_name" {
  type        = string
  description = "Common name for the CA TLS cert, e.g., ca.myapp.myorg.local."
  default     = "localhost"
}

variable "leaf_cert_allowed_uses" {
  type        = list(string)
  description = "Allowed uses for the leaf/server certificate."
  default = [
    "client_auth",
    "digital_signature",
    "key_agreement",
    "key_encipherment",
    "server_auth",
  ]
}

variable "ca_rsa_bits" {
  description = "Number of bits for the CA RSA key."
  type        = number
  default     = 4096
}

variable "leaf_rsa_bits" {
  description = "Number of bits for the leaf RSA key."
  type        = number
  default     = 2048
}
