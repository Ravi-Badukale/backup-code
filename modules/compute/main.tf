resource "google_compute_instance" "this" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = var.subnet_self_link

    dynamic "access_config" {
      for_each = var.public_ip ? [1] : []
      content {}
    }
  }
  metadata_startup_script = (
    var.startup_script_path != null
    ? file(var.startup_script_path)
    : null
  )
}