resource "google_compute_router" "this" {
    name = "${var.vpc_name}-router-${var.region}"
    network = var.network_self_link
    region = var.region
}

resource "google_compute_router_nat" "this" {
    name = "${var.vpc_name}-nat-${var.region}"
    router = google_compute_router.this.name
    region = var.region
    nat_ip_allocate_option = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

    log_config {
        enable = true
        filter = "ERRORS_ONLY"
    }
}