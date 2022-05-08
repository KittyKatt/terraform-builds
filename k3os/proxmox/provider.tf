provider "proxmox" {
  pm_tls_insecure = true
  pm_api_url = var.pm_url
  pm_user = var.pm_user
  pm_password = var.pm_password
}
provider "remote" {
  max_sessions = 2
}

provider "kubernetes" {
  alias                  = "lb_bootstrap"
  host                   = module.cluster.control_plane_url
  token                  = module.cluster.k3s_api_token
  cluster_ca_certificate = module.cluster.k3s_ca_cert
}
provider "kubernetes" {
  alias                  = "lb"
  host                   = module.load-balancer.control_plane_url
  token                  = module.cluster.k3s_api_token
  cluster_ca_certificate = module.cluster.k3s_ca_cert
}

provider "helm" {
  alias = "lb_bootstrap"
  kubernetes {
    # config_path            = "${path.root}/kubeconfig"
      host                   = module.cluster.control_plane_url
      token                  = module.cluster.k3s_api_token
      cluster_ca_certificate = module.cluster.k3s_ca_cert
  }
}
provider "helm" {
  alias = "lb"
  kubernetes {
    # config_path            = "${path.root}/kubeconfig"
      host                   = module.load-balancer.control_plane_url
      token                  = module.cluster.k3s_api_token
      cluster_ca_certificate = module.cluster.k3s_ca_cert
  }
}

provider "kubectl" {
  # config_path            = "${path.root}/kubeconfig"
    host                   = module.cluster.control_plane_url
    token                  = module.cluster.k3s_api_token
    cluster_ca_certificate = module.cluster.k3s_ca_cert
}

provider "rancher2" {
  alias = "bootstrap"

  api_url   = "https://rancher.${local.config.domain_name}"
  bootstrap = true
  timeout   = "10m"
  insecure = true
}

provider "rancher2" {
  alias     = "admin"

  api_url   = module.rancher.rancher2_bootstrap.admin.url
  token_key = module.rancher.rancher2_bootstrap.admin.token
  insecure = true
}