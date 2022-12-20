provider "google" {
  project = var.stack-storage-terraform-pipeline01
  region  = var.us-central1
}

terraform {
  backend "gcs" {
    bucket = "stack-storage-terraform-pipeline01"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      source  = "hashico rp/google"
      version = "3.67.0"
    }
  }
}