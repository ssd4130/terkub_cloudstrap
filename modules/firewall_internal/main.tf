#Internal firewall main.tf

resource "google_compute_firewall" "internal_firewall" {
  name    = "internal_firewall"
  network = "kubernetes"
  source-ranges = ["10.240.0.0/24", "10.200.0.0/16"]

  allow {
    protocol = "tcp"
  }

  allow {
  	protocol = "icmp"
  }

  allow {
  	protocol = "udp"
  }
}