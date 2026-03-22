output "tunnel_name" {
    value = google_compute_vpn_gateway.this.name
  
}

output "tunnel1" {
    value = google_compute_vpn_tunnel.this.self_link
}

output "tunnel2" {
    value = google_compute_vpn_tunnel.peer.self_link
  
}