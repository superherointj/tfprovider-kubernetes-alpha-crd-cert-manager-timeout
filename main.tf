terraform {
  backend "remote" {
    organization = var.tf_backend_remote_organization
    workspaces {
        name = var.tf_backend_remote_workspace
    }
  }
  required_providers {
    linode = {
      source  = "linode/linode"
    }
    kubernetes-alpha = {
      source = "hashicorp/kubernetes-alpha"
      version = ">= 0.3.2"
    }
  }
}
