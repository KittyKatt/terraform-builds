terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.13.1"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      configuration_aliases = [
        kubernetes.lb
      ]
    }
    helm = {
      source = "hashicorp/helm"
      configuration_aliases = [
        helm.lb
      ]
    }
  }
}
