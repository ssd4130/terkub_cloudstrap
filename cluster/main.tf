resource "google_compute_instance" "default" {
  name         = "controller1"
  machine_type = "n1-standard-1"
  zone         = "us-west1-c"
  tags = ["kubernetes", "controller"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size = 200
    }
  }
  network_interface {
    network = "${google_compute_network.vpc_network.name}"
    network_ip = 10.240.0.11
  }
  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
  can_ip_forward = true
  
}

resource "google_compute_network" "vpc_network" {
  name = "kubernetes-net"
  auto_create_subnetworks = false
}

data "google_compute_subnet" "kubernetes-subnet" {
  name = "kubernetes-subnet"
  region = "us-west1"
  ip_cidr_range = "10.240.0.0/24"
}

resource "google_compute_firewall" "kubernetes-internal" {
  name    = "kuberenetes-internal"
  network = "${google_compute_network.vpc_network.name}"
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  source_ranges = ["10.240.0.0/24","10.200.0.0/16"]
}

resource "google_compute_firewall" "kuberenetes-external" {
  name = "kubernetes-external"
  network = "${google_compute_network.vpc_network.name}"
  allow {
    protocol = "tcp"
    ports = ["22","6443"]
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
}

#resource "google_compute_address" "external_address" {
#  name         = "external_IP"
#  region       = "us-west1"
#}
