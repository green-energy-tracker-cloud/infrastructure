resource "google_artifact_registry_repository" "green_tracker_docker_repo" {
  # Use 'for_each' to iterate over a map defined in 'var.artifact_repositories'.
  # This allows multiple Artifact Registry repositories to be created based on the input variable structure.
  for_each = {
    for artifact_repositories in var.artifact_repositories : artifact_repositories.name => artifact_repositories
  }

  # Specify the Google Cloud project where the repository will be created.
  project = each.value.project

  # Set the unique ID for the repository. We use the map key (each.key) as the repository ID.
  repository_id = each.key

  # Provide a description for the repository.
  description = each.value.description

  # Define the repository format (e.g., 'DOCKER', 'MAVEN', 'NPM').
  format = each.value.format

  # Specify the location (region or multi-region) where the artifacts will be stored.
  location = each.value.location
}