#!/bin/bash

# =============================
# Patch ebs-csi-controller-sa with IRSA role
# =============================

# === Update these variables ===
# ROLE_ARN="arn:aws:iam::722249351142:role/AmazonEKS_EBS_CSI_DriverRole"
# ROLE_ARN="arn:aws:iam::722249351142:role/AmazonEKS_EBS_CSI_DriverRole-cluster-lab-14"
ROLE_ARN="arn:aws:iam::722249351142:role/AmazonEKS_EBS_CSI_DriverRole-cluster-lab-14"
NAMESPACE="kube-system"
SA_NAME="ebs-csi-controller-sa"

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
# kubectl get serviceaccount ebs-csi-controller-sa -n kube-system -o jsonpath="{.metadata.annotations}"
echo
