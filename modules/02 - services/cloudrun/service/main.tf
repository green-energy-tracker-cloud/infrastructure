## Cloud Run Service Definition (Multiple Services)
resource "google_cloud_run_v2_service" "processor_service" {
  # Iterates over the list/map provided in 'var.services'.
  # Creates a map where the key (each.key) is the service name, and the value (each.value)
  # is the full service configuration object.
  for_each = {
    for services in var.services : services.name => services
  }

  # --- Service Identification ---
  # The unique name of the Cloud Run service, derived from the map key.
  name = each.key

  # The geographic location (region) where the service will be deployed.
  location = each.value.location

  # Deployment maturity stage (e.g., "GA" or "BETA").
  launch_stage = each.value.launch_stage

  # --- Revision Template Configuration ---
  template {
    # The maximum amount of time the service will wait for the container to respond to a request.
    timeout = each.value.timeout
    service_account = each.value.service_account
    containers {
      # The full URL of the container image to run (e.g., from Artifact Registry).
      image = each.value.image
      # NOTE: Resources, env variables, ports, etc., can be configured here
      # by referencing additional fields in the 'each.value' object if needed.
    }
  }
  deletion_protection = false

  lifecycle {
    ignore_changes = [
      client,
      client_version,
      traffic,
      template[0].containers[0].image,
      template[0].labels,
      template[0].annotations
    ]
  }
}