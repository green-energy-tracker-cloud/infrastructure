resource "google_project_service" "project_apis" {
  for_each = toset([
    "run.googleapis.com",                   # Cloud Run API
    "pubsub.googleapis.com",                # Pub/Sub API
    "apigateway.googleapis.com",            # API Gateway API
    "storage.googleapis.com",               # Cloud Storage API
    "bigquery.googleapis.com",              # BigQuery API
    "firestore.googleapis.com",             # Firestore API
    "cloudscheduler.googleapis.com",        # Cloud Scheduler API
    "iam.googleapis.com",                   # IAM API
    "cloudbuild.googleapis.com",            # Cloud Build API
    "logging.googleapis.com",               # Cloud Logging API
    "monitoring.googleapis.com",            # Cloud Monitoring API
    "artifactregistry.googleapis.com",      # Artifact Registry API
    "vpcaccess.googleapis.com",             # VPC Access API
    "containeranalysis.googleapis.com",     # Container Analysis API
    "secretmanager.googleapis.com",         # Secret Manager API
    "eventarc.googleapis.com",              # Eventarc API
    "redis.googleapis.com",                 # Memorystore for Redis API
    "clouddeploy.googleapis.com",           # Cloud Deploy API
    "cloudresourcemanager.googleapis.com",  #Clour Resource Manager API
    "appengine.googleapis.com",             #Clour Resource Manager API
    "containerscanning.googleapis.com"      #Container Scanning API
  ])

  project                    = var.project_id
  service                    = each.key
  disable_on_destroy         = false
}