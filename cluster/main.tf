resource "google_compute_instance" "controller" {
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
  provisioner "remote-exec" {
	inline = [
		"wget -q --show-progress --https-only --timestamping "https://github.com/coreos/etcd/releases/download/v3.3.9/etcd-v3.3.9-linux-amd64.tar.gz"",
		"tar -xvf etcd-v3.3.9-linux-amd64.tar.gz",
		"sudo mv etcd-v3.3.9-linux-amd64/etcd* /usr/local/bin/",
		"sudo mkdir -p /etc/etcd /var/lib/etcd",
		"sudo cp ca.pem kubernetes-key.pem kubernetes.pem /etc/etcd/",
		"export ETCD_NAME=$(hostname -s)",
}

resource "google_compute_instance" "controller" {
  name         = "controller2"
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
    network_ip = 10.240.0.12
  }
  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
  can_ip_forward = true
}

resource "google_compute_instance" "controller" {
  name         = "controller3"
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
    network_ip = 10.240.0.13
  }
  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
  can_ip_forward = true
}

resource "google_compute_instance" "worker" {
  name         = "worker1"
  machine_type = "n1-standard-1"
  zone         = "us-west1-c"
  tags = ["kubernetes", "controller"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size = 200
    }
  }
  metadata {
    pod-cidr = "10.200.1.0/24"
  }
  network_interface {
    network = "${google_compute_network.vpc_network.name}"
    network_ip = 10.240.0.21
  }
  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
  can_ip_forward = true
}

resource "google_compute_instance" "worker" {
  name         = "worker2"
  machine_type = "n1-standard-1"
  zone         = "us-west1-c"
  tags = ["kubernetes", "controller"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size = 200
      }
  }
  metadata {
    pod-cidr = "10.200.2.0/24"
  }
  network_interface {
    network = "${google_compute_network.vpc_network.name}"
    network_ip = 10.240.0.22
  }
  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
  can_ip_forward = true
}

resource "google_compute_instance" "worker" {
  name         = "worker3"
  machine_type = "n1-standard-1"
  zone         = "us-west1-c"
  tags = ["kubernetes", "controller"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size = 200
    }
  }
  metadata{
   pod-cidr = "10.240.3.0/24"
 }
  network_interface {
    network = "${google_compute_network.vpc_network.name}"
    network_ip = 10.240.0.23
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

#@TODO:
# Configure .ssh keys for instances

# Need to reserve IP for External Load balancer?
#resource "google_compute_address" "external_address" {
#  name         = "external_IP"
#  region       = "us-west1"
#}
