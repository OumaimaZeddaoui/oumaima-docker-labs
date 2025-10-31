# Étape 1 : Utiliser une image légère de base (Alpine Linux)
FROM alpine:latest

# Étape 2 : Installer curl dans le conteneur
RUN apk add --no-cache curl

# Étape 3 : Créer un utilisateur non-root (pour la sécurité)
RUN adduser -D user
USER user

# Étape 4 : Commande par défaut — exécuter curl sur une URL donnée
ENTRYPOINT ["curl"]
CMD ["https://example.com"]
