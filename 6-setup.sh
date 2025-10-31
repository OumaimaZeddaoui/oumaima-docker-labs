#!/bin/bash
# Script : 6-setup.sh
# Description : Déploie une base de données PostgreSQL persistante avec Docker Compose

echo "📦 Création de l'environnement PostgreSQL..."

# 1️⃣ Créer le fichier docker-compose.yml
cat <<EOF > docker-compose.yml
version: '3.8'

services:
  postgres:
    image: postgres:15
    container_name: postgres_db
    restart: always
    environment:
      POSTGRES_USER: admin
      POSTGRES_PASSWORD: admin123
      POSTGRES_DB: mydb
    ports:
      - "5432:5432"
    volumes:
