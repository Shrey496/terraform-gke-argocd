output "network_name" {
  description = "The name of the VPC being created"
  value       = google_compute_network.vpc.name
}

output "subnet_name" {
  description = "The name of the subnet being created"
  value       = google_compute_subnetwork.subnet.name
}

output "project_id" {
  description = "The project ID"
  value       = var.project_id
}

output "pods_range_name" {
  description = "The name of the secondary range for pods"
  value       = "pods-range"  # Must match the name you defined in main.tf inside the network module
}

output "services_range_name" {
  description = "The name of the secondary range for services"
  value       = "services-range" # Must match the name you defined in main.tf inside the network module
}