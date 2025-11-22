## Multi-Instance Eventarc Trigger
resource "google_eventarc_trigger" "processor_trigger" {
  # Creates a temporary map to iterate over the 'var.triggers' list.
  # The map key is set to the unique 'trigger_name',
  # and the value is the full trigger object.
  for_each = {
    for trigger in var.triggers : trigger.trigger_name => trigger
  }

  # Identification
  # The resource name is set to the unique key of the map (the trigger name).
  name = each.key
  # The region where the trigger will be deployed.
  location = each.value.trigger_region
  # Event Matching Criteria 1: Event Type
  matching_criteria {
    attribute = "type"
    # The standardized event type.
    value = "google.cloud.pubsub.topic.v1.messagePublished"
  }

  transport {
    pubsub {
      topic = each.value.pubsub_topic
    }
  }

  # Destination Configuration (Cloud Run)
  destination {
    cloud_run_service {
      # The name of the Cloud Run service to be invoked upon event match.
      service = each.value.target_cloud_run_service_name
      # The region where the target Cloud Run service is located.
      region = each.value.trigger_region
      path = each.value.path
    }
  }

  # Security Configuration
  # The Service Account email used by Eventarc to manage the subscription and invoke the target service.
  service_account = each.value.service_account_email
}