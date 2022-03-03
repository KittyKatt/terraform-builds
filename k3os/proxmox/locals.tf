locals {
  environments = {
    # Terraform Default Workspace
    default = {
      domain_name = "kittykatt.co"
      proxmox_hosts = [
        "toril",
        "abeir"
      ]
      node_configs = [
        {
          name    = "moradin"
          macaddr = [ "ce:59:af:c2:b1:f4" ]
          cpu_n   = "2"
          mem_n   = "4096"
          primary = true
        },
        {
          name    = "dumathoin"
          macaddr = [ "de:0c:63:e9:df:bb" ]
          cpu_n   = "2"
          mem_n   = "4096"
        },
        {
          name    = "abbathor"
          macaddr = [ "90:24:52:8f:68:b7" ]
          cpu_n   = "2"
          mem_n   = "4096"
        }
      ]
      ip_range_lower_boundary = "10.32.100.11"
      ip_range_upper_boundary = "10.32.100.15"
    },
    # Terraform Workspace: "dev"
    dev = {
      domain_name = "kittykatt.co"
      proxmox_hosts = [
        "toril",
        "abeir"
      ]
      node_configs = [
        {
          name    = "k3s-dev1"
          macaddr = [ "9e:fd:19:d3:15:8f" ]
          cpu_n   = "2"
          mem_n   = "4096"
          primary = true
        },
        {
          name    = "k3s-dev2"
          macaddr = [ "d6:d7:a1:19:6c:4f" ]
          cpu_n   = "2"
          mem_n   = "4096"
        },
        {
          name    = "k3s-dev3"
          macaddr = [ "b6:57:fa:a1:48:55" ]
          cpu_n   = "2"
          mem_n   = "4096"
        }
      ]
      ip_range_lower_boundary = "10.32.100.21"
      ip_range_upper_boundary = "10.32.100.25"
    }
  }
}

locals {
  config = "${lookup(local.environments, terraform.workspace, local.environments["default"])}"
}