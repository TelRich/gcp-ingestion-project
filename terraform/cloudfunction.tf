resource "google_storage_bucket_object" "function_zip" {
    name = "cloud_function_source.zip"
    bucket = google_storage_bucket.raw_data_bucket.name
    source = "${path.module}/../cloud_function.zip"
}

resource "google_cloudfunctions_function" "csv_loader" {
    name = "csv-loader-fn"
    runtime = "python310"
    entry_point = "load_csv_to_bq"
    available_memory_mb = 256
    source_archive_bucket = google_storage_bucket.raw_data_bucket.name
    source_archive_object = google_storage_bucket_object.function_zip.name

    environment_variables = {
        BQ_TABLE_ID = "${var.project_id}.${var.dataset_id}.sales"
    }
    # updated event
    event_trigger {
        event_type = "google.storage.object.finalize"
        resource = "projects/${var.project_id}/buckets/${google_storage_bucket.raw_data_bucket.name}"
    }
}

resource "google_project_iam_member" "function_bq_access" {
    project = var.project_id
    role = "roles/bigquery.dataEditor"
    member = "serviceAccount:${google_cloudfunctions_function.csv_loader.service_account_email}"
}