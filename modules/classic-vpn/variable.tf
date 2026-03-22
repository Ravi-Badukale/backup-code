variable "name" {
}

variable "region" {
}
variable "network_self_link" {
}

variable "peer_network_self_link" {
}

variable "shared_secret" {
    sensitive = true
}

variable "local_subnet_cidrs" {
}

variable "remote_subnet_cidrs" {
}