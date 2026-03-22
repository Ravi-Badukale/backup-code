variable "routes" {
    type = map(object({
      network_self_link = string
      dest_range = string
      next_hop_type = string
      next_hop_value = string
      priority = number
      tag = optional(list(string))
    }))
}