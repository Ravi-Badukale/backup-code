variable "name" {
}
variable "region" { 
}
variable "network" {
}
variable "subnetwork" {
}
variable "ip_protocol" {
}
variable "ports" {
  type = list(string)
}
variable "backend_instance_group" {
}
variable "health_check_port" {
    type = number
}