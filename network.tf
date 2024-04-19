## NETWORK ##
resource "incus_network" "tf-network" {
  count = var.network.install ? 1 : 0
  name  = var.network.name

  config = {
    "ipv4.address" = var.network.config.ipv4_address
    "ipv4.nat"     = var.network.config.ipv4_nat
    #"ipv6.address" = var.network.config.ipv6_address
    #"ipv6.nat"     = var.network.config.ipv6_nat
  }
}