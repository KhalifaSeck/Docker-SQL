# 🚀 Docker-SQL-Terraform-GCP Project

Bienvenue dans ce projet d'apprentissage autour de **Docker**, **PostgreSQL**, **pgAdmin**, **SQL** et **Terraform** sur **Google Cloud Platform (GCP)**. L’objectif est de manipuler un environnement conteneurisé, charger des données réelles de taxi à New York, les analyser à l’aide de requêtes SQL, puis automatiser le déploiement de l'infrastructure dans le cloud.

---

## 🤩 Sommaire

* [1. Exécution de base avec Docker](#1-exécution-de-base-avec-docker)
* [2. Configuration PostgreSQL + pgAdmin avec Docker Compose](#2-configuration-postgresql--pgadmin-avec-docker-compose)
* [3. Importation des données de trajets](#3-importation-des-données-de-trajets)
* [4. Analyse SQL des données](#4-analyse-sql-des-données)
* [5. Déploiement avec Terraform sur GCP](#5-déploiement-avec-terraform-sur-gcp)
* [6. Configuration IAM pour le compte Terraform](#6-configuration-iam-pour-le-compte-terraform)
* [7. Arborescence du projet](#7-arborescence-du-projet)
* [8. Fichier .gitignore](#8-fichier-gitignore)

---

## 1. Exécution de base avec Docker

```bash
docker run -it python:3.12.8 bash
```

* **-it** : terminal interactif
* **python:3.12.8** : image officielle Python
* **bash** : ouvre un shell dans le conteneur

---

## 2. Configuration PostgreSQL + pgAdmin avec Docker Compose

### PostgreSQL

* Image : `postgres:17-alpine`
* Ports : `5433:5432`

### pgAdmin

* Interface : [http://localhost:8080](http://localhost:8080)
* Email : `pgadmin@pgadmin.com`
* Mot de passe : `pgadmin`

---

## 3. Importation des données de trajets

```bash
wget https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-10.csv.gz
wget https://github.com/DataTalksClub/nyc-tlc-data/releases/download/misc/taxi_zone_lookup.csv
gunzip green_tripdata_2019-10.csv.gz
```

Chargement des données via `pandas` dans un notebook Python.

---

## 4. Analyse SQL des données

Exemples :

* Nombre de trajets par tranche de distance
* Trajet le plus long par jour
* Zones de ramassage principales

---

## 5. Déploiement avec Terraform sur GCP

### ⚙️ Installation de Terraform (Linux/WSL)

```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

### 🔑 Authentification avec Google Cloud

Avant d'exécuter Terraform, exporte ta clé d'identification :

```bash
export GOOGLE_APPLICATION_CREDENTIALS="./keys/my-creds.json"
```

Cela permet à Terraform de s'authentifier auprès de Google Cloud.

### 🔧 Infrastructure déployée

* Bucket GCS : stockage des CSV
* Dataset BigQuery : `demo_dataset`
* Tables BigQuery : `green_tripdata_2019`, `taxi_zone_lookup`
* VM Ubuntu : déployée dans `northamerica-northeast1-a`

### ⚡ Commandes Terraform

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

---

## 6. Configuration IAM pour le compte Terraform

Compte de service :

```
terraform-runner@terraform-project-461319.iam.gserviceaccount.com
```

Rôles requis dans GCP :

| Rôle                             | ID du rôle                     |
| -------------------------------- | ------------------------------ |
| Administrateur BigQuery          | `roles/bigquery.admin`         |
| Administrateur de Compute        | `roles/compute.admin`          |
| Administrateur Storage           | `roles/storage.admin`          |
| Utilisateur de compte de service | `roles/iam.serviceAccountUser` |

---

## 7. Arborescence du projet

```bash
Fullstack-Data-Engineering-Project-using-Docker-PostgreSQL-Terraform/
├── data/
│   └── green_tripdata_2019-10.csv
│   └── taxi_zone_lookup.csv
├── terraform/
│   ├── keys/
│   │   └── my-creds.json
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── .gitignore
├── docker-compose.yaml
├── notebooks/
│   └── data-load.ipynb
└── README.md
```

---

## 8. Fichier .gitignore

Fichier `.gitignore` à placer dans le dossier `terraform/` :

```gitignore
# Terraform
.terraform/
*.tfstate
*.tfstate.*
.terraform.tfstate.lock.info

# Variables sensibles
*.tfvars
*.tfvars.json

# Fichiers overrides locaux
override.tf
override.tf.json
*_override.tf
*_override.tf.json

# Fichiers de config CLI
.terraformrc
terraform.rc

# Clés GCP
keys/*.json

# OS et IDE
.vscode/
.idea/
*.swp
.DS_Store
Thumbs.db
```

---

> ⚠️ **Attention :** ne jamais versionner les fichiers de clés `*.json` ni les fichiers `.tfstate` dans GitHub !
