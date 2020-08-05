module "gke_cluster" {
  # Use a version of the gke-cluster module that supports Terraform 0.12
  source = "git@github.com:gruntwork-io/terraform-google-gke.git//modules/gke-cluster?ref=v0.3.8"
  name = var.cluster_name
  project  = var.project_id
  location = var.location
  network  = var.network

  # We're deploying the cluster in the 'public' subnetwork to allow outbound internet access
  # See the network access tier table for full details:
  # https://github.com/gruntwork-io/terraform-google-network/tree/master/modules/vpc-network#access-tier
  subnetwork = var.subnetwork

  # When creating a private cluster, the 'master_ipv4_cidr_block' has to be defined and the size must be /28
  master_ipv4_cidr_block = var.master_ipv4_cidr_block

  # This setting will make the cluster private
  enable_private_nodes = "true"

  # To make testing easier, we keep the public endpoint available. In production, we highly recommend restricting access to only within the network boundary, requiring your users to use a bastion host or VPN.
  disable_public_endpoint = "false"

  # With a private cluster, it is highly recommended to restrict access to the cluster master
  # However, for testing purposes we will allow all inbound traffic.
  master_authorized_networks_config = [
    {
      cidr_blocks = [
        {
          cidr_block   = "0.0.0.0/0"
          display_name = "all-for-people"
        },
      ]
    },
  ]

  cluster_secondary_range_name = var.ip_range_pods
}

resource "google_container_node_pool" "node_pool" {
  provider = google-beta

  name     = "people-pool"
  project  = var.project_id
  location = var.location
  cluster  = module.gke_cluster.name

  initial_node_count = "1"

  autoscaling {
    min_node_count = "1"
    max_node_count = "2"
  }

  management {
    auto_repair  = "true"
    auto_upgrade = "true"
  }

  node_config {
    image_type   = "COS"
    machine_type = "e2-standard-2"

    labels = {
      private-pools-example = "true"
    }

    # Add a private tag to the instances. See the network access tier table for full details:
    # https://github.com/gruntwork-io/terraform-google-network/tree/master/modules/vpc-network#access-tier

    disk_size_gb = "30"
    disk_type    = "pd-standard"
    preemptible  = var.preemptible

    service_account = module.gke_service_account.email

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  lifecycle {
    ignore_changes = [initial_node_count]
  }

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }
}


module "gke_service_account" {
  source = "git@github.com:gruntwork-io/terraform-google-gke.git//modules/gke-service-account?ref=v0.3.8"
  name        = var.cluster_service_account_name
  project     = var.project_id
  description = var.cluster_service_account_description
}

# ---------------------------------------------------------------------------------------------------------------------
# ALLOW THE CUSTOM SERVICE ACCOUNT TO PULL IMAGES FROM THE GCR REPO
# ---------------------------------------------------------------------------------------------------------------------


resource "google_storage_bucket_iam_member" "member" {
  bucket = "artifacts.${var.project_id}.appspot.com"
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${var.gke_service_account}"
}