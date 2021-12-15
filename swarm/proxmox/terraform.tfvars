network_config = {
    config      = "static"
    gateway     = "10.1.10.1"
    subnet      = "24"
    nameservers = ["10.1.10.59", "10.1.10.1"]
    domain      = "kittykatt.co"
    ceph_subnet = "28"
  }
mount_config = [
    {
      source      = "//10.1.10.46/Infrastructure"
      destination = "/shares/Infrastructure"
      type        = "cifs"
      options     = "credentials=/root/smb-creds,uid=1083,gid=1082,vers=3.0,mfsymlinks"
    },
    {
      source      = "10.1.10.46:/export/DockerVol"
      destination = "/shares/Docker"
      type        = "nfs4"
      options     = "rw,sync,vers=4.2,relatime,hard,proto=tcp"
    },
    {
      source      = "//10.1.10.46/Media"
      destination = "/shares/Media"
      type        = "cifs"
      options     = "credentials=/root/smb-creds,uid=1083,gid=1082,vers=3.0,mfsymlinks"
    }
  ]