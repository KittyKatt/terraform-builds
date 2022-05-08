terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    rancher2 = {
      source = "rancher/rancher2"
      configuration_aliases = [
        rancher2.bootstrap,
        rancher2.admin
      ]
    }
  }
}

