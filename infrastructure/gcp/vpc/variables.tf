variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "router_name" {}

variable "cluster_name" {
  description = "The name for the GKE cluster"
  default     = "gke-on-vpc-cluster"
}

variable "region" {
  description = "The region to host the cluster in"
}

variable "network" {
  description = "The VPC network created to host the cluster in"
}

variable "subnetwork" {
  description = "The subnetwork created to host the cluster in"
}

variable "ip_range_pods_name" {
  description = "The secondary ip range to use for pods"
}

variable "ip_range_services_name" {
  description = "The secondary ip range to use for services"
}