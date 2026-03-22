#health check
resource "google_compute_http_health_check" "this" {
  name = "${var.name}-hc"
  request_path = "/"
  port = 80
}

#backend service 
resource "google_compute_backend_service" "this" {
    name = "${var.name}-backend"
    protocol = "HTTP"
    load_balancing_scheme = "EXTERNAL"
    health_checks = [google_compute_http_health_check.this.self_link]

    backend {
      group = var.backend_instance_group
    }
  
}

#URL map
resource "google_compute_url_map" "this" {
    name = "${var.name}-url-map"
    default_service = google_compute_backend_service.this.self_link  
}

#HTTP proxy
resource "google_compute_target_http_proxy" "this" {
    name = "${var.name}-proxy"
    url_map = google_compute_url_map.this.self_link
}

# Global IP Address for the load balancer
resource "google_compute_global_address" "this" {
  name = "${var.name}-ip"
}

#Forwarding Rule 
resource "google_compute_global_forwarding_rule" "this" {
    name = "${var.name}-fwd-rule"
    port_range = "80"
    target = google_compute_target_http_proxy.this.self_link
    ip_address = google_compute_global_address.this.address
}