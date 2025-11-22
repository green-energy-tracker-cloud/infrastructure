resource "google_clouddeploy_target" "primary_cloudrun_target" {
  # The 'for_each' meta-argument iterates over a map constructed from the 'cd_targets' variable.
  # This allows creating multiple Cloud Deploy Target resources dynamically
  # based on the list of targets provided in the variable.
  for_each = {
    for cd_targets in var.cd_targets : cd_targets.name => cd_targets
  }

  # Specifies the Google Cloud Provider version to use, often 'google-beta'
  # is required for newer Cloud Deploy features.
  provider = google-beta

  # The ID of the Google Cloud project where the target will reside.
  project = each.value.project

  # The regional location where the Cloud Deploy Target resource itself is created (e.g., 'us-west1').
  location = each.value.location

  # The unique name for the target.
  name = each.value.name

  # Defines whether deployment to this target requires manual approval before proceeding.
  require_approval = each.value.require_approval

  # Configuration block specific to Cloud Run targets.
  # This block instructs Cloud Deploy to treat this target as a Cloud Run service endpoint.
  run {
    # Specifies the regional location of the actual Cloud Run service
    # that Cloud Deploy will manage (this can be the same as 'location').
    location = each.value.location_run
  }

  # Configuration block defining how deployment operations are executed.
  execution_configs {
    # Defines which types of operations this configuration applies to:
    # "RENDER" (for rendering manifests) and "DEPLOY" (for applying manifests).
    usages = ["RENDER", "DEPLOY"]

    # Specifies the maximum time allowed for the execution of the deploy or render operation.
    execution_timeout = "3600s" # 1 hour
  }
}