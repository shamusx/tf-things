output "lets_encrypt_cert" {
  value = acme_certificate.certificate.certificate_pem
}

output "lets_encrypt_key" {
  value = acme_certificate.certificate.private_key_pem
}

output "lets_encrypt_issuer" {
  value = acme_certificate.certificate.issuer_pem
}