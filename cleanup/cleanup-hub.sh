#!/bin/bash

echo "########## clean up hub crds ...."
kubectl get crds | grep submariner | awk '{print $1}' | xargs kubectl delete crds

kubectl delete crds serviceimports.multicluster.x-k8s.io

kubectl get crds | grep hive | awk '{print $1}' | xargs kubectl delete crds

kubectl delete crds observatoria.core.observatorium.io

kubectl get crds | grep open-cluster-management | awk '{print $1}' | xargs kubectl delete crds

echo "##########  patch local-cluster"
kubectl get roles -n local-cluster | grep -v NAME | awk '{print $1}' | xargs kubectl -n local-cluster patch roles -p '{"metadata":{"finalizers": []}}' --type=merge
kubectl get rolebindings -n local-cluster | grep -v NAME | awk '{print $1}' | xargs kubectl -n local-cluster patch rolebindings -p '{"metadata":{"finalizers": []}}' --type=merge

echo "########## patch managedclustersets"
kubectl get managedclustersets | grep -v NAME | awk '{print $1}' | xargs kubectl patch managedclustersets -p '{"metadata":{"finalizers": []}}' --type=merge
