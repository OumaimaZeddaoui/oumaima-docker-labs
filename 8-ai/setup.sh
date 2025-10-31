#!/bin/bash
echo "🚀 Starting local AI environment..."

docker compose up -d

echo "📦 Pulling qwen:3-4b model into Ollama..."
docker exec ollama ollama pull qwen:3-4b

echo "✅ All services are running!"
echo "🌐 LibreChat → http://localhost:3080"
echo "🧠 Ollama API → http://localhost:11434"
echo "📁 Context7 MCP → http://localhost:8000"
