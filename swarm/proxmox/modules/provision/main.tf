resource "null_resource" "deploy-swarm" {
  provisioner "local-exec" {
    command = "ANSIBLE_CONFIG=${path.module}/ansible.cfg ansible-playbook -u cephuser -i ${path.module}/inventory.yml ${path.module}/ansible/plays/deploy-swarm.yml"
  }
}

resource "null_resource" "deploy-ceph" {
  depends_on = [resource.null_resource.deploy-swarm]
  provisioner "local-exec" {
    command = "ANSIBLE_CONFIG=${path.module}/ansible.cfg ansible-playbook -u cephuser -i ${path.module}/inventory.yml ${path.module}/ansible/plays/deploy-ceph.yml"
  }
}