variable "attestation-key-name" {
  description = "Attestation Key Name"
  type = string
}
variable "attestation-key-scope" {
  description = "Attestation Key Scope"
  type = string
}
variable "attestation-key-algorithm" {
  description = "Attestation Key Algorithm"
  type = string
}
variable "attestation_key_ring_id" {
  description = "The full resource ID of the KMS Key Ring to create the Crypto Key under."
  type        = string
}
variable "project" {
  description = "Attestation Key Project"
  type = string
}