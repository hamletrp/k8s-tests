#!/bin/bash

VOLUME_ID=$1
PVC_NAME=$2
NAMESPACE=${3:-default}

if [ -z "$VOLUME_ID" ] || [ -z "$PVC_NAME" ]; then
  echo "Usage: $0 <volume-id> <pvc-name> [namespace]"
  exit 1
fi

echo "Watching deletion of:"
echo "- PVC: $PVC_NAME (namespace: $NAMESPACE)"
echo "- PV and EBS Volume: $VOLUME_ID"
echo ""

while true; do
  PVC_STATUS=$(kubectl get pvc "$PVC_NAME" -n "$NAMESPACE" --no-headers 2>/dev/null)
  PV_NAME=$(kubectl get pvc "$PVC_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.volumeName}' 2>/dev/null)

  if [ -z "$PVC_STATUS" ]; then
    echo "✅ PVC $PVC_NAME deleted"
  else
    echo "$(date): PVC still exists..."
  fi

  if [ -n "$PV_NAME" ]; then
    PV_EXISTS=$(kubectl get pv "$PV_NAME" --no-headers 2>/dev/null)
    if [ -z "$PV_EXISTS" ]; then
      echo "✅ PV $PV_NAME deleted"
    else
      echo "$(date): PV $PV_NAME still exists..."
    fi
  fi

  aws ec2 describe-volumes --volume-ids "$VOLUME_ID" > /dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo "✅ EBS Volume $VOLUME_ID deleted"
    break
  else
    echo "$(date): EBS Volume $VOLUME_ID still exists..."
  fi

  echo "-----"
  sleep 5
done
