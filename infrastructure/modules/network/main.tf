resource "google_compute_network" "vpc" {
    name                    = "${var.cluster_name}-vpc"
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.cluster_name}-subnet"
  ip_cidr_range = "10.0.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc.id
  
  secondary_ip_range {
    range_name    = "pods-range"
    ip_cidr_range = "10.48.0.0/14"
  }
    
  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "10.52.0.0/20"
   
  }
}