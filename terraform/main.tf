terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "~> 5.0"
        }
    }

    required_version = ">= 1.3.0"
}

provider "google" {
    credentials = file("C:/Users/okoro/AppData/Local/Google/Cloud SDK/key.json")
    project = var.project_id
    region = var.region
}

resource "google_storage_bucket" "raw_data_bucket" {
    name = var.bucket_name
    location = var.region
    force_destroy = true

    uniform_bucket_level_access = true
}

resource "google_bigquery_dataset" "sales_dataset" {
    dataset_id = var.dataset_id
    location = var.region
    description = "Dataset for storing uploaded sales data"
}
