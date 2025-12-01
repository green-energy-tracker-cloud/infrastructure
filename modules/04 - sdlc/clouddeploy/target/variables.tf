variable "cd_targets" {
  description = "List of CD Targets"
  type = list(object({
    name = string
    project = string
    location = string
    location_run = string
    require_approval = bool
    service_account = string
  }))
}