#!/bin/bash
set -e

# 1. Start Minikube
echo "Starting Minikube..."
minikube start --memory=4g --cpus=2 --driver=docker
# 1.1. Set alias for minikube kubectl
alias kubectl="minikube kubectl --"

# 2. Enable ingress addon Minikube plugin
echo "Enabling Ingress on Minikube..."
minikube addons enable ingress

# 3. Set up Helm
echo "Setting up Helm repositories..."
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add oteemocharts https://oteemo.github.io/charts
helm repo update

echo "✅ Environment setup complete!"
