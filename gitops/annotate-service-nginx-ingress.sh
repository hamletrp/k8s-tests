#!/bin/bash

# =============================
# annotate nginx service to set aws cert arn
# =============================

# === Update these variables ===
NAMESPACE="ingress-nginx"
SVC_NAME="nginx-ingress-ingress-nginx-controller"
CERT_ARN="arn:aws:acm:us-east-1:722249351142:certificate/3887c32b-9317-44ff-b2e0-10de121e1062"


# === Confirm intent ===
echo "Patching service '$SVC_NAME' in namespace '$NAMESPACE' with CERT ARN:"
echo "$CERT_ARN"
echo

# === Patch the service ===
kubectl annotate service \
  "$SVC_NAME" \
  -n "$NAMESPACE" \
  service.beta.kubernetes.io/aws-load-balancer-scheme=internet-facing \
  service.beta.kubernetes.io/aws-load-balancer-nlb-target-type="ip" \
  service.beta.kubernetes.io/aws-load-balancer-type="external" \
  service.beta.kubernetes.io/aws-load-balancer-ssl-cert="$CERT_ARN" \
  service.beta.kubernetes.io/aws-load-balancer-ssl-ports="443" \
  --overwrite

# === Verify ===
echo
echo "✅ Patched successfully. Current service annotation:"
kubectl get service "$SVC_NAME" -n "$NAMESPACE" -o jsonpath="{.metadata.annotations}"
echo
