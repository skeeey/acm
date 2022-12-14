#!/bin/bash

retry="5"
cluster="$1"

kubeconfigfile="$(cat kubeconfig_path)"

server=""
token=""

kubectl -n $cluster create secret generic auto-import-secret \
    --from-literal=autoImportRetry=$retry \
    --from-file=kubeconfig=$kubeconfigfile
kubectl annotate -n $cluster secret auto-import-secret managedcluster-import-controller.open-cluster-management.io/keeping-auto-import-secret=true --overwrite

# kubectl -n $cluster create secret generic auto-import-secret \
#     --from-literal=autoImportRetry=5 \
#     --from-literal=server=$server \
#     --from-literal=token=$token

#kubectl label -n $cluster secret auto-import-secret cluster.open-cluster-management.io/restore-auto-import-secret=true --overwrite
