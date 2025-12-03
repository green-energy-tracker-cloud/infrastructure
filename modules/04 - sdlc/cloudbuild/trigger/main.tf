resource "google_cloudbuild_trigger" "ci_trigger_green_energy" {
  # Iterates over the map of triggers defined in the 'var.triggers' variable.
  # This allows creating multiple Cloud Build triggers from a single configuration block.
  for_each = {
    for triggers in var.triggers : triggers.name => triggers
  }

  # Sets the name of the trigger, using the key of the current item in the iteration.
  name = each.key

  # A user-friendly description for the trigger.
  description = each.value.description

  # The Google Cloud Project ID where the trigger will be created.
  project = each.value.project

  # The name of the Cloud Build configuration file (e.g., 'cloudbuild.yaml')
  # located within the repository, which defines the CI steps.
  filename = each.value.remote_template == null ? try(each.value.ci_config_file, "cloudbuild.yaml") : null

  # The regional location where the Cloud Build job will execute (e.g., 'us-central1').
  location = each.value.location

  # The service account that Cloud Build will use to execute the build steps
  # (e.g., to access GCR, GKE, or other services).
  service_account = each.value.service_account

  # Configuration block defining the source repository and the event that
  # will start the build (e.g., a push to a specific branch).
  repository_event_config {
    # The name of the Cloud Source Repository or external repository connection.
    repository = each.value.repository

    # Configuration specific to push events.
    push {
      # The branch pattern (e.g., '^main$', '^(master|develop)$') that triggers the build.
      branch = each.value.branch
    }
  }
  dynamic "git_file_source" {
    for_each = each.value.remote_template != null ? [1] : []
    content {
      path = each.value.remote_template.filename
      repository = each.value.remote_template.repository
      revision = "refs/heads/${each.value.remote_template.branch}"
      repo_type = "UNKNOWN"
    }
  }
  substitutions = try(each.value.substitutions, {})
}