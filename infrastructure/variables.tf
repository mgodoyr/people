variable "project_id" {}
variable "project" {}

variable "billing_id" {
  default = "0062F1-4D4FFB-8DCF85"
}

variable "organization_id" {
  default = 0
}

variable "network_name" {
  default = "gke-vpc"
}

variable "zone" {
  default = "us-east4-a"
}

variable "region" {
  default = "us-east4"
}

variable "enable_google" {
  type    = bool
  default = true
}

variable "cluster_name" {
  default = "gke-people-api"
}

variable "initial_node_count" {
  default = 1
}

variable "min_master_version" {
  default = "1.16.9-gke.6"
}
variable "name_node_pool" {
  default = "default"
}
variable "remove_default_node_pool" {
  default = "true"
}
variable "min_node_count" {
  default = 1
}
variable "max_node_count" {
  default = 3
}
variable "node_pools_scopes" {
  default = [ "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/monitoring.write",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring"
  ]
}

variable "preemptible" {
  default = true
}

variable "machine_type" {
  default = "n1-standard-4"
}

variable "image_type" {
  default = "COS"
}

variable "disk_size" {
  default = 100
}

variable "subnetwork_name" {
  default = "gke-subnet"
}

variable "master_ipv4_cidr_block" {
  description = "The IP range in CIDR notation (size must be /28) to use for the hosted master network. This range will be used for assigning internal IP addresses to the master or set of masters, as well as the ILB VIP. This range must not overlap with any other ranges in use within the cluster's network."
  type        = string
  default     = "10.5.0.0/28"
}

variable ip_cidr_range {
  default = "10.10.90.0/24"
}

variable "router_name" {
  default = "people-router"
}

variable "router_nat_name" {
  default = "gke-nat"
}

variable "nat_ip_allocate_option" {
  default = "AUTO_ONLY"
}

variable "source_subnetwork_ip_ranges_to_nat" {
  default = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

variable "log_config_filter" {
  default = "ERRORS_ONLY"
}

variable "log_config_enable" {
  default = false
}

variable "cluster_service_account_description" {
  default = "GKE people account service"
}

variable "cluster_service_account_name" {
  default = "gke-people-srv"
}

variable "gke_service_account" {
  default = "terraform@terraform-credentials.iam.gserviceaccount.com"
}

