#!/bin/bash

echo "🔄 Restarting Amazon VPC CNI (aws-node)..."
kubectl rollout restart daemonset aws-node -n kube-system

echo "🔄 Restarting CoreDNS..."
kubectl rollout restart deployment coredns -n kube-system

echo "🔄 Restarting Kube Proxy..."
kubectl rollout restart daemonset kube-proxy -n kube-system

echo "✅ Restart requests sent. Monitor with:"
echo "kubectl get pods -n kube-system -w"
