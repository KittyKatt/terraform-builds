resource "null_resource" "kubeconfig" {
  depends_on = [ module.k3s_node ]
  # Create
  provisioner "local-exec" {
    command = <<-EOC
      mkdir -p ~/.kubeconfigs; 
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null rancher@${module.k3s_primary.primary_ipv4}:/etc/rancher/k3s/k3s.yaml ~/.kubeconfigs/${var.primary_node_name}-config
      sed -i 's/127.0.0.1/${module.k3s_primary.primary_ipv4}/g' ~/.kubeconfigs/${var.primary_node_name}-config
    EOC
  }
  # Destroy
  provisioner "local-exec" {
    when = destroy
    command = <<-EOD
      rm -rf ~/.kubeconfigs
    EOD
  }
}

resource "local_file" "kubeconfig" {
  depends_on = [ null_resource.kubeconfig ]
  content = file("~/.kubeconfigs/${var.primary_node_name}-config")
  filename = "${path.root}/kubeconfig"
}