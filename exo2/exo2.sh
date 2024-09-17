# Objectif 
# Démarrer un conteneur Nginx en arrière-plan avec redémarrage automatique, exposant le port 
# 80 sur le port 5000 de la machine hôte. 
# Commandes et Vérifications 
# 1. Démarrer le conteneur : 
docker run -d --name enjoy_nx --restart unless-stopped -p 5000:80 
nginx 
# Vérification : Accédez à http://localhost:5000 pour voir la page web par 
# défaut de Nginx.