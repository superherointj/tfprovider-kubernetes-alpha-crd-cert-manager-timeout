terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    workspaces {
      name = "timeout_demo_lke"
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
