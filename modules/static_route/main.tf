resource "google_compute_route" "this" {
    for_each = var.routes

    name = each.key
    network = each.value.network_self_link
    dest_range = each.value.dest_range
    priority = each.value.priority
    
    
    tags = lookup(each.value, "tag", null)

    next_hop_vpn_tunnel = each.value.next_hop_type == "vpn_tunnel" ? each.value.next_hop_value : null
    next_hop_gateway = each.value.next_hop_type == "gateway" ? each.value.next_hop_value : null
    next_hop_instance = each.value.next_hop_type == "instance" ? each.value.next_hop_value : null
    next_hop_ip = each.value.next_hop_type == "ip" ? each.value.next_hop_value : null
}