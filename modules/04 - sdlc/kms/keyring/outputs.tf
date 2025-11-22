output "key-ring-id" {
  description = "Key Ring id"
  value = google_kms_key_ring.attestation_keyring.id
}