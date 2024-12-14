variable "create_network" {
  description = "Controls if network should be created (affects all resources)"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "network_ip_range" {
  description = "The IPv4 range of the entire network in CIDR notation"
  type        = string
}

variable "network_subnets" {
  description = "Nested map of subnets to create"
  type        = map(map(object({
    cidr         = string
    network_zone = string
  })))
  default     = {}
}

variable "all_labels" {
  description = "A map of labels to add to all resources"
  type        = map(string)
  default     = {}
}

variable "network_labels" {
  description = "Additional labels for the network"
  type        = map(string)
  default     = {}
}
