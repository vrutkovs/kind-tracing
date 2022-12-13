#!/bin/bash
set -eux

kind create cluster --config=./config.yaml
kubectl apply -f grafana-agent
kubectl get nodes
