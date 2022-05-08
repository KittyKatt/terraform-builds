data "helm_template" "kube-karp" {
  name      = "kube-karp"
  chart     = "${path.module}/conf/helm/kube-karp"
  namespace = "kube-karp"

  values = [
    templatefile(
      "${path.module}/conf/helm/kube-karp/values.yaml",
      {
        lb_ip = var.kubeapi_lb_ip
      }
    )
  ]
}

resource "helm_release" "kube-karp" {
  name      = data.helm_template.kube-karp.name
  chart     = data.helm_template.kube-karp.chart
  namespace = data.helm_template.kube-karp.namespace

  values = data.helm_template.kube-karp.values

  wait             = true
  wait_for_jobs    = true
  create_namespace = true

  # This is a hack to force updates when files in the local helm chart
  # directory update
  set {
    name  = "sourceHash"
    value = md5(data.helm_template.kube-karp.manifest)
  }

  provider = helm.lb_bootstrap

  depends_on = [
    var.k3s_control_plane_created
  ]
}