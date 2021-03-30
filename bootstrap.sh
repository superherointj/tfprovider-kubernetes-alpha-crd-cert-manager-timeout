#!/bin/sh

echo "credentials \"app.terraform.io\" { token = \"$TF_TOKEN\" }" >> terraform.rc

# Ugly hack to glue Organization & Workspace to main.tf without hardcoding it to file 
#  (that is a problem to Docker that downloads sources from git repo).
#    I ask forgiveness for my ignorance of method of how I should be doing this!
echo "terraform {
  backend \"remote\" {
    organization = \"$TF_ORGANIZATION\"
    workspaces {
        name = \"$TF_WORKSPACE\"
    }
  }
  required_providers {
    linode = {
      source  = \"linode/linode\"
    }
    kubernetes-alpha = {
      source = \"hashicorp/kubernetes-alpha\"
      version = \">= 0.3.2\"
    }
  }
}"  > main.tf;

export TF_CLI_CONFIG_FILE=terraform.rc

export TF_LOG=TRACE; export TF_LOG_PATH=tf-timeout-demo.log

TF_LOG_PATH=tf-init.log terraform init

TF_LOG_PATH=tf-lke_cluster.log terraform apply -auto-approve -target linode_lke_cluster.
timeout_demo_lke

TF_LOG_PATH=tf-kubeconfig.log terraform output kubeconfig | sed -e 's/^"//' -e 's/"$//' | base64 -d > kubeconfig.yaml

TF_LOG_PATH=tf-apply.log terraform apply -auto-approve
