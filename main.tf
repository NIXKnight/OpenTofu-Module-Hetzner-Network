# Process subnets into a flat list
locals {
  processed_subnets = flatten([
    for namespace, subnets in var.network_subnets : [
      for subnet_key, subnet in subnets : {
        namespace    = namespace
        key          = subnet_key
        cidr         = subnet.cidr
        network_zone = subnet.network_zone
      }
    ]
  ])
}

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

# Create subnets from processed list
resource "hcloud_network_subnet" "this" {
  for_each = { for subnet in local.processed_subnets : "${subnet.namespace}-${subnet.key}" => subnet }

  network_id   = hcloud_network.this[0].id
  type         = "cloud"
  network_zone = each.value.network_zone
  ip_range     = each.value.cidr
}
