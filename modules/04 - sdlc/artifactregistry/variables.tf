variable "artifact_repositories" {
  description = "List of Artifact Registry repositories"
  type = list(object({
    name = string
    project = string
    description = string
    format = string
    location = string
  }))
}