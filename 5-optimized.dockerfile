# Étape 1 : Build de l'application (image temporaire)
FROM golang:1.21-alpine AS builder

# Dossier de travail à l'intérieur du conteneur
WORKDIR /app

# Copier le code source
COPY go-app/ .

# Télécharger les dépendances
RUN go mod init go-app || true
RUN go mod tidy

# Compiler l'application (binaire statique)
RUN go build -o myapp .

# Étape 2 : Image finale ultra-légère
FROM alpine:latest

# Créer un utilisateur non-root
RUN adduser -D appuser
USER appuser

# Copier uniquement le binaire depuis la première image
COPY --from=builder /app/myapp /usr/local/bin/myapp

# Exposer le port 8080 (ou celui utilisé par ton app)
EXPOSE 8080

# Lancer le programme
ENTRYPOINT ["myapp"]
