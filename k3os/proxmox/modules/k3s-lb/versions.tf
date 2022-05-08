terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      configuration_aliases = [
        helm.lb_bootstrap,
        helm.lb
      ]
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      configuration_aliases = [
        kubernetes.lb_bootstrap,
        kubernetes.lb
      ]
    }
  }
}
