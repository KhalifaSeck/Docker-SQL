
# 🚀 Docker-SQL-Terraform-GCP Project

Bienvenue dans ce projet d'apprentissage autour de **Docker**, **PostgreSQL**, **pgAdmin**, **SQL** et **Terraform** sur **Google Cloud Platform (GCP)**. L’objectif est de manipuler un environnement conteneurisé, charger des données réelles de taxi à New York, les analyser à l’aide de requêtes SQL, puis automatiser le déploiement de l'infrastructure dans le cloud.

---

## 🧩 Sommaire

- [1. Exécution de base avec Docker](#1-exécution-de-base-avec-docker)
- [2. Configuration PostgreSQL + pgAdmin avec Docker Compose](#2-configuration-postgresql--pgadmin-avec-docker-compose)
- [3. Importation des données de trajets](#3-importation-des-données-de-trajets)
- [4. Analyse SQL des données](#4-analyse-sql-des-données)
- [5. Déploiement avec Terraform sur GCP (à venir)](#5-déploiement-avec-terraform-sur-gcp-à-venir)
- [📁 Arborescence du projet](#-arborescence-du-projet)
- [📌 Prérequis](#-prérequis)

---

# Détails du Projet Docker-SQL-Terraform-GCP

---

## Exécution de base avec Docker

### Commande :
```bash
docker run -it python:3.12.8 bash
```

### Détails :
- **docker run** : crée et démarre un nouveau conteneur.
- **-it** : rend le conteneur interactif avec un terminal (-i pour input, -t pour terminal).
- **python:3.12.8** : image officielle Docker contenant Python 3.12.8.
- **bash** : ouvre un shell Bash dans le conteneur.

### Objectif :
Tester rapidement des scripts Python dans un environnement isolé, sans affecter la machine hôte.

---

## Configuration PostgreSQL + pgAdmin avec Docker Compose

### Services définis dans `docker-compose.yaml` :

#### PostgreSQL
- **Image** : `postgres:17-alpine`
- **Variables d’environnement** :
  - `POSTGRES_USER=postgres`
  - `POSTGRES_PASSWORD=postgres`
  - `POSTGRES_DB=ny_taxi`
- **Port** : `5433` (hôte) → `5432` (conteneur)

#### pgAdmin
- **Interface web** : [http://localhost:8080](http://localhost:8080)
- **Identifiants de connexion** :
  - **Email** : `pgadmin@pgadmin.com`
  - **Mot de passe** : `pgadmin`

### 🔌 Connexion à PostgreSQL via pgAdmin :
- **Nom du serveur** : libre (ex. `PostgreSQL Local`)
- **Host** : `db`
- **Port** : `5432`
- **Utilisateur** : `postgres`
- **Mot de passe** : `postgres`

### Volumes persistants :
- `vol-pgdata` : stocke les données PostgreSQL
- `vol-pgadmin_data` : conserve la configuration de pgAdmin

---

## Importation des données de trajets

### Étape 1 : Télécharger les fichiers CSV
```bash
wget https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-10.csv.gz
wget https://github.com/DataTalksClub/nyc-tlc-data/releases/download/misc/taxi_zone_lookup.csv
gunzip green_tripdata_2019-10.csv.gz
```

### Étape 2 : Charger les données dans PostgreSQL
L’import se fait à l’aide d’un **notebook Jupyter** situé dans le dossier `notebooks/`, en utilisant **pandas** et **sqlalchemy**.

---

## Analyse SQL des données

### Question 3 : Nombre de trajets selon la distance (octobre 2019)
- Jusqu’à 1 mile : **104 793**
- Entre 1 et 3 miles : **202 661**
- Entre 3 et 7 miles : **109 603**
- Entre 7 et 10 miles : **27 678**
- Plus de 10 miles : **35 189**

*Requête SQL disponible dans le notebook Jupyter.*

---

### Question 4 : Trajet le plus long par jour
- **11/10/2019**
- **24/10/2019**
- **26/10/2019**
- **31/10/2019**

*Voir les résultats complets dans le notebook.*

---

### Question 5 : Zones de ramassage principales le 18/10/2019
- **East Harlem North**
- **Morningside Heights**
- **Astoria Park**

*Filtrage basé sur la colonne `lpep_pickup_datetime`.*

---

## Déploiement avec Terraform sur GCP (à venir)

Cette section consistera à automatiser le déploiement de l’architecture PostgreSQL + pgAdmin sur **Google Cloud Platform** à l’aide de **Terraform**, pour explorer les concepts d’Infrastructure as Code (**IaC**) dans un environnement cloud.

