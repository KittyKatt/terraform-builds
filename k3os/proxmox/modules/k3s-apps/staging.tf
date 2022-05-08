# resource "kubernetes_namespace" "staging" {
#   metadata {
#     name = "staging"
#   }

#   lifecycle {
#     ignore_changes = [
#       metadata[0].annotations,
#       metadata[0].labels
#     ]
#   }

#   depends_on = [
#     helm_release.metallb,
#     helm_release.nginx,
#     helm_release.cert-manager
#   ]
# }


# resource "kubernetes_secret" "cloudflare-api-secret-staging" {
#   metadata {
#     name      = "cloudflare-api-token-secret"
#     namespace = kubernetes_namespace.staging.metadata[0].name
#   }

#   data = {
#     "api-token" = "${var.api_token}"
#   }

#   type = "Opaque"

#   depends_on = [
#     kubernetes_namespace.staging
#   ]
# }

# data "helm_template" "staging-tls" {
#   name      = "staging-tls"
#   chart     = "${path.module}/conf/helm/staging-tls"
#   namespace = kubernetes_namespace.staging.metadata[0].name

#   values = [
#     templatefile(
#       "${path.module}/conf/helm/staging-tls/values.yml",
#       {
#         acme_email    = var.acme_email
#         acme_server   = terraform.workspace != "dev" ? local.letsencrypt_targets.prod : local.letsencrypt_targets.staging
#         dns_zone      = var.domain_name
#         namespace     = kubernetes_namespace.staging.metadata[0].name
#       }
#     )
#   ]
# }

# resource "helm_release" "staging-tls" {
#   name      = data.helm_template.staging-tls.name
#   chart     = data.helm_template.staging-tls.chart
#   namespace = data.helm_template.staging-tls.namespace

#   values = data.helm_template.staging-tls.values

#   wait          = true
#   wait_for_jobs = true

#   # This is a hack to force updates when files in the local helm chart
#   # directory update
#   set {
#     name  = "sourceHash"
#     value = md5(data.helm_template.staging-tls.manifest)
#   }

#   depends_on = [
#     helm_release.cert-manager,
#     helm_release.nginx,
#     helm_release.metallb,
#     kubernetes_secret.cloudflare-api-secret-staging
#   ]
# }

# # resource "helm_release" "hello-kubernetes" {

# #   depends_on = [
# #     helm_release.nginx,
# #     helm_release.metallb,
# #     helm_release.rancher-tls,
# #   ]
# # }