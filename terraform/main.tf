terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.35.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project
  region      = var.region
}

# 📦 Création du bucket GCS
resource "google_storage_bucket" "projet_bucket" {
  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true
  storage_class = var.gcs_storage_class

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

# 📤 Upload des fichiers CSV
resource "google_storage_bucket_object" "green_tripdata_csv" {
  name   = "green_tripdata_2019.csv"
  bucket = google_storage_bucket.projet_bucket.name
  source = "${var.data_dir}/green_tripdata_2019-10.csv"
}

resource "google_storage_bucket_object" "taxi_zone_lookup_csv" {
  name   = "taxi_zone_lookup.csv"
  bucket = google_storage_bucket.projet_bucket.name
  source = "${var.data_dir}/taxi_zone_lookup.csv"
}

# 🗃️ Création du dataset BigQuery
resource "google_bigquery_dataset" "demo_dataset" {
  dataset_id = var.bq_dataset_name
  location   = var.location
}

# 📊 Table BigQuery - green_tripdata
resource "google_bigquery_table" "green_tripdata" {
  dataset_id = google_bigquery_dataset.demo_dataset.dataset_id
  table_id   = "green_tripdata_2019"

  external_data_configuration {
    source_format = "CSV"
    autodetect    = true

    csv_options {
      skip_leading_rows = 1
      quote             = "\""
    }

    source_uris = [
      "gs://${google_storage_bucket.projet_bucket.name}/${google_storage_bucket_object.green_tripdata_csv.name}"
    ]
  }
}

# 📊 Table BigQuery - taxi_zone_lookup
resource "google_bigquery_table" "taxi_zone_lookup" {
  dataset_id = google_bigquery_dataset.demo_dataset.dataset_id
  table_id   = "taxi_zone_lookup"

  external_data_configuration {
    source_format = "CSV"
    autodetect    = true

    csv_options {
      skip_leading_rows = 1
      quote             = "\""
    }

    source_uris = [
      "gs://${google_storage_bucket.projet_bucket.name}/${google_storage_bucket_object.taxi_zone_lookup_csv.name}"
    ]
  }
}


# 🖥️ Déploiement d'une VM Ubuntu
resource "google_compute_instance" "ubuntu_vm" {
  name         = var.instance_name
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 16
      type  = "pd-standard"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  service_account {
    email  = "terraform-runner@${var.project}.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  tags = ["http-server", "https-server"]
}
