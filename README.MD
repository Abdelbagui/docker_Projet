
---

# Rendu du Projet Docker

## Contexte du Projet
Ce projet consiste à utiliser Docker pour gérer des conteneurs et créer des images Docker personnalisées pour différents cas d'utilisation. Les exercices couvrent divers aspects de Docker, y compris l'interaction avec des conteneurs, la persistance des données, la création d'images personnalisées, et la configuration de services avec Docker Compose.

## Table des Matières
- [Exercice 1 - Shell Interactif](#exercice-1---shell-interactif)
- [Exercice 2 - Kit Main Libre](#exercice-2---kit-main-libre)
- [Exercice 3 - Logger](#exercice-3---logger)
- [Exercice 4 - Commit IT](#exercice-4---commit-it)
- [Exercice 5 - Persistance des Données](#exercice-5---persistance-des-données)
- [Exercice 6 - Composition Multiple](#exercice-6---composition-multiple)
- [Exercice 7 - Créer sa Première Image](#exercice-7---créer-sa-première-image)
- [Exercice 8 - Je M’appelle “Dockerfile”](#exercice-8---je-mappelle-dockerfile)
- [Exercice 9 - ARGS vs ENV](#exercice-9---args-vs-env)
- [Exercice 10 - CMD vs ENTRYPOINT](#exercice-10---cmd-vs-entrypoint)
- [Exercice 11 - Multicouche](#exercice-11---multicouche)

---

## Exercice 1 - Shell Interactif

### Objectif
Démarrer un conteneur Alpine en mode interactif, et vérifier son comportement en quittant la session shell.

### Commandes et Vérifications
1. Démarrer le conteneur en mode interactif avec auto-destruction :
   ```bash
   docker run -it --rm alpine:3.17.2 /bin/sh
   ```
2. **Vérification** : Accédez à l'arborescence avec `ls` et `cd` pour confirmer que vous êtes à l'intérieur du conteneur. Quittez avec `exit` et vérifiez que le conteneur est bien supprimé.

---

## Exercice 2 - Kit Main Libre

### Objectif
Démarrer un conteneur Nginx en arrière-plan avec redémarrage automatique, exposant le port 80 sur le port 5000 de la machine hôte.

### Commandes et Vérifications
1. Démarrer le conteneur :
   ```bash
   docker run -d --name enjoy_nx --restart unless-stopped -p 5000:80 nginx
   ```
2. **Vérification** : Accédez à [http://localhost:5000](http://localhost:5000) pour voir la page web par défaut de Nginx.

---

## Exercice 3 - Logger

### Objectif
Attacher le terminal aux logs du conteneur Nginx et vérifier que les requêtes apparaissent dans les logs.

### Commandes et Vérifications
1. Attacher le terminal aux logs :
   ```bash
   docker logs -f enjoy_nx
   ```
2. **Vérification** : Accédez à [http://localhost:5000](http://localhost:5000) et observez les logs dans le terminal.

---

## Exercice 4 - Commit IT

### Objectif
Installer Node.js dans un conteneur Alpine, sauvegarder l'état du conteneur dans une nouvelle image, et vérifier la présence de Node.js.

### Commandes et Vérifications
1. Démarrer un conteneur en mode interactif :
   ```bash
   docker run -it alpine:3.17.2 /bin/sh
   ```
2. Installer Node.js :
   ```bash
   apk add --no-cache nodejs npm
   ```
3. Sauvegarder l'état du conteneur :
   ```bash
   docker commit <container_id> alpine-node:0.0.1
   ```
4. Démarrer un conteneur avec l'image nouvellement créée :
   ```bash
   docker run -it alpine-node:0.0.1 node --version
   ```

---

## Exercice 5 - Persistance des Données

### Objectif
Modifier la page par défaut de Nginx en utilisant un volume Docker pour la persistance des données.

### Commandes et Vérifications
1. Démarrer le conteneur avec un volume :
   ```bash
   docker run -d --name enjoy_nx -p 8080:80 -v /path/to/your/html:/usr/share/nginx/html nginx
   ```
   Remplacez `/path/to/your/html` par le chemin local contenant la page modifiée.
2. **Vérification** : Accédez à [http://localhost:8080](http://localhost:8080) pour voir la page par défaut modifiée.

---

## Exercice 6 - Composition Multiple

### Objectif
Utiliser Docker Compose pour démarrer un conteneur WordPress et une base de données MySQL avec des données persistantes.

### Fichier `docker-compose.yml`
```yaml
version: '3.8'
services:
  db:
    image: mysql:5.7
    volumes:
      - db_data:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: wordpress
      MYSQL_USER: user
      MYSQL_PASSWORD: userpassword

  wordpress:
    image: wordpress:latest
    ports:
      - "8080:80"
    volumes:
      - wordpress_data:/var/www/html
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_NAME: wordpress
      WORDPRESS_DB_USER: user
      WORDPRESS_DB_PASSWORD: userpassword
    depends_on:
      - db

volumes:
  db_data:
  wordpress_data:
```

### Commandes et Vérifications
1. Démarrer les services :
   ```bash
   docker-compose up -d
   ```
2. **Vérification** : Accédez à [http://localhost:8080](http://localhost:8080) pour vérifier que WordPress est accessible.

---

## Exercice 7 - Créer sa Première Image

### Objectif
Créer une image Docker qui affiche la liste des processus en cours dans le conteneur en utilisant `top -b`.

### Fichier `Dockerfile`
```Dockerfile
FROM alpine:latest
RUN apk add --no-cache procps
CMD ["top", "-b"]
```

### Commandes et Vérifications
1. Construire l'image :
   ```bash
   docker build -t top:0.0.1 .
   ```
2. Démarrer le conteneur :
   ```bash
   docker run -it top:0.0.1
   ```
3. **Vérification** : Le terminal affichera la liste des processus en cours.

---

## Exercice 8 - Je M’appelle “Dockerfile”

### Objectif
Créer une image Docker qui affiche le nom et le prénom sous la forme `nom.prenom` à partir des variables d'environnement.

### Fichier `Dockerfile`
```Dockerfile
FROM alpine:latest
ENV NOM="Doe" PRENOM="John"
CMD echo "$PRENOM.$NOM"
```

### Commandes et Vérifications
1. Construire l'image :
   ```bash
   docker build -t name-printer:0.0.1 .
   ```
2. Démarrer le conteneur avec des variables d'environnement :
   ```bash
   docker run -e NOM=doe -e PRENOM=jan name-printer:0.0.1
   ```
3. **Vérification** : Le conteneur affichera `jan.doe`.

---

## Exercice 9 - ARGS vs ENV

### Objectif
Créer une image Node.js avec une version configurable lors de la phase de build en utilisant `ARG`.

### Fichier `Dockerfile`
```Dockerfile
FROM node:latest
ARG NODE_VERSION=18
RUN npm install -g n && n $NODE_VERSION
CMD ["node"]
```

### Commandes et Vérifications
1. Construire l'image avec une version spécifique de Node.js :
   ```bash
   docker build --build-arg NODE_VERSION=18.0.5 -t node-custom:0.0.1 .
   ```
2. Démarrer le conteneur et vérifier la version de Node.js :
   ```bash
   docker run -it node-custom:0.0.1 node --version
   ```

---

## Exercice 10 - CMD vs ENTRYPOINT

### Objectif
Créer un Dockerfile pour Nginx utilisant `ENTRYPOINT` et `CMD` pour configurer les paramètres.

### Fichier `Dockerfile`
```Dockerfile
FROM nginx:latest
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
```

### Commandes et Vérifications
1. Construire l'image :
   ```bash
   docker build -t nginx-custom:0.0.1 .
   ```
2. Démarrer le conteneur avec les paramètres par défaut :
   ```bash
   docker run -d -p 8080:80 nginx-custom:0.0.1
   ```
3. Modifier la commande par défaut :
   ```bash
   docker run -d -p 8080:80 nginx-custom:0.

0.1 -g "daemon on;"
   ```

---

## Exercice 11 - Multicouche

### Objectif
Créer une image Node.js en utilisant une architecture multicouche.

### Fichier `Dockerfile`
```Dockerfile
# Étape 1 : Créer la couche "BUILD" pour installer les dépendances
FROM node:18 AS BUILD
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# Étape 2 : Créer la couche finale et lancer l'application
FROM node:18
WORKDIR /app
COPY --from=BUILD /app /app
CMD ["node", "app.js"]
```

### Commandes et Vérifications
1. Construire l'image :
   ```bash
   docker build -t multilayer-node-app:1.0.0 .
   ```
2. Démarrer le conteneur :
   ```bash
   docker run -p 3000:3000 multilayer-node-app:1.0.0
   ```
3. **Vérification** : Accédez à [http://localhost:3000](http://localhost:3000) pour voir l'application Node.js.

---

Ce format clair et structuré rendra votre projet Docker facilement compréhensible et utilisable par les lecteurs.