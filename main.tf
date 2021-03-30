terraform {
  backend "remote" {}
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
