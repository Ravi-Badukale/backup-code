resource "google_compute_subnetwork" "this" {
  name          = var.name
  ip_cidr_range = var.cidr
  region        = var.region
  network       = var.vpc_self_link

  
log_config {
    aggregation_interval = "INTERVAL_5_MIN"       
    flow_sampling        = 1.0                    
    metadata             = "INCLUDE_ALL_METADATA" 
  }
}
