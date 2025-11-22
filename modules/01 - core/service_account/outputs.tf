# output: Exposes the full email addresses of the created Service Accounts.
output "emails" {
  description = "Emails of the created Service Accounts"
  value = {
    for sa_key, sa in google_service_account.sa : sa_key => sa.email
  }
}

# output: Exposes the full member strings of the created Service Accounts,
# useful for IAM bindings in other modules.
output "members" {
  description = "Members's service account created"
  value = {
    for sa_key, sa in google_service_account.sa : sa_key => sa.member
  }
}