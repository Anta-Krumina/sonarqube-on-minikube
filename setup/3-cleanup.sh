#!/bin/bash

echo "Cleaning up the environment..."

cd app-config

# Terraform cleanup
echo "Destroying Terraform resources..."
terraform destroy -auto-approve
if [ $? -eq 0 ]; then
  echo "✅ Terraform resources destroyed."
else
  echo "❌ Failed to destroy Terraform resources. Please check manually."
fi

# Minikube cleanup
echo "Stopping and deleting Minikube cluster..."
minikube stop
minikube delete
if [ $? -eq 0 ]; then
  echo "✅ Minikube cluster stopped and deleted."
else
  echo "❌ Failed to stop or delete Minikube cluster. Please check manually."
fi

echo "✅ Cleanup completed."

# Remove added Helm repositories
echo "Remove added helm repositories..."
helm repo remove bitnami oteemocharts