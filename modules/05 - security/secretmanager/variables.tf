variable "secrets" {
  description = "List of Secrets"
  type = list(object({
    secret_id = string
    project = string
  }))
}