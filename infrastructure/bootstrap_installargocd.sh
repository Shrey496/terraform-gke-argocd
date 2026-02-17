#!/bin/bash
set -e

#Configuration 
PROJECT_ID=""
CLUSTER_NAME=""
REGION=""

echo "Connecting to GKE.."
gcloud container clusters get-credentials $CLUSTER_NAME --region $REGION --project $PROJECT_ID

echo "Installing ArgoCD.."
kubectl create namespace argocd || true
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "Waiting for ArgoCD to start.."
kubectl wait --for=condition=available --timeout=600s deployment/argocd-server -n argocd

echo "Getting Initial Password for ArgoCD..."
# Grabs the secret, finds the data field named password, and decodes it from Base64.
ARGOCD_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

echo "Success! ArgoCD is running."
echo "------------------------------------------------"
echo "URL: localhost:8080 (Run port-forward command below)"
echo "User: admin"
echo "Pass: $ARGOCD_PASSWORD"
echo "------------------------------------------------"
echo "Run this to access the UI:"
echo "kubectl port-forward svc/argocd-server -n argocd 8080:443"  #If added as command in the script, the script will never finish 
