module "gcp-vpc" {
  source                            = "./gcp/vpc"
  project_id                        = var.project_id
  region                            = var.region
  ip_range_pods_name                = "gke-range-pod"
  ip_range_services_name            = "gke-range-srv"
  network                           = var.network_name
  subnetwork                        = var.subnetwork_name
  router_name                       = var.router_name
}


module "gcp-gke" {
  source = "./gcp/gke"
  project_name                            = var.project
  cluster_name                            = var.cluster_name
  location                                = var.region
  initial_node_count                      = var.initial_node_count
  min_master_version                      = var.min_master_version
  name_node_pool                          = var.name_node_pool
  min_node_count                          = var.min_node_count
  max_node_count                          = var.max_node_count
  node_pools_scopes                       = var.node_pools_scopes
  preemptible                             = var.preemptible
  machine_type                            = var.machine_type
  image_type                              = var.image_type
  network                                 = module.gcp-vpc.network
  subnetwork                              = var.subnetwork_name
  disk_size                               = var.disk_size
  project_id                              = var.project_id
  zone                                    = var.zone
  ip_range_pods                           = "gke-range-pod"
  ip_range_services                       = "gke-range-srv"
  master_ipv4_cidr_block                  = var.master_ipv4_cidr_block
  cluster_service_account_description     = var.cluster_service_account_description
  cluster_service_account_name            = var.cluster_service_account_name
  gke_service_account                     = var.gke_service_account
}


