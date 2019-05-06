resource "google_compute_instance" "controller" {
  name         = 
  machine_type = $"{var.machine_type}"
  zone = $"{var.zone}"
  tags = ["kubernetes", "controller"]
  boot_disk {
    initialize_params {
      image = "${ubuntu-os-cloud/ubuntu-1804-lts}"
      size = ${var.boot_disk_size}
    }
  }
  network_interface {
  	
  }
  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
}