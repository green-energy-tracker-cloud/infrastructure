variable "repositories" {
  description = "List of Repositories"
  type = list(object({
    name = string
    project = string
    connection_name = string
    remote_uri = string
    location = string
  }))
}

variable "connection_id" {
  description = "Cloud Build V2 connection ID"
  type = string
}