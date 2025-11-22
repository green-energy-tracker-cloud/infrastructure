# resource: Defines the custom Service Accounts (SAs) based on the input map.
resource "google_service_account" "sa" {
  # Iterates over the 'service_accounts' map provided in variables.tf
  for_each = var.service_accounts

  project = var.project_id
  account_id = each.key # <-- The map key is used as the Service Account ID
  display_name = "SA for ${each.key}"
}

# locals: Merges the roles defined for each Service Account into a flat, single map.
# This flattening is necessary to iterate over all role assignments using a single for_each block later.
locals {
  role_bindings = merge(
    [
      # Outer loop: Iterates over each Service Account key (e.g., "cr-site-bff-prod")
      for sa_key, roles in var.service_accounts : {
      # Inner loop: Iterates over the list of roles for the current Service Account
      for role in roles : "${sa_key}.${replace(role, "roles/", "")}" => {
        # The complex key ensures uniqueness (e.g., "cr-site-bff-prod.datastore.viewer")
        sa_key = sa_key
        role = role
      }
    }
    ]...
  )
}

# resource: Assigns the roles to the created Service Accounts.
resource "google_project_iam_member" "roles" {
  # Iterates over the flattened 'role_bindings' map from locals
  for_each = local.role_bindings

  project = var.project_id
  role = each.value.role
  # The member references the dynamically created Service Account resource
  member = google_service_account.sa[each.value.sa_key].member
}