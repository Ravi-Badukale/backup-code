variable "name" {}
variable "machine_type" {}
variable "zone" {}
variable "subnet_self_link" {}

variable "public_ip" {
  type    = bool
  default = true
}

variable "startup_script_path" {
  type    = string
  default = null
}