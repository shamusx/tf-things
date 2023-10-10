terraform {
  required_providers {
    acme = {
      source = "vancluever/acme"
      version = "2.12.0"
    }
  }
}

provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = "test.email.int"
}

resource "acme_certificate" "certificate" {
  account_key_pem           = acme_registration.reg.account_key_pem
  common_name               = "tftest.gcp.sandbox.test.int"
  subject_alternative_names = ["tftest.gcp.sandbox.test.int"]
  disable_complete_propagation = true

  dns_challenge {
    provider = "gcloud"
    config = {
        GCE_PROJECT = "dns-project"
    }
  }
}