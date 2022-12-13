#!/bin/bash
set -eux

# Run local registry
if [ "$(podman inspect -f '{{.State.Running}}' "kind-registry" 2>/dev/null || true)" != 'true' ]; then
  podman run \
    -d --restart=always \
    -p "127.0.0.1:5001:5000" \
    --name "kind-registry" \
    --network kind \
    registry:2
fi

# Build custom images
podman build -t localhost:5001/custom:kubeapi custom-kubeapi
podman push localhost:5001/custom:kubeapi --tls-verify=false
podman build -t localhost:5001/custom:kubelet custom-node
podman push localhost:5001/custom:kubelet --tls-verify=false

# Run kind cluster
kind create cluster --config=./config.yaml
kubectl apply -f grafana-agent
kubectl get nodes
