## Cloud Run Job Definition
resource "google_cloud_run_v2_job" "default" {
  # Iterates over the list/map provided in 'var.jobs', mapping the job name to its config object.
  for_each = {
    for jobs in var.jobs : jobs.name => jobs
  }

  # --- Job Identification ---
  # The unique name of the Cloud Run Job.
  name = each.key

  # The GCP region where the Job is deployed.
  location = each.value.location

  # Deployment maturity stage (e.g., "GA").
  launch_stage = each.value.launch_stage

  # 1. OUTER TEMPLATE BLOCK (Job Configuration)
  template {
    # The number of parallel tasks to run. This applies to the entire job.
    task_count = each.value.task_count

    # 2. INNER TEMPLATE BLOCK (Task/Revision Configuration)
    template {
      # The maximum time the container has to run before being cancelled.
      timeout = each.value.timeout

      # The Service Account the container will use for permissions during execution.
      service_account = each.value.service_account

      # --- Container Configuration ---
      containers {
        # The URL of the container image to execute (e.g., from Artifact Registry).
        image = each.value.image
      }
    }
  }
  deletion_protection = false
}