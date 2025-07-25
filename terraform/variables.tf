variable "project_id" {
    type = string 
    description = "Your Google Cloud project ID"
}

variable "region" {
    type = string
    default = "us-central"
    description = "GCP region"
}

variable "bucket_name" {
    type = string
    description = "Name of your Cloud Storage bucket"
}

variable "dataset_id" {
    type = string
    description = "BigQuery dataset ID"
}

variable "gcp_credentials_file" {
    type = string
    description = "Path to your GCP credentials JSON file"
    default = "C:/Users/okoro/AppData/Local/Google/Cloud SDK/key.json"
}