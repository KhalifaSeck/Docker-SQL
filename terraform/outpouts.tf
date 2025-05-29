# 🌐 URL du bucket GCS
output "bucket_url" {
  description = "URL du bucket GCS"
  value       = "https://console.cloud.google.com/storage/browser/${google_storage_bucket.projet_bucket.name}?project=${var.project}"
}

# 📊 Nom du dataset BigQuery
output "bigquery_dataset" {
  description = "Nom du dataset BigQuery"
  value       = google_bigquery_dataset.demo_dataset.dataset_id
}

# 📂 Lien vers l'interface BigQuery
output "bigquery_dataset_url" {
  description = "Lien direct vers le dataset BigQuery"
  value       = "https://console.cloud.google.com/bigquery?project=${var.project}&p=${var.project}&d=${google_bigquery_dataset.demo_dataset.dataset_id}&page=dataset"
}

# 🖥️ IP publique de la VM Ubuntu (si Compute Engine est activé)
output "ubuntu_vm_public_ip" {
  description = "Adresse IP publique de la VM"
  value       = google_compute_instance.ubuntu_vm.network_interface[0].access_config[0].nat_ip
}
