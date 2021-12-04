module "configuration" {
  source         = "../config"
  name           = var.name
  manager        = var.manager ? true : false
  network_config = var.network_config
  mount_config   = var.mount_config
  ssh_ids        = var.ssh_ids
  ssh_keys       = var.ssh_keys
  smbuser        = var.smbusername
  smbpass        = var.smbpassword
  smbdomain      = var.smbdomain
  pve_user       = var.pve_user
  pve_host       = var.pve_host
  pve_password   = var.pve_password
}