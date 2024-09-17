# Commandes et Vérifications 
# 1. Construire l'image : 

docker build -t name-printer:0.0.1 . 

#2. Démarrer le conteneur avec des variables d'environnement : 

docker run -e NOM=doe -e PRENOM=jan name-printer:0.0.1 

#3. Vérification : Le conteneur affichera jan.doe.