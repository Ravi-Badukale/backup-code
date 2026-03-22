resource "google_compute_instance_group" "this" {
  name = var.name
  zone = var.zone
  instances = var.instances

  named_port {
    name = "http"
    port = 80
  }
}


