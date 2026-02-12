# 1. Network Layer
module "network" {
  source = "./modules/network"
  project_id = var.project_id
  region = var.region
  cluster_name = var.cluster_name
}

# 2. Compute Layer (GKE)
module "gke" {
  source = "./modules/gke"
  project_id = var.project_id
  zone = var.zone
  cluster_name = var.cluster_name

  # Dependency: Wait for Network to exist
  network_name        = module.network.network_name
  subnet_name         = module.network.subnet_name
  pods_range_name     = module.network.pods_range_name
  services_range_name = module.network.services_range_name
}

# 3. DNS Layer
module "dns" {
  source      = "./modules/dns"
  project_id  = var.project_id
  domain_name = var.domain_name
}