#!/bin/bash

# =============================
# Patch aws-node with IRSA role
# =============================

# === Update these variables ===
ROLE_ARN="arn:aws:iam::722249351142:role/eksctl-cluster-lab-14-nodegroup-linu-NodeInstanceRole"
NAMESPACE="kube-system"
SA_NAME="aws-node"

# === Confirm intent ===
echo "Patching service account '$SA_NAME' in namespace '$NAMESPACE' with IAM role:"
echo "$ROLE_ARN"
echo

# === Patch the service account ===
kubectl annotate serviceaccount \
  "$SA_NAME" \
  -n "$NAMESPACE" \
  eks.amazonaws.com/role-arn="$ROLE_ARN" \
  --overwrite

# === Verify ===
echo
echo "✅ Patched successfully. Current service account annotation:"
kubectl get serviceaccount "$SA_NAME" -n "$NAMESPACE" -o jsonpath="{.metadata.annotations}"
echo
