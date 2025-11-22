output "crypto_key_name" {
  description = "The full resource name (path) of the KMS Crypto Key (e.g., projects/.../cryptoKeys/...). Needed for data source."
  value = google_kms_crypto_key.attestation_key.name
}

output "crypto_key_id" {
  description = "The full resource ID of the KMS Crypto Key. Needed for IAM."
  value = google_kms_crypto_key.attestation_key.id
}