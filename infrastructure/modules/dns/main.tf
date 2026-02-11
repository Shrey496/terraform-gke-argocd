resource "google_dns_managed_zone" "platform" {
  name        = "platform-zone"
  dns_name    = "${var.domain_name}." # ⚠️ Note the trailing dot
  description = "Managed by Terraform for ${var.domain_name}"
  
  # DNSSEC (Optional but recommended for Staff-level security)
  dnssec_config {
    state = "on"
  }
}

output "name_servers" {
  description = "Delegate your domain to these nameservers"
  value       = google_dns_managed_zone.platform.name_servers
}