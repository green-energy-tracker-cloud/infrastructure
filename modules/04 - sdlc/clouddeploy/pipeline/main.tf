resource "google_clouddeploy_delivery_pipeline" "primary" {
  location    = "us-east1"
  name        = "pipeline"
  description = "Pipeline con performance test e rollout Canary"
  project     = "green-energy-tracker-cloud"
  provider    = google-beta

  # --- Serial Pipeline ---
  serial_pipeline {

    # 1. STAGE: Deployment su Staging
    stages {
      target_id = "staging-target"
      profiles  = ["staging-profile"]
    }

    # 2. STAGE: Performance Test (Load, Spike, Regression)
    #
    # Nota: L'esecuzione di test complessi richiede un Target Custom.
    # Questo target Custom punterà al tuo esecutore di test (es. Cloud Build)
    # che userà la tua repo Gatling per testare l'ambiente di Staging.
    //stages {
    //  name      = "performance-test"
    //  target_id = "performance-test-executor" # Target Custom per eseguire la job di test
    //  profiles  = ["test-runner-profile"]

    //  # (Opzionale) Se i test devono essere approvati manualmente prima di procedere al PROD
    //  # Si applica se il target 'performance-test-executor' non è auto-approvante.
    //  # approve_on_stage_start = true
    //}

    # 3. STAGE: Deployment Canary su Produzione
    stages {
      target_id = "prod-target"
      profiles  = ["prod-profile"]



    }
  }
}