# Objectif 
# Modifier la page par défaut de Nginx en utilisant un volume Docker pour la persistance des 
# données. 
# Commandes et Vérifications 
# 1. Démarrer le conteneur avec un volume : 

docker run -d --name enjoy_nx -p 8080:80 -v /path/to/your/html:/usr/share/nginx/html nginx 
#  Remplacez /path/to/your/html par le chemin local contenant la page 
# modifiée. 
# 2. Vérification : Accédez à http://localhost:8080 pour voir la page par défaut modifiée.