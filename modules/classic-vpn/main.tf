#Ip for local
resource "google_compute_address" "this" {
    name = "${var.name}-ip"
    region = var.region
}

#IP for peer
resource "google_compute_address" "peer" {
    name = "${var.name}-peer-ip"
    region = var.region
}

#Gateway VPC1
resource "google_compute_vpn_gateway" "this" {
  name = "${var.name}-gw"
  network = var.network_self_link
  region = var.region
}

#Gateway VPC3
resource "google_compute_vpn_gateway" "peer" {
  name = "${var.name}-peer-gw"
  network = var.peer_network_self_link
  region = var.region
}

#FR for local: 

resource "google_compute_forwarding_rule" "esp" {
  name = "${var.name}-esp"
  region = var.region
  ip_protocol = "ESP"
  ip_address = google_compute_address.this.address
  target = google_compute_vpn_gateway.this.id
  }

resource "google_compute_forwarding_rule" "udp500" {
  name = "${var.name}-udp500"
  region = var.region
  ip_protocol = "UDP"
  port_range = "500"
  ip_address = google_compute_address.this.address
  target = google_compute_vpn_gateway.this.id
  }

resource "google_compute_forwarding_rule" "udp4500" {
  name = "${var.name}-udp4500"
  region = var.region
  ip_protocol = "UDP"
  port_range = "4500"
  ip_address = google_compute_address.this.address
  target = google_compute_vpn_gateway.this.id
  }

#FR for peer:

resource "google_compute_forwarding_rule" "esp-peer" {
  name = "${var.name}-esp-peer"
  region = var.region
  ip_protocol = "ESP"
  ip_address = google_compute_address.peer.address
  target = google_compute_vpn_gateway.peer.id
  }

resource "google_compute_forwarding_rule" "udp500-peer" {
  name = "${var.name}-udp500-peer"
  region = var.region
  ip_protocol = "UDP"
  port_range = "500"
  ip_address = google_compute_address.peer.address
  target = google_compute_vpn_gateway.peer.id
  }

resource "google_compute_forwarding_rule" "udp4500-peer" {
  name = "${var.name}-udp4500-peer"
  region = var.region
  ip_protocol = "UDP"
  port_range = "4500"
  ip_address = google_compute_address.peer.address
  target = google_compute_vpn_gateway.peer.id
  }



#Tunnel :
resource "google_compute_vpn_tunnel" "this" {
  name = "${var.name}-tunnel1"
  region = var.region
  target_vpn_gateway = google_compute_vpn_gateway.this.id
  peer_external_gateway = google_compute_vpn_gateway.peer.id
  peer_ip = google_compute_address.peer.address

 shared_secret = var.shared_secret

 local_traffic_selector = var.local_subnet_cidrs
 remote_traffic_selector = var.remote_subnet_cidrs
 ike_version = 2
}

resource "google_compute_vpn_tunnel" "peer" {
  name = "${var.name}-tunnel2"
  region = var.region
  target_vpn_gateway = google_compute_vpn_gateway.peer.id
  peer_external_gateway = google_compute_vpn_gateway.this.id
  peer_ip = google_compute_address.this.address


 shared_secret = var.shared_secret

 local_traffic_selector = var.remote_subnet_cidrs
 remote_traffic_selector = var.local_subnet_cidrs
 ike_version = 2
}