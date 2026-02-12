variable "project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "region" {
  description = "The GCP Region for the network"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP Zone for the GKE cluster"
  type        = string
  default     = "us-central1-a"
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
  default     = "gke-platform-primary"
}

variable "domain_name" {
  description = "The root domain name"
  type        = string
}