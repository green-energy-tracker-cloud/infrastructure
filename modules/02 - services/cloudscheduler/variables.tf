variable "schedulations" {
  description = "List of job schedulations"
  type = list(object({
    name = string
    region = string
    description = string
    time_zone = string
    schedule = string
    project_id = string
    job_name = string
    body = string
    service_account_email = string
    retry_count = number
  }))
}