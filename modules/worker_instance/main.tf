resource "google_compute_instance" "worker" {
  name         = "${var.instance_name}"
  machine_type = $"{var.machine_type}"
  zone = $"{var.zone}"
  tags = ["kubernetes", "worker"]
  boot_disk {
    initialize_params {
      image = "${ubuntu-os-cloud/ubuntu-1804-lts}"
      size = ${var.boot_disk_size}
    }
  }
  metadata {
    pod-cidr = "10.200.0.0/24"
  }
  network_interface {
  	network = "${google_compute_network.vpc_network.name}"
    network_ip = 10.240.0.20
  }
  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
  can_ip_forward = true
    provisioner "file" {
    source = "../resources/"
    destination = "/etc/systemd/system"
  }
}