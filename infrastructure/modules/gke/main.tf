resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.zone
  private_cluster_config {
    enable_private_nodes    = true   # Fixes the Org Policy Error
    enable_private_endpoint = false  # Allows you to access the cluster from your laptop
    master_ipv4_cidr_block  = "172.16.0.0/28" # Required for private clusters
  }
  network = var.network_name
  subnetwork = var.subnet_name

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_range_name
    services_secondary_range_name = var.services_range_name
  }

  # This creates the "Bridge" that allows Pods to safely talk to Google APIs.
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

}

resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool"
  cluster    = google_container_cluster.primary.name
  location   = var.zone
  node_count = 2

  node_config {
    machine_type = "e2-standard-4"
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}