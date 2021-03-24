provider "linode" {
  token = var.linode_token
}

# Inputs

variable "linode_token" {
  description = "Your Linode API Personal Access Token. (required)"
}

variable "k8s_version" {
  description = "The Kubernetes version to use for this cluster. (required)"
  default = "1.20"
}

variable "label" {
  description = "The unique label to assign to this cluster. (required)"
  default = "default-lke-cluster"
}

variable "region" {
  description = "The region where your cluster will be located. (required)"
  default = "us-east"
}

variable "tags" {
  description = "Tags to apply to your cluster for organizational purposes. (optional)"
  type = list(string)
  default = ["testing"]
}

variable "pools" {
  description = "The Node Pool specifications for the Kubernetes cluster. (required)"
  type = list(object({
    type = string
    count = number
  }))
  default = [
    {
      type = "g6-standard-1"
      count = 1
    }
  ]
}

# Implementation

resource "linode_lke_cluster" "timeout_demo_lke" {
    k8s_version = var.k8s_version
    label = var.label
    region = var.region
    tags = var.tags
    dynamic "pool" {
        for_each = var.pools
        content {
            type  = pool.value["type"]
            count = pool.value["count"]
        }
    }
}

# Outputs

output "kubeconfig" {
   value = linode_lke_cluster.timeout_demo_lke.kubeconfig
}

output "api_endpoints" {
   value = linode_lke_cluster.timeout_demo_lke.api_endpoints
}

output "status" {
   value = linode_lke_cluster.timeout_demo_lke.status
}

output "id" {
   value = linode_lke_cluster.timeout_demo_lke.id
}

output "pool" {
   value = linode_lke_cluster.timeout_demo_lke.pool
}
