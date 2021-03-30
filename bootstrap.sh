#!/bin/sh
echo "credentials \"app.terraform.io\" { token = \"$TF_TOKEN\" }" >> terraform.rc
export TF_CLI_CONFIG_FILE=terraform.rc
export TF_LOG=TRACE; export TF_LOG_PATH=tf-timeout-demo.log
TF_LOG_PATH=tf-init.log terraform init
TF_LOG_PATH=tf-lke_cluster.log terraform apply -auto-approve -target linode_lke_cluster.timeout_demo_lke
TF_LOG_PATH=tf-kubeconfig.log terraform output kubeconfig | sed -e 's/^"//' -e 's/"$//' | base64 -d > kubeconfig.yaml
TF_LOG_PATH=tf-apply.log terraform apply -auto-approve
