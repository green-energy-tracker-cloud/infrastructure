variable "buckets" {
  description = "List of Cloud Storage Buckets"
  type = list(object({
    name = string
    location = string
    uniform_bucket_level_access = bool
    force_destroy = bool
  }))
}
