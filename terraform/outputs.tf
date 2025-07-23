output "bucket_url" {
    value = "gs://${google_storage_bucket.raw_data_bucket.name}/"
}

output "bigquery_dataset_id" {
    value = google_bigquery_dataset.sales_dataset.dataset_id
}