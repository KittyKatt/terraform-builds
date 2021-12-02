module "configuration" {
  source         = "../config"
  name           = var.name
  manager        = var.manager ? true : false
  network_config = local.network
  mount_config   = local.mounts
  ssh_ids        = local.ssh_id
  ssh_keys       = local.ssh_key
  smbuser        = var.smbusername
  smbpass        = var.smbpassword
  smbdomain      = var.smbdomain
  pve_user       = var.pve_user
  pve_host       = var.pve_host
  pve_password   = var.pve_password
}