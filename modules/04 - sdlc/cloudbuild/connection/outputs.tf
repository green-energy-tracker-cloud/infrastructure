# cloud-build-connections/outputs.tf
output "connection_id" {
  description = "The full resource ID of the Cloud Build V2 connection."
  value = google_cloudbuildv2_connection.github_connection.id
}