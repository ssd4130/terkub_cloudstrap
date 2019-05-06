# Vars file for Controller Instance

variable "boot_disk_size" {
	default = 200
}

variable "boot_disk_image" {
	default = "ubuntu-os-cloud/ubuntu-1804-lts"
}

variable "instance_name" {
	default = "controller"
}

variable "machine_type" {
	default = "n1-standard-1"
}

variable "zone" {
	default = "us-west1-c"
}

variable "etcd_service_path" {
	default = ""
}

variable "ca" {
	default = ""
}

variable "ca-key" {
	default = ""
}

variable "kubernetes-key" {
	default = ""
}

variable "kubernetes" {
	default = ""
}

variable "service_account_key" {
	default = ""
}

variable "service_account" {
	default = ""
}

variable "encryption_config" {
	default = ""
}

variable "kube_apiserver" {
	default = ""
}

variable "kube_controller_manager_config" {
	default = ""
}

variable "kube_controller_manager_service" {
	default = ""
}