resource "helm_release" "metallb" {
  name             = "metallb-latest"
  repository       = "https://metallb.github.io/metallb"
  chart            = "metallb"
  #version         = "6.0.1"
  namespace        = "metallb-system"
  create_namespace = true

  values = [
    "${file("${path.module}/values/metallb.yml")}"
  ]
}