variable "triggers" {
  description = "List of Cloud Build Triggers"
  type = list(object({
    name = string
    description = string
    location = string
    service_account = string
    project = string
    ci_config_file = string
    repository = string
    branch = string
    remote_template = optional(object({
      repository = string
      filename = string
      branch = string
    }))
    substitutions = optional(map(string), {})
  }))
}