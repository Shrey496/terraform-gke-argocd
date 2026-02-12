output "cluster_endpoint" {
  description = "Connect to the cluster here"
  value       = module.gke.cluster_endpoint
  sensitive   = true
}

output "dns_name_servers" {
  description = "UPDATE YOUR REGISTRAR WITH THESE"
  value       = module.dns.name_servers
}