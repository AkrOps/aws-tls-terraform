provider "aws" {
  region = "eu-west-1"
}

module "tls_certs" {
  source = "../.."

  project_id                = "tls-certs-ex01"
  import_leaf_cert_into_acm = true
  save_to_secrets_manager   = true
  create_cmk                = true

  # Emulating a service running in a Kubernetes cluster
  dns_sans = [
    "my-svc",
    "my-svc.my-ns",
    "my-svc.my-ns.svc",
    "my-svc.my-ns.svc.cluster.local",
    "localhost"
  ]

  ip_sans = [
    "127.0.0.1",
    "10.0.0.1",
    "10.0.0.2",
    "10.0.0.3",
  ]
}
