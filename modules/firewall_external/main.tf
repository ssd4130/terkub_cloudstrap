resource "google_compute_firewall" "external_firewall" {
  name    = "external_firewall"
  network = "kubernetes"
  source-ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports = ["22","6443"]
  }

  allow {
  	protocol = "icmp"
  }
}