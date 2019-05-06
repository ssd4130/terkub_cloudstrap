provider "gcp" {
  project = ""
  region = "${vars.region}"
  zone = ""
}

module "google_compute_instance" {
  source = "../modules/controller_instance"
}

module "google_compute_instance" {
  source = "../modules/controller_instance"
}

module "google_compute_instance" {
  source = "../modules/controller_instance"
}

module "google_compute_instance" {
  source = "../modules/worker_instance"
}

module "google_compute_instance" {
  source = "../modules/worker_instance"
}

module "google_compute_instance" {
  source = "../modules/worker_instance"
}




----------------------------------------------------------

resource "google_compute_instance" "controller" {
  network_interface {
    network = "${google_compute_network.vpc_network.name}"
    network_ip = 10.240.0.11
  }
  
  provisioner "file" {
    source = ""
    destination = "/etc/systemd/system"
  }
  provisioner "file" {
    source      = ""
    destination = "/etc/etcd"
   }
  provisioner "file" {
    source      = ""
    destination = "/etc/etcd"
  }
  provisioner "file" {
    source      = ""
    destination = "/etc/etcd"
  }
  provisioner "file" {
    source = ""
    destination = "/var/lib/kubernetes/"
  }
  provisioner "file" {
    source = ""
    destination = "/var/lib/kubernetes/"
  }
  provisioner "file" {
    source = ""
    destination = "/var/lib/kubernetes/"
  }
  provisioner "file" {
    source = ""
    destination = "/var/lib/kubernetes/"
  }
  provisioner "file" {
    source = ""
    destination = "/var/lib/kubernetes/"
  }
  provisioner "file" {
    source = ""
    destination = "/var/lib/kubernetes/"
  }
  provisioner "file" {
    source = ""
    destination = "/var/lib/kubernetes/"
  }
  provisioner "file" {
    source = ""
    destination = "/etc/systemd/system/"
  }
  provisioner "remote-exec" {
    inline = ["sudo systemctl daemon-reload","sudo systemctl enable etcd","sudo systemctl start etcd"]
  }
  provisioner "file" {
    source = ""
    destination = "/var/lib/kubernetes/"
  }
  provisioner "file" {
    source = ""
    destination = "/"
  }
}`

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
# Need to reserve IP for External Load balancer?
#resource "google_compute_address" "external_address" {
#  name         = "external_IP"
#  region       = "us-west1"
#}