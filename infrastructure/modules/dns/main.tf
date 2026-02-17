resource "google_dns_managed_zone" "platform" {
  name        = "dns-gitops-platform-zone"
  dns_name    = "${var.domain_name}."
  description = "Managed by Terraform for ${var.domain_name}"
  
  dnssec_config {
    state = "on"
  }
}

output "name_servers" {
  description = "Delegate your domain to these nameservers"
  value       = google_dns_managed_zone.platform.name_servers
}