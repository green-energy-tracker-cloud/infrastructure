resource "google_secret_manager_secret" "secrets_management" {
  for_each = {
    for secrets in var.secrets : secrets.secret_id => secrets
  }
  project = each.value.project
  secret_id = each.key

  replication {
    auto{}
  }
}