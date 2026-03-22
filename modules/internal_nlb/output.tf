output "ip_address" {
    value = google_compute_forwarding_rule.this.ip_address
}

output "self_link" {
    value = google_compute_forwarding_rule.this.self_link
}