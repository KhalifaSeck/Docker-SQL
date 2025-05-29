# 🔐 Authentification
variable "credentials_file" {
  description = "Chemin vers le fichier d'identifiants JSON du compte de service"
  default     = "./keys/my-creds.json"
}

# 🌍 Projet et localisation
variable "project" {
  description = "ID du projet Google Cloud"
  default     = "terraform-project-461319"
}

variable "region" {
  description = "Région pour les ressources"
  default     = "northamerica-northeast1"
}

variable "location" {
  description = "Localisation utilisée pour BigQuery, GCS, etc."
  default     = "northamerica-northeast1"
}

# ☁️ Google Cloud Storage
variable "gcs_bucket_name" {
  description = "Nom du bucket GCS"
  default     = "terraform-project-461319-terra-bucket"
}

variable "gcs_storage_class" {
  description = "Classe de stockage du bucket (STANDARD, NEARLINE, etc.)"
  default     = "STANDARD"
}

# 📁 Dossier local contenant les fichiers à uploader
variable "data_dir" {
  description = "Répertoire local contenant les fichiers CSV"
  default     = "/workspaces/Fullstack-Data-Engineering-Project-using-Docker-PostgreSQL-Terraform/data"
}

# 📊 BigQuery
variable "bq_dataset_name" {
  description = "Nom du dataset BigQuery"
  default     = "demo_dataset"
}

# 🖥️ VM
variable "zone" {
  description = "Zone GCP pour la VM"
  default     = "northamerica-northeast1-a"
}

variable "instance_name" {
  description = "Nom de l'instance VM"
  default     = "demo-instance"
}
