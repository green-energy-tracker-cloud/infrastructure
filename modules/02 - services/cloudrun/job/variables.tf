variable "jobs" {
  description = "List of Cloud Run Jobs"
  type = list(object({
    name = string
    location = string
    launch_stage = string
    timeout = string
    service_account = string
    image = string
    task_count = number
  }))
}
