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
  	network = "${google_compute_network.vpc_network.name}"
    network_ip = 10.240.0.11
  }
  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
  can_ip_forward = true
    provisioner "file" {
    source = "../resources/"
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
  provisioner "file" {
    source = ""
    destination = "/var/lib/kubernetes/"
  }
  provisioner "file" {
    source = ""
    destination = "/"
  }
  provisioner "remote-exec" {
	inline = [
		"wget -q --show-progress --https-only --timestamping "https://github.com/coreos/etcd/releases/download/v3.3.9/etcd-v3.3.9-linux-amd64.tar.gz"",
		"tar -xvf etcd-v3.3.9-linux-amd64.tar.gz",
		"sudo mv etcd-v3.3.9-linux-amd64/etcd* /usr/local/bin/",
		"sudo mkdir -p /etc/etcd /var/lib/etcd /etc/kubernetes/config /var/lib/kubernetes/",
		"export ETCD_NAME="$(hostname -s)"",
		"export INTERNAL_IP="$(curl -s -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/ip)"",
	    "wget -q --show-progress --https-only --timestamping "https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kube-apiserver" "https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kube-controller-manager" "https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kube-scheduler" "https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kubectl",
	    "chmod +x kube-apiserver kube-controller-manager kube-scheduler kubectl",
	    "sudo mv kube-apiserver kube-controller-manager kube-scheduler kubectl /usr/local/bin/",
	  	]
		}
}