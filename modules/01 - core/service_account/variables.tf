# variable: Defines the GCP Project ID input.
variable "project_id" {
  description = "GCP Project ID"
  type = string
}

# variable: Defines the input map for Service Account creation and role assignment.
# Key is the desired account_id, and the value is a list of roles (e.g., ["roles/datastore.viewer"]).
variable "service_accounts" {
  description = "Service Account maps: key-> account_id; value -> roles list"
  type = map(list(string))
  default = {}
}