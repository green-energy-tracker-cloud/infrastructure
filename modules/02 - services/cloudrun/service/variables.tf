variable "services" {
  description = "List of Cloud Run Services"
  type = list(object({
    name = string
    location = string
    launch_stage = string
    timeout = string
    service_account = string
    image = string
  }))
}
