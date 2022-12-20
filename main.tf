resource "google_storage_bucket" "gcs_bucket" {
	name = "teste-bucket-random-renato"
    location = var.region
}