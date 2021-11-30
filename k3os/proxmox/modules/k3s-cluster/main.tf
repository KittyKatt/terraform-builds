locals {
  qemu_guest_agent = {
    path    = "/etc/conf.d/qemu-guest-agent"
    content = "GAPATH='/dev/vport1p1'"
  }
}