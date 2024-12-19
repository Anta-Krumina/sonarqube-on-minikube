#!/bin/bash

cd app-config

# Step 1: Destroy Terraform resources
echo "Destroying Terraform resources..."
terraform destroy -auto-approve

# Step 2: Remove PostgreSQL PVC and PV to ensure a fresh password on next run
echo "Removing PVC and PV..."
kubectl delete pvc --all
kubectl delete pv --all

# Step 3: Re-run the provision-sonarqube script
echo "Re-running provision script for SonarQube and PostgreSQL..."
./setup/2-provision-sonarqube-postgresql.sh

echo "✅ Process complete."
