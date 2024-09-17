# Commandes et Vérifications 
# 1. Construire l'image avec une version spécifique de Node.js : 

docker build --build-arg NODE_VERSION=18.0.5 -t node-custom:0.0.1 .

#2. Démarrer le conteneur et vérifier la version de Node.js : 

docker run -it node-custom:0.0.1 node --version