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
CMD ["node", "app.js"