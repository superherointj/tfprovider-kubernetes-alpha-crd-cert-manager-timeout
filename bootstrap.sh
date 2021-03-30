#!/bin/sh

# Define correct log folder path.
LOG_FOLDER="logs/local/"

if [[ -f /.dockerenv ]]; then
  LOG_FOLDER="logs/docker/"
fi

if [[ ! -z $IN_NIX_SHELL ]]; then
  LOG_FOLDER="logs/nix/"
fi

echo $LOG_FOLDER

# mkdir -p $LOG_FOLDER

# echo "credentials \"app.terraform.io\" { token = \"$TF_TOKEN\" }" > terraform.rc

# # Hack to glue Organization & Workspace to main.tf without hardcoding it to file 
# #  (matters because Dockerfile downloads sources from git repo)
# echo "organization = \"$TF_ORGANIZATION\"" > backend.hcl

# export TF_CLI_CONFIG_FILE=terraform.rc

# export TF_LOG=TRACE; export TF_LOG_PATH=${LOG_FOLDER}tf-timeout-demo.log

# TF_LOG_PATH=${LOG_FOLDER}tf-0-init.log terraform init -backend-config=backend.hcl

# TF_LOG_PATH=${LOG_FOLDER}tf-1-lke_cluster.log terraform apply -auto-approve -target linode_lke_cluster.timeout_demo_lke

# TF_LOG_PATH=${LOG_FOLDER}tf-2-kubeconfig.log terraform output kubeconfig | sed -e 's/^"//' -e 's/"$//' | base64 -d > kubeconfig.yaml

# TF_LOG_PATH=${LOG_FOLDER}tf-3-apply.log terraform apply -auto-approve
