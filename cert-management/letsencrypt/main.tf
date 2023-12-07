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
  email_address   = var.user_email
}

resource "acme_certificate" "certificate" {
  account_key_pem           = acme_registration.reg.account_key_pem
  common_name               = var.server_cert_cn
  subject_alternative_names = [var.server_cert_cn]
  disable_complete_propagation = true

  dns_challenge {
    provider = "gcloud"
    config = {
        GCE_PROJECT = var.gcp_project_id
    }
  }
}