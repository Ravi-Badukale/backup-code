#HC
resource "google_compute_health_check" "this" {
    name = "${var.name}-hc"
    tcp_health_check {
      port = var.health_check_port
    }
}

#Backend Service
resource "google_compute_region_backend_service" "this"{
  name = "${var.name}-backend"
  region = var.region
  protocol = var.ip_protocol
  load_balancing_scheme = "INTERNAL"
  session_affinity = "NONE"

  health_checks = [google_compute_health_check.this.self_link]

  backend {
    group = var.backend_instance_group
    balancing_mode = "CONNECTION"
  }
}

#Forwarding Rule 

resource "google_compute_forwarding_rule" "this"{
  name = var.name
  region = var.region
  load_balancing_scheme = "INTERNAL"
  ip_protocol = var.ip_protocol
  ports                 = var.ports
  backend_service       = google_compute_region_backend_service.this.id

  network = var.network
  subnetwork = var.subnetwork
}
