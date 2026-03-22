output "route_names" {
  value = keys(google_compute_route.this)
}

