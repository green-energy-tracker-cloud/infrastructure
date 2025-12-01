# Configure the Google Cloud provider with project and region variables.
provider "google" {
  project = var.project_id
  region  = var.region
}

### Modules

## -------------- 01 - core -----------------------------
  # Enable Google Services API
  # Invokes the module responsible for enabling all necessary GCP APIs (run, pubsub, firestore, etc.)
  module "google-services_api" {
    source = "../../modules/01 - core/google_services_api"
    project_id = var.project_id
  }

  # Create Service Account
  # Invokes the module that creates custom Service Accounts and assigns their project-level IAM roles (based on var.service_accounts map).
  module "service-account" {
    source = "../../modules/01 - core/service_account"
    project_id = var.project_id
    service_accounts = var.service_accounts
  }

## --------------------------------------------------------
## --------------------------------------------------------

## -------------- 02 - services ---------------------------
  # Pub/Sub Management
    #Topics
    module "topics" {
      source = "../../modules/02 - services/pub_sub/topics"
      topicNames = var.topicNames
    }

  # # Cloud Run
  #   #Services
      module "services" {
        source = "../../modules/02 - services/cloudrun/service"
        services = var.services
      }
      #Jobs
      module "jobs" {
        source = "../../modules/02 - services/cloudrun/job"
        jobs = var.jobs
      }
  #
  # #Eventarc Management
  #   #Trigger
      module "trigger" {
        source = "../../modules/02 - services/eventarc/triggers"
        triggers = var.eventarc_triggers
      }
  #
  # #Cloud Scheduler
     module "cloud-scheduler" {
       source = "../../modules/02 - services/cloudscheduler"
       schedulations = var.schedulations
     }
## --------------------------------------------------------
## --------------------------------------------------------

## -------------- 03 - storage ----------------------------
  #Firestore
  module "firestore" {
    source = "../../modules/03 - storage/firestore"
    region = var.region
  }

  #Memorystore for Redis Instance
  module "memory-store" {
    source = "../../modules/03 - storage/memorystore"
    region = var.region
  }

  #Cloud Storage Bucket
  module "cloud-storage-bucket" {
    source = "../../modules/03 - storage/cloudstorage"
    buckets = var.buckets
  }

  //#Bigtable Instance
  //module "bigtable" {
  //  source = "../../modules/03 - storage/bigtable"
  //  zone = var.zone
  //}
## --------------------------------------------------------
## --------------------------------------------------------

## -------------- 04 - sdlc ----------------------------
  #Cloud Build
    #Connections
    module "connections" {
      source = "../../modules/04 - sdlc/cloudbuild/connection"
      connection = var.connection
    }
    #Repositories
    module "repositories" {
      source = "../../modules/04 - sdlc/cloudbuild/repository"
      repositories = var.repositories
      connection_id = module.connections.connection_id
    }
    #Triggers
    module "build-triggers" {
      source = "../../modules/04 - sdlc/cloudbuild/trigger"
      triggers = var.cloudbuild_triggers
    }

  #Artifact Registry Repositories
  module "artifact-repositories" {
    source = "../../modules/04 - sdlc/artifactregistry"
    artifact_repositories = var.artifact_repositories
  }

  #Cloud Deploy
    #Target
    module "cloud-deploy-target" {
      source = "../../modules/04 - sdlc/clouddeploy/target"
      cd_targets = var.cd_targets
    }
    #Pipeline
    module "cloud-deploy-pipeline" {
      source = "../../modules/04 - sdlc/clouddeploy/pipeline"
      cd-pipeline-name = ""
      location = ""
      project = ""
    }
## ------------------------------------------------------
## ------------------------------------------------------
## -------------- 05 - security --------------------------
#Secret Manager
module "secret-manager" {
  source = "../../modules/05 - security/secretmanager"
  secrets = var.secrets
}
## ------------------------------------------------------
## ------------------------------------------------------