provider "gcp" {
  region = "${vars.region}"
}

module "google_compute_instance" {
  source = "../modules/controller_instance"
}




----------------------------------------------------------

resource "google_compute_instance" "controller" {
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
		"export ETCD_NAME="$(hostname -s)"",
		"export INTERNAL_IP="$(curl -s -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/ip)"",
    "sudo mkdir -p /etc/kubernetes/config",
    "wget -q --show-progress --https-only --timestamping "https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kube-apiserver" "https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kube-controller-manager" "https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kube-scheduler" "https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kubectl",
    "chmod +x kube-apiserver kube-controller-manager kube-scheduler kubectl",
    "sudo mv kube-apiserver kube-controller-manager kube-scheduler kubectl /usr/local/bin/",
    "sudo mkdir -p /var/lib/kubernetes/",]
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