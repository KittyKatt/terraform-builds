resource "null_resource" "wait-for-lb-ip" {
  provisioner "local-exec" {
    environment = {
      LB_IP = var.kubeapi_lb_ip
    }
    command     = "while true; do ping -c1 $LB_IP; if [ $? -ne 0 ]; then sleep 5s; else break; fi; done"
    interpreter = [ "bash", "-c" ]
  }

  depends_on = [
    helm_release.kube-karp
  ]
}