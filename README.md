# SonarQube Deployment on Minikube using Terraform

This repository contains the configuration and scripts for deploying SonarQube in a Minikube cluster using Terraform. The deployment utilizes the Bitnami PostgreSQL Helm chart, configures an Nginx ingress controller, and uses persistent storage for SonarQube.

## Prerequisites

Before you begin you will need:

- [Docker](https://docs.docker.com/engine/install/) (prerequsite for Minikube). 
   - Start Docker on your system.

- [Minikube](https://minikube.sigs.k8s.io/docs/start/) (for running Kubernetes cluster locally)
- [Helm 3](https://helm.sh/docs/intro/install/) (for installing and pre-configuring PostgreSQL and SonarQube deployments)
- [Terraform](https://www.terraform.io/downloads.html) (for provisioning infrastructure as code)

## Project Overview

This project provides a Terraform configuration for deploying:

- **PostgreSQL** with [Bitnami Helm chart](https://github.com/bitnami/charts/tree/master/bitnami/postgresql),
- **SonarQube** with [Oteemo Helm chart](https://github.com/Oteemo/charts/tree/master/charts/sonarqube), using PostgreSQL as external database.

### Key Files

1. **Terraform Configuration (`main.tf`)**: Defines providers, PostgreSQL and SonarQube deployment using Helm charts and Kubernetes resource Configmap to pass database connection details to SonarQube (except database password. Password is provided using Kubernetes resource Secret).
2. **PostgreSQL Values (`postgresql-values.yaml`)**: Configuration for the PostgreSQL database.
3. **SonarQube Values (`sonarqube-values.yaml`)**: Configuration for SonarQube specificaly mentioning not to create a new secret, but use PostgreSQL created one, enabling persistence and setting up ingress.
4. **Scripts**: Automated bash scripts for setting up the environment, provisioning SonarQube with external database, and cleaning up the resources.

## Setup and Usage

### 1. Clone the Repository:

Clone this repository to your local machine:

```bash
git clone https://github.com/Anta-Krumina/sonarqube-on-minikube.git
cd sonarqube-on-minikube
```

### 2. Set Up the Environment:
   Run the following script to start Minikube, set up Helm and set up Nginx ingress controller enabling Minikube addon:
   ```bash
   ./setup/1-setup-environment.sh
```

### 3. Deploy SonarQube: 
   Run the following script to initialize Terraform and deploy SonarQube and PostgreSQL with needed configuration
   ```bash
   ./setup/2-provision-sonarqube-postgresql.sh
```

### 4. Clean Up: 
   Run the following script to clean up the environment destroying kubernetes resources and deleting minikube cluster
   ```bash
   ./setup/3-cleanup.sh
```

### Troubleshoot
If provisioning fails on first attempt, re-run provision-sonarqube script again.