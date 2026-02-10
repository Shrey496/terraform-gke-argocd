terraform {
  backend "gcs" {
    bucket = "k8s-platform-automator"
    prefix = "terraform/state"
  }
}