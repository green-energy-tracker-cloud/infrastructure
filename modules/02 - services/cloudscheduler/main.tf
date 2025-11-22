## Cloud Scheduler Job (HTTP Target for Cloud Run Job)
resource "google_cloud_scheduler_job" "hourly_aggregator_job" {
  # Iterates over the 'var.schedulations' list. It creates a map where the key (each.key)
  # is the job name, and the value (each.value) is the full configuration object.
  for_each = {
    for schedulations in var.schedulations : schedulations.name => schedulations
  }

  # --- Job Identification ---
  # The unique name of the scheduler job.
  name = each.key
  # The GCP region where the scheduler job is deployed.
  region = each.value.region
  # Descriptive text for the job.
  description = each.value.description
  # The time zone used for interpreting the schedule (e.g., "Europe/Rome").
  time_zone = each.value.time_zone
  # The frequency of execution, defined in cron format (e.g., "0 * * * *" for hourly).
  schedule = each.value.schedule

  # --- HTTP Target Configuration ---
  http_target {
    # Constructs the Cloud Run V2 Job API endpoint URL (projects/{p}/locations/{r}/jobs/{j}:run).
    uri = format(
      "https://%[1]s-run.googleapis.com/v2/projects/%[2]s/locations/%[1]s/jobs/%[3]s:run",
      each.value.region,
      each.value.project_id,
      each.value.job_name
    )
    # The HTTP method used to invoke the API.
    http_method = "POST"
    # The body/payload sent with the request.
    body = each.value.body

    # Authentication block for private API endpoints
    oauth_token {
      # The Service Account email used to authorize the HTTP request.
      service_account_email = each.value.service_account_email
    }
  }

  # --- Retry Configuration ---
  retry_config {
    # The number of times the job will be retried if the initial attempt fails.
    retry_count = each.value.retry_count
  }
}