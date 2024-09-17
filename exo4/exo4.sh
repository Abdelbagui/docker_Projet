# Objectif 
# Installer Node.js dans un conteneur Alpine, sauvegarder l'état du conteneur dans une nouvelle 
# image, et vérifier la présence de Node.js. 
# Commandes et Vérifications 
# 1. Démarrer le conteneur en interactif :

 docker run -it alpine:3.17.2 /bin/sh 
# 2. Installer Node.js : 

 apk add --no-cache nodejs npm 
 
# 3. Sauvegarder l'état du conteneur : 

docker commit <container_id> alpine-node:0.0.1 

# 4. Démarrer un conteneur avec l'image nouvellement créée : 

 docker run -it alpine-node:0.0.1 node --version