#!/bin/bash
# Script: 7-microservices.sh
# Purpose: Setup microservices stack (API, Worker, Postgres, Redis) with Compose

set -e

echo "📦 Generating docker-compose.yml ..."

cat > docker-compose.yml <<'YML'
services:
  api:
    build:
      context: ./microservices-app/api
    container_name: ms_api
    environment:
      # DB access for the API
      DB_HOST: postgres
      DB_PORT: 5432
      DB_USER: admin
      DB_PASSWORD: admin123
      DB_NAME: mydb
      # Redis access for the API
      REDIS_HOST: redis
      REDIS_PORT: 6379
    depends_on:
      - postgres
      - redis
    ports:
      - "4000:4000"        # only API is exposed to host
    networks:
      - msnet
    restart: unless-stopped

  worker:
    build:
      context: ./microservices-app/worker
    container_name: ms_worker
    environment:
      # DB access for the Worker (if needed)
      DB_HOST: postgres
      DB_PORT: 5432
      DB_USER: admin
      DB_PASSWORD: admin123
      DB_NAME: mydb
      # Redis queue access
      REDIS_HOST: redis
      REDIS_PORT: 6379
    depends_on:
      - postgres
      - redis
    networks:
      - msnet
    restart: unless-stopped

  postgres:
    image: postgres:15
    container_name: ms_postgres
    environment:
      POSTGRES_USER: admin
      POSTGRES_PASSWORD: admin123
      POSTGRES_DB: mydb
    volumes:
      - pgdata:/var/lib/postgresql/data   # persistent data
    networks:
      - msnet
    restart: unless-stopped

  redis:
    image: redis:7-alpine
    container_name: ms_redis
    # no volume -> ephemeral (no persistence required)
    networks:
      - msnet
    restart: unless-stopped

networks:
  msnet:

volumes:
  pgdata:
YML

echo "🚀 Bringing stack up ..."
docker compose up -d
echo "✅ Microservices stack is up. API on http://localhost:4000"
