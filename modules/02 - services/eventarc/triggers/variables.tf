variable "triggers" {
  description = "A list of Eventarc triggers to create."
  type = list(object({
    trigger_name = string
    trigger_region = string
    pubsub_topic = string
    target_cloud_run_service_name = string
    path = string
    service_account_email = string
  }))
}