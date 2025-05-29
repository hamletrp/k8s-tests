#!/bin/bash

# =============================
# Install rancher
# =============================

echo "Setting up rancher helm repo"
helm repo add rancher \
    https://releases.rancher.com/server-charts/stable

echo "Updating helm"
helm repo update

echo "Installing rancher"
helm upgrade --install \
    rancher rancher/rancher \
    --namespace cattle-system \
    --create-namespace \
    --set hostname=rancher.itsnotrocketscience.tech \
    # --set ingress.tls.source=letsEncrypt \
    # --set letsEncrypt.email=hamletrp@gmail.com \
    --wait

echo "Applying rancher ingress"
k apply -f ./gitops/rancher/rancher-ingress.yaml

echo
echo "✅ Successfully installed rancher"
echo "Wait til alb is provissioned and update your dns records"
