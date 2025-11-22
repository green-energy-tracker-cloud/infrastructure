resource "google_kms_key_ring" "attestation_keyring" {
  project = var.project
  location = var.location
  name = var.key-ring-name
}