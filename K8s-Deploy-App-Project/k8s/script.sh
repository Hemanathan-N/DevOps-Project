#!/bin/bash

# Check Minikube status
STATUS=$(minikube status --format='{{.Host}}' 2>/dev/null)

if [ "$STATUS" = "Running" ]; then
    echo "✅ Minikube is already running. No action needed."
else
    echo "🚀 Minikube is not running. Starting Minikube..."
    minikube start --driver=docker --memory=2048 --cpus=2
fi
