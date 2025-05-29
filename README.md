
# Détails du Projet Docker-SQL

---

## Exécution de base avec Docker

###  Commande :
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
- **Host** : `db` (nom du service dans `docker-compose`)
- **Port** : `5432`
- **Utilisateur** : `postgres`
- **Mot de passe** : `postgres`

###  Volumes persistants :
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
L’import se fait à l’aide d’un **notebook Jupyter** situé dans le dossier `notebooks/`, en utilisant les bibliothèques **pandas** et **sqlalchemy** pour insérer les données dans la base PostgreSQL.

---

##  Analyse SQL des données

###  Question 3 : Nombre de trajets selon la distance (octobre 2019)
-  Jusqu’à 1 mile : **104 793**
-  Entre 1 et 3 miles : **202 661**
-  Entre 3 et 7 miles : **109 603**
-  Entre 7 et 10 miles : **27 678**
-  Plus de 10 miles : **35 189**

 *Requête SQL disponible dans le notebook Jupyter.*

---

### Question 4 : Trajet le plus long par jour
Pour chaque jour, un seul trajet est conservé (le plus long). Exemples :
- **11/10/2019**
- **24/10/2019**
- **26/10/2019**
- **31/10/2019**

 *Voir les résultats complets dans le notebook.*

---

###  Question 5 : Zones de ramassage principales le 18/10/2019

Zones avec un `total_amount` cumulé supérieur à 13 000 :
- **East Harlem North**
- **Morningside Heights**
- **Astoria Park**

 *Filtrage basé sur la colonne `lpep_pickup_datetime`.*

---

## Déploiement avec Terraform (à venir)

Cette section consistera à reproduire l’architecture **PostgreSQL + pgAdmin** dans un environnement **cloud** à l’aide de **Terraform**, pour s’initier aux bonnes pratiques de l’Infrastructure as Code (**IaC**).
