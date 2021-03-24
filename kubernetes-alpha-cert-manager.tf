provider "kubernetes-alpha" {
  config_path = "./kubeconfig.yaml"
}

module "cert-manager" {
  source  = "aareet/cert-manager/kubernetes"
  version = "0.0.2"
}
