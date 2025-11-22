## Google Pub/Sub Topic Resource
resource "google_pubsub_topic" "topic" {
  # Iterates over the list provided in var.names.
  # Terraform will create one resource instance for each string in the list.
  for_each = toset(var.topicNames)
  # Sets the name of the topic using the current value from the iteration.
  name = each.value
}