resource "google_kms_crypto_key" "attestation_key" {
  key_ring = var.attestation_key_ring_id
  name = var.attestation-key-name
  purpose  = var.attestation-key-scope
  version_template {
    algorithm = var.attestation-key-algorithm
  }
}