# Commandes et Vérifications 
# 1. Construire l'image : 

docker build -t nginx-custom:0.0.1 . 

#2. Démarrer le conteneur avec les paramètres par défaut : 

docker run -d -p 8080:80 nginx-custom:0.0.1 

#3. Modifier la commande par défaut (par exemple, pour activer le mode debug) : 

docker run -d -p 8080:80 nginx-custom:0.0.1 -g "daemon on;" 