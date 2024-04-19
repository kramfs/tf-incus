#############
## PROFILE ##
#############
resource "incus_profile" "tf-profile" {
  count = var.profile.install ? 1 : 0
  name = "tf-profile"

  ## Reference: https://linuxcontainers.org/incus/docs/main/reference/instance_options/
  config = {
    #  "limits.cpu" = 2
    "security.secureboot" = false
  }

  device {
    name = "eth0"
    type = "nic"

    properties = {
      nictype = "bridged"
      #parent  = "${incus_network.tf-network.name}"
      parent = "incusbr0" # Default bridged network
    }
  }

  device {
    type = "disk"
    name = "root"

    properties = {
      pool = "incus"
      path = "/"
      size = "30GiB"
    }
  }
}