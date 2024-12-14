# Hetzner Cloud network
resource "hcloud_network" "this" {
  count = var.create_network ? 1 : 0

  name     = var.name
  ip_range = var.network_ip_range

  labels = merge(
    { "Name" = var.name },
    var.network_labels,
    var.all_labels,
  )
}
