resource "google_compute_subnetwork" "kub_subnet" {
  name          = "${var.subnet_name}"
  ip_cidr_range = "${var.cidr_range}"
  region        = "${var.region}"
  network       = "kubernetes"
}
