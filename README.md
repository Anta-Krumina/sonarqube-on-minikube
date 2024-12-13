# SonarQube Deployment on Minikube using Terraform

This repository contains the configuration and scripts for deploying SonarQube in a Minikube cluster using Terraform. The deployment utilizes the Bitnami PostgreSQL Helm chart, configures an Nginx ingress controller, and uses persistent storage for SonarQube.

## Prerequisites

Before you begin, ensure the following tools are installed:

- [Minikube](https://minikube.sigs.k8s.io/docs/) (for running Kubernetes clusters locally)
- [Helm 3](https://helm.sh/docs/intro/install/) (for managing Kubernetes applications)
- [Terraform](https://www.terraform.io/downloads.html) (for infrastructure as code and provisioning)

## Project Overview

This project provides a Terraform configuration for deploying:

- **PostgreSQL** using the Bitnami Helm chart.
- **SonarQube** using the Oteemo SonarQube Helm chart, with PostgreSQL configured as the external database.

### Key Files

1. **Terraform Configuration (`main.tf`)**: Defines the Kubernetes provider, Helm charts, PostgreSQL and SonarQube deployment.
2. **PostgreSQL Values (`postgresql-values.yaml`)**: Configuration for the PostgreSQL database.
3. **SonarQube Values (`sonarqube-values.yaml`)**: Configuration for SonarQube deployment, including Ingress, external PostgreSQL settings, and persistence.
4. **Scripts**: Automated bash scripts for setting up the environment, provisioning SonarQube, and cleaning up the resources.

## Setup and Usage

### 1. Clone the Repository

Clone this repository to your local machine:

```bash
git clone <your-repository-url>
cd <your-repository-directory>
```

### 2. Set Up the Environment
   Run the following script to start Minikube, set up Helm, and enable Ingress:
   ```bash
   ./setup-env
```

### 3. Deploy SonarQube: Run the script to initialize Terraform and deploy SonarQube
   ```bash
   ./provision-sonarqube
```

### 4. Clean Up: Run the script to clean up the environment:
   ```bash
   ./cleanup
```