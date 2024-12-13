#!/bin/bash
set -e

cd app-config

# 1. Initialize Terraform
echo "Initializing Terraform..."
terraform init

# 2. Plan Terraform Deployment
echo "Creating Terraform plan..."
terraform plan -out=plan.out

# 3. Apply Terraform Configuration
echo "Applying Terraform configuration..."
terraform apply plan.out

echo "SonarQube deployment initiated with Terraform."
