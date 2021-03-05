#!/usr/bin/env bash
set -euo pipefail

CONTROLLER_PUBLIC=$1
CONTROLLER_PRIVATE=$2

ADMIN_KUBECONFIG=$(ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@$CONTROLLER_PUBLIC "cat /etc/kubernetes/admin.conf | sed 's/$CONTROLLER_PRIVATE/$CONTROLLER_PUBLIC/' | base64")

jq -n --arg admin_kubeconfig "$ADMIN_KUBECONFIG" '{"admin_kubeconfig":$admin_kubeconfig}'
