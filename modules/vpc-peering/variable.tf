variable "name" {
}

variable "network_self_link" {
}

variable "peer_network_self_link" {
}

variable "export_custom_routes" {
    type = bool
    default = false
}

variable "import_custom_routes" {
    type = bool
    default = false
}
