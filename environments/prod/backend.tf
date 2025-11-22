terraform {
  # Defines the remote storage configuration for Terraform state file.
  backend "gcs" {
    # Specifies the Google Cloud Storage bucket where the 'terraform.tfstate' file will be stored.
    # This enables remote state management, collaboration, and state locking.
    bucket = "green-energy-tfstate"
  }
}