#!/bin/bash

echo "Cleaning up the environment..."

cd app-config

# Terraform cleanup
echo "Destroying Terraform resources..."
terraform destroy -auto-approve

# Minikube cleanup
echo "Stopping and deleting Minikube cluster..."
minikube stop
minikube delete

# Remove added Helm repositories
echo "Remove added helm repositories..."
helm repo remove bitnami oteemocharts