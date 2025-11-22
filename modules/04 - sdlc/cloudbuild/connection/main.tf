resource "google_cloudbuildv2_connection" "github_connection" {

  # Specify the Google Cloud project where the connection will be established.
  project = var.connection.project

  # Cloud Build V2 connections are currently defined as 'global' resources.
  location = var.connection.location

  # Set the unique name for the Cloud Build connection, derived from the key of the 'for_each' iteration.
  name = var.connection.name

  # Define the connection type as GitHub.
  # By using an empty block, we rely on the standard GitHub App installation/authentication
  # to be completed separately via the GCP Console or APIs, avoiding the need to expose secrets
  # (e.g., in an 'authorizer_credential' block) in Terraform.
  github_config {}
  lifecycle {
    ignore_changes = [
      github_config,
    ]
  }
}