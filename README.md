# Green Energy Tracker Cloud - Infrastructure

This repository contains the Infrastructure as Code (IaC) for the Green Energy Tracker Cloud platform. It uses [Terraform](https://www.terraform.io/) to define, provision, and manage the cloud infrastructure on [Google Cloud Platform (GCP)](https://cloud.google.com/).

## Architecture Overview

The infrastructure is designed following modern cloud-native principles, emphasizing modularity, reusability, and environment segregation.

### Technology Stack

*   **IaC:** Terraform
*   **Cloud Provider:** Google Cloud Platform (GCP)

### Core Principles

*   **Modularity:** The infrastructure is broken down into reusable modules, each responsible for a specific component (e.g., a Cloud Run service, a Pub/Sub topic). This promotes consistency and simplifies maintenance.
*   **Environment Separation:** The `environments` directory provides a clean separation between `staging`, `production`, and potentially other environments. Each environment is a self-contained Terraform workspace, ensuring that changes can be tested in isolation before being promoted.
*   **Serverless & Event-Driven:** The architecture heavily relies on serverless and managed services like Cloud Run, Cloud Scheduler, and Eventarc. This approach minimizes operational overhead and allows the platform to scale automatically based on demand. Asynchronous communication is facilitated by Pub/Sub, decoupling services and improving resilience.

## Directory Structure

The repository is organized as follows:

```
.
├── environments/
│   ├── prod/             # Production environment configuration
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   └── variables.tf
│   └── staging/          # Staging environment configuration
│       ├── backend.tf
│       ├── main.tf
│       └── variables.tf
│
└── modules/
    ├── 01 - core/          # Foundational resources
    │   ├── google_services_api/
    │   ├── service_account/
    │   └── service_agents_iam/
    │
    ├── 02 - services/      # Application runtime components
    │   ├── cloudrun/
    │   ├── cloudscheduler/
    │   ├── eventarc/
    │   └── pub_sub/
    │
    └── 03 - storage/       # Data persistence and storage layers
        ├── bigtable/
        ├── firestore/
        └── memorystore/
```

*   **`/environments`**: Contains the top-level configurations for each deployment environment (e.g., `staging`, `prod`). These files compose the underlying modules to build a complete infrastructure for an environment. The `backend.tf` configures the Terraform remote state storage for collaboration and safety.
*   **`/modules`**: Contains reusable Terraform modules that define specific parts of the infrastructure.
    *   **`01 - core`**: Foundational components required for the GCP project to function correctly, such as service accounts, IAM policies, and enabling necessary APIs.
    *   **`02 - services`**: Defines the application's compute and messaging components. This includes services and jobs on Cloud Run, scheduled tasks with Cloud Scheduler, event-driven triggers with Eventarc, and message topics with Pub/Sub.
    *   **`03 - storage`**: Defines the data persistence layers, including Firestore for document-based data, Memorystore (Redis) for caching or session management, and Bigtable for large-scale analytical or time-series data.

## Prerequisites

Before you begin, ensure you have the following installed and configured:

1.  **Terraform CLI**: [Installation Guide](https://learn.hashicorp.com/tutorials/terraform/install-cli)
2.  **Google Cloud SDK (`gcloud`)**: [Installation Guide](https://cloud.google.com/sdk/docs/install)
3.  **Authentication**: You must be authenticated with GCP. The simplest way is to run:
    ```sh
    gcloud auth application-default login
    ```

## Usage

To provision or modify the infrastructure, follow these steps from within a specific environment's directory.

**Warning:** Always run `plan` before `apply` to review the changes that will be made.

1.  **Navigate to an environment directory:**
    ```sh
    cd environments/staging
    ```

2.  **Initialize Terraform:**
    This command initializes the backend, downloads provider plugins, and sets up the workspace.
    ```sh
    terraform init
    ```

3.  **Create a Plan:**
    Terraform will determine the actions required to achieve the desired state defined in the configuration files. It's recommended to create a `terraform.tfvars` file to supply values for the variables defined in `variables.tf`.
    ```sh
    terraform plan -out=staging.tfplan
    ```

4.  **Apply the Plan:**
    This command applies the changes to the cloud environment.
    ```sh
    terraform apply "staging.tfplan"
    ```

## Configuration

All configurable parameters for modules and environments are defined in `variables.tf` files. To set values for these variables for a specific environment, create a `terraform.tfvars` file inside the corresponding environment directory. This file should not be committed to version control.