## Firestore Database Resource
resource "google_firestore_database" "firestore_db" {
  # The ID of the database. The default value "(default)" refers to the primary instance.
  name = "(default)"

  # The regional location where the database will be created (e.g., "nam5", "europe-west1").
  location_id = var.region

  # The database type: "FIRESTORE_NATIVE" for the current mode.
  type = "FIRESTORE_NATIVE"
}