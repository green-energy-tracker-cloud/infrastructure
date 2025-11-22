# Exports the connection IP address (hostname) of the created Redis instance.
output "redis_host" {
  value = google_redis_instance.redis_instance.host
}

# Exports the connection port number for the Redis instance.
output "redis_port" {
  value = google_redis_instance.redis_instance.port
}