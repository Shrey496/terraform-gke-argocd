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

#Create a cloud router
resource "google_compute_router" "router" {
  name = "${var.cluster_name}-router"
  region = var.region
  network = google_compute_network.vpc.id
}

#Create the Cloud NAT Gateway (provide Internet access to private nodes)
resource "google_compute_router_nat" "nat" {
  name = "${var.cluster_name}-nat"
  router = google_compute_router.router.name
  region = var.region
  nat_ip_allocate_option = "AUTO_ONLY"  #Grab an available IP from global pool, use and release IP when NAT is destroyed
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}