#!/bin/bash
# Shutdown services running in a worktree

set -euo pipefail

# Stop docker compose services if docker-compose.yml exists
if [ -f "docker-compose.yml" ]; then
    echo "Stopping docker compose services..."
    docker compose down
fi

# Stop the app server by port if .env exists
if [ -f ".env" ]; then
    SERVER_PORT=$(grep "^SERVER_ADDRESS=" .env | cut -d: -f2)
    if [ -n "$SERVER_PORT" ]; then
        echo "Stopping processes on port ${SERVER_PORT}..."
        kill $(lsof -ti:${SERVER_PORT}) 2>/dev/null || echo "No process found on port ${SERVER_PORT}"
    fi
fi

echo "Services stopped successfully"
