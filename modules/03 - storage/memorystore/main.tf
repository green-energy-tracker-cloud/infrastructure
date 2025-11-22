## Memorystore for Redis Instance
resource "google_redis_instance" "redis_instance" {
  # Name of the Redis instance.
  name = "redis-caching-instance"

  # Memory allocated to the instance, measured in GiB.
  memory_size_gb = 1

  # Service tier: "BASIC" (single node).
  tier = "BASIC"

  # Version of Redis to use.
  redis_version = "REDIS_7_0"

  # The VPC network authorized to access the Redis instance (e.g., "default").
  authorized_network = "default"

  # The compute zone where the instance will be created (e.g., "europe-west1-b").
  region = var.region
}