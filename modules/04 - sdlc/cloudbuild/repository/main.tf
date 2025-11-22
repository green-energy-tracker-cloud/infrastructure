resource "google_cloudbuildv2_repository" "microservices_repo" {
  # Use 'for_each' to iterate over a map defined in 'var.repositories'.
  # This enables the creation of multiple Cloud Build V2 repository definitions
  # from a single input variable structure.
  for_each = {
    for repositories in var.repositories : repositories.name => repositories
  }

  # Specify the Google Cloud project where the repository resource is defined.
  project = each.value.project

  # The location must match the location of the parent_connection, which is typically 'global'.
  location = each.value.location

  # Set the unique identifier (name) for the Cloud Build V2 repository resource.
  name = each.key

  # Link this repository to a previously defined Cloud Build V2 Connection (google_cloudbuildv2_connection).
  # This connection handles the authentication and synchronization with the external Git provider (e.g., GitHub).
  parent_connection = var.connection_id

  # The URI (URL) of the source code repository on the external Git provider (e.g., "https://github.com/org/repo-name").
  remote_uri = each.value.remote_uri
}