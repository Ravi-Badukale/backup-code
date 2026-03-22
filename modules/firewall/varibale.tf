variable "name" {
  type = string
}

variable "network_self_link" {
  type = string
}

variable "direction" {
  type    = string
  default = "INGRESS"
}

variable "priority" {
  type    = number
  default = 1000
}

variable "ranges" {
  type    = list(string)
  default = []
}

variable "target_tags" {
  type    = list(string)
  default = []
}



variable "allow" {
  type = list(object({
    protocol = string
    ports    = optional(list(string))
  }))
}

