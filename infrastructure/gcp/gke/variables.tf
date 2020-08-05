#-------cluster------------#
variable "cluster_name" {}
variable "location" {}
variable "initial_node_count" {}
variable "min_master_version" {}
variable "project_name"{}
variable "network"{}
variable "subnetwork"{}
variable "master_ipv4_cidr_block" {}
#-----NodePool----------#
variable "name_node_pool"{}
variable "min_node_count"{}
variable "max_node_count"{}
variable "node_pools_scopes"{}
variable "preemptible"{}
variable "machine_type"{}
variable "image_type"{}

variable "disk_size"{}
variable "project_id" {}
variable "zone" {}

variable "ip_range_pods" {}
variable "ip_range_services" {}
variable "cluster_service_account_name" {}
variable "cluster_service_account_description" {}
variable "gke_service_account" {}