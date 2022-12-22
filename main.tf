resource "google_storage_bucket" "gcs_bucket" {
    name = "teste-bucket-random-renato1"
    location = var.region
}