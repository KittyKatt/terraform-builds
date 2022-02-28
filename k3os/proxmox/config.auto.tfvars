domain_name = "kittykatt.co"
proxmox_hosts = [
  "toril",
  "abeir"
]
node_configs = {
  moradin = {
    name    = "moradin"
    macaddr = [ "ce:59:af:c2:b1:f4", "9e:fd:19:d3:15:8f" ]
    cpu_n   = "2"
    mem_n   = "2048"
  },
  dumathoin = {
    name    = "dumathoin"
    macaddr = [ "de:0c:63:e9:df:bb", "d6:d7:a1:19:6c:4f" ]
    cpu_n   = "2"
    mem_n   = "2048"
  },
  abbathor = {
    name    = "abbathor"
    macaddr = [ "90:24:52:8f:68:b7", "b6:57:fa:a1:48:55" ]
    cpu_n   = "2"
    mem_n   = "2048"
  }
}
primary_node_name       = "moradin"
node_names              = [ "dumathoin", "abbathor" ]
ip_range_lower_boundary = "10.32.100.11"
ip_range_upper_boundary = "10.32.100.15"