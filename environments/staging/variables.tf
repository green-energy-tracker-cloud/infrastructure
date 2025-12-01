variable "project_id" {
  description = "GCP Project ID"
  type = string
}

variable "region" {
  description = "GCP Primary Region"
  type = string
}

variable "zone" {
  description = "GCP Primary Zone"
  type = string
}

variable "service_accounts" {
  description = "Service Account maps: key-> account_id; value -> roles list"
  type = map(list(string))
  default = {}
}

variable "topicNames" {
  description = "Topic Name"
  type = list(string)
}

variable "eventarc_triggers" {
  description = "A list of Eventarc triggers to create."
  type = list(object({
    trigger_name = string
    trigger_region = string
    pubsub_topic = string
    target_cloud_run_service_name = string
    path = string
    service_account_email = string
  }))
}

variable "schedulations" {
  description = "List of job schedulations"
  type = list(object({
    name = string
    region = string
    description = string
    time_zone = string
    schedule = string
    project_id = string
    job_name = string
    body = string
    service_account_email = string
    retry_count = number
  }))
}

variable "processor_services_name" {
  description = "The list of the processor Cloud Run services"
  type = list(string)
}

variable "bff_services_name" {
  description = "The list of the bff Cloud Run services"
  type = list(string)
}

variable "job_services_name" {
  description = "The list of the job Cloud Run services"
  type = list(string)
}

variable "services" {
  description = "List of Cloud Run Services"
  type = list(object({
    name = string
    location = string
    launch_stage = string
    timeout = string
    service_account = string
    image = string
  }))
}

variable "jobs" {
  description = "List of Cloud Run Jobs"
  type = list(object({
    name = string
    location = string
    launch_stage = string
    timeout = string
    service_account = string
    image = string
    task_count = number
  }))
}

variable "connection" {
  description = "Connection"
  type = object({
    name = string
    project = string
    location = string
  })
}

variable "repositories" {
  description = "List of Repositories"
  type = list(object({
    name = string
    project = string
    connection_name = string
    remote_uri = string
    location = string
  }))
}

variable "cloudbuild_triggers" {
  description = "List of Cloud Build Triggers"
  type = list(object({
    name = string
    description = string
    location = string
    service_account = string
    project = string
    ci_config_file = string
    repository = string
    branch = string
  }))
}

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

variable "key-ring-name" {
  description = "Key Ring Name"
  type = string
}

variable "attestation-key-name" {
  description = "Attestation Key Name"
  type = string
}
variable "attestation-key-scope" {
  description = "Attestation Key Scope"
  type = string
}
variable "attestation-key-algorithm" {
  description = "Attestation Key Algorithm"
  type = string
}

variable "cd_targets" {
  description = "List of CD Targets"
  type = list(object({
    name = string
    project = string
    location = string
    location_run = string
    require_approval = bool
    service_account = string
  }))
}
variable "cd-pipeline-name" {
  description = "Pipeline Name"
  type = string
}

variable "secrets" {
  description = "List of Secrets"
  type = list(object({
    secret_id = string
    project = string
  }))
}

variable "buckets" {
  description = "List of Cloud Storage Buckets"
  type = list(object({
    name = string
    location = string
    uniform_bucket_level_access = bool
    force_destroy = bool
  }))
}