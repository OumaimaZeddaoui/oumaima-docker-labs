# Étape 1 : Utiliser une image officielle Node.js
FROM node:18-alpine

# Étape 2 : Créer un dossier pour l'application
WORKDIR /app

# Étape 3 : Copier les fichiers package.json et package-lock.json
COPY package*.json ./

# Étape 4 : Installer les dépendances
RUN npm install

# Étape 5 : Copier tout le code de l'application
COPY . .

# Étape 6 : Créer un utilisateur non-root
RUN adduser -D appuser
USER appuser

# Étape 7 : Exposer le port 3000
EXPOSE 3000

# Étape 8 : Lancer l'application
CMD ["node", "server.js"]
