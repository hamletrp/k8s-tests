#!/bin/bash

# =============================
# Install argocd
# =============================

echo "Installing argocd"

k create namespace argocd

k apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "exposing argo thru an aws alb ingress"
k apply -f ./gitops/argocd/argocd-ingress-alb.yaml

echo "pwd"
k -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

echo "✅ Successfully installed argo"
