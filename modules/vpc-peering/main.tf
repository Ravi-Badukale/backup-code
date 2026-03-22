resource "google_compute_network_peering" "this" {
    name = var.name
    network = var.network_self_link
    peer_network = var.peer_network_self_link
    export_custom_routes = var.export_custom_routes
    import_custom_routes = var.import_custom_routes
}