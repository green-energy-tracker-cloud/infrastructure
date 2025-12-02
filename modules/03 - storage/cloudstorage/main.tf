resource "google_storage_bucket" "deploy_artifacts" {
  for_each = {
    for buckets in var.buckets : buckets.name => buckets
  }
  name = each.key
  location = each.value.location
  uniform_bucket_level_access = each.value.uniform_bucket_level_access
  force_destroy = each.value.force_destroy
}