# Ceph via Rook - Argo CD GitOps Bundle

This bundle deploys the [Rook Ceph Operator](https://rook.io/) using Argo CD.

## Features

- Rook Ceph Operator installed via Helm chart
- CRDs enabled
- RBD and CephFS CSI drivers configured

## Usage

1. Install Argo CD
2. Apply the Argo Application:

```bash
kubectl apply -f applications/ceph-rook.yaml -n argocd
```

3. Watch the sync in the Argo CD UI or CLI
