variable "connection" {
  description = "Connection"
  type = object({
    name = string
    project = string
    location = string
  })
}
