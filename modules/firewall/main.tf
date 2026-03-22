resource "google_compute_firewall" "this" {
  name      = var.name
  network   = var.network_self_link
  direction = var.direction
  priority  = var.priority

  source_ranges      = var.direction == "INGRESS" ? var.ranges : null
  destination_ranges = var.direction == "EGRESS"  ? var.ranges : null

  target_tags              = length(var.target_tags) > 0 ? var.target_tags : null
  #target_service_accounts  = length(var.target_service_accounts) > 0 ? var.target_service_accounts : null

  dynamic "allow" {
    for_each = var.allow
    content {
      protocol = allow.value.protocol
      ports    = lookup(allow.value, "ports", null)
    }
  }

}