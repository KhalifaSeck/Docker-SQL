# Docker-SQL

## Question 1. Comprendre la première exécution de Docker
Dans cette première étape, nous testons l'exécution d'un conteneur Docker de base en utilisant une image officielle Python.

La commande exécutée :
docker run -it python:3.12.8 bash

Explication de la commande :
docker run : lance un nouveau conteneur.

-it : permet d'accéder au terminal interactif (-i pour interactif, -t pour terminal).

python:3.12.8 : image Docker officielle contenant Python version 3.12.8.

bash : commande pour accéder à un shell bash dans le conteneur.

Cela permet d’entrer directement dans un environnement Python isolé, utile pour tester des scripts ou installer des dépendances sans rien toucher à la machine hôte.

## Question 2. Comprendre la mise en réseau Docker et Docker-Compose
Dans cette partie, nous exécutons le fichier docker-compose.yaml pour installer PostgreSQL et pgAdmin et explorer le fonctionnement de la mise en réseau automatique entre conteneurs Docker.


1. Services configurés :
PostgreSQL (db)

Image : postgres:17-alpine

Utilisateur : postgres

Mot de passe : postgres

Base de données : ny_taxi

Port exposé : 5433 (redirige vers le port 5432 du conteneur)

pgAdmin (pgadmin)

Interface web pour gérer PostgreSQL

Accessible via : http://localhost:8080

Identifiants par défaut :

Email : pgadmin@pgadmin.com

Mot de passe : pgadmin

2. Connexion à la base de données via pgAdmin :
Lorsque pgAdmin est lancé, ajouter un nouveau serveur avec les paramètres suivants :

Nom du serveur : ce que vous voulez (ex: PostgreSQL)

Host : db (nom du service dans le fichier docker-compose)

Port : 5432

Username : postgres

Password : postgres

3. Volumes persistants :
vol-pgdata : stocke les données PostgreSQL

vol-pgadmin_data : stocke la configuration de pgAdmin

4. Préparer Postgres et Charger les données
Nous allons maintenant télécharger les données de trajets en taxi vert ainsi que les données de localisation des zones de taxi, puis les importer dans la base PostgreSQL précédemment déployée avec Docker Compose.

5. Télécharger les fichiers csv : 
wget https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-10.csv.gz
wget https://github.com/DataTalksClub/nyc-tlc-data/releases/download/misc/taxi_zone_lookup.csv

Ensuite, on exécute la commande gunzip green_tripdata_2019-10.csv.gz pour dézipper le fichier en green_tripdata_2019-10.csv/

6. Charger les données dans PostgreSQL
Dans cette section, nous allons charger les données via un notebook jupyter

7. Question 3. Nombre de segments de voyage
Durant la période du 1er octobre 2019 (inclus) et du 1er novembre 2019 (exclusif), combien de voyages ont eu lieu respectivement :

Jusqu'à 1 mile
Entre 1 (exclusif) et 3 miles (inclus),
Entre 3 (exclusif) et 7 miles (inclus),
Entre 7 (exclusif) et 10 miles (inclus),
Plus de 10 miles
Réponses :
104 802; 197 670; 110 612; 27 831; 35 281
104 802; 198 924; 109 603; 27 678; 35 189
104 793; 201 407; 110 612; 27 831; 35 281
104 793; 202 661; 109 603; 27 678; 35 189
104 838; 199 013; 109 645; 27 688; 35 202

8. Question 4. Le trajet le plus long de chaque jour
Quel jour de prise en charge a été le plus long ? Utilisez l'heure de prise en charge pour vos calculs.

Conseil : pour chaque jour, nous ne nous intéressons qu'à un seul trajet avec la plus longue distance.

11/10/2019
24/10/2019
26/10/2019
31/10/2019

9. Question 5. Les trois plus grandes zones de ramassage
Quels étaient les principaux lieux de prise en charge avec plus de 13 000 total_amount(sur tous les trajets) pour le 18/10/2019 ?

À prendre en compte uniquement lpep_pickup_datetimelors du filtrage par date.

East Harlem Nord, East Harlem Sud, Morningside Heights
East Harlem Nord, Morningside Heights
Morningside Heights, Astoria Park, East Harlem South
Bedford, East Harlem North, Astoria Park


Pour les répondes des questions 7, 8 et 9 ( voir le notebook)

10. Terraform

