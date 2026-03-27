# Worktrees for Applications with Services

This guide provides additional setup steps when working with worktrees for projects that run services (web apps with HTTP servers, docker-compose services, etc.).

## When to Use This Guide

Use these instructions after following the main worktree setup in [SKILL.md](SKILL.md) **only if**:
- The project has `.env*` files in the main directory
- The project runs services like web servers, databases, or docker-compose

If the project is a library or CLI tool without a `.env` file, skip these instructions entirely.

## Copy Environment Files

Before configuring ports and starting services, copy any `.env*` files from the main working directory:

```bash
cp ../../.env* .
```

This ensures the worktree has the necessary environment configuration to run the application. Environment files are typically gitignored and won't be available in the new worktree otherwise.

## Port Allocation

To avoid conflicts when running multiple instances of the app in parallel worktrees, each worktree needs its own set of ports.

### Required Ports

Allocate 4 available ports for the following services:
1. `SERVER_ADDRESS` - The main HTTP server port (also used for `BASE_URL`)
2. `MINIO_PORT` - MinIO S3 API endpoint (also used for `AWS_ENDPOINT_URL`)
3. `MINIO_CONSOLE_PORT` - MinIO web console
4. `MINIO_TEST_PORT` - MinIO test instance

### Port Scanning

Use the provided script to find 4 available ports starting from **9090**:

```bash
# Run the port allocation script from the worktrees skill
# Note: This script is located in the worktrees skill directory, not in the project repo
ports=($(bash scripts/allocate-ports.sh))

# Assign ports to variables (using 1-based indexing for zsh compatibility)
SERVER_PORT=${ports[1]}
MINIO_PORT=${ports[2]}
MINIO_CONSOLE_PORT=${ports[3]}
MINIO_TEST_PORT=${ports[4]}
```

**Important:**
- Ports don't need to be consecutive - the script finds the next available port until it has 4
- The array uses 1-based indexing (zsh style) for compatibility
- The `scripts/` directory is part of the worktrees skill, not your project repository

### Update .env File

Once ports are allocated, update the `.env` file with the new values:

```bash
# Update SERVER_ADDRESS (note the : prefix)
sed -i '' "s|^SERVER_ADDRESS=.*|SERVER_ADDRESS=:${SERVER_PORT}|" .env

# Update BASE_URL
sed -i '' "s|^BASE_URL=.*|BASE_URL=http://localhost:${SERVER_PORT}|" .env

# Update AWS_ENDPOINT_URL to match MINIO_PORT
sed -i '' "s|^AWS_ENDPOINT_URL=.*|AWS_ENDPOINT_URL=http://localhost:${MINIO_PORT}|" .env

# Update MinIO ports
sed -i '' "s|^MINIO_PORT=.*|MINIO_PORT=${MINIO_PORT}|" .env
sed -i '' "s|^MINIO_CONSOLE_PORT=.*|MINIO_CONSOLE_PORT=${MINIO_CONSOLE_PORT}|" .env
sed -i '' "s|^MINIO_TEST_PORT=.*|MINIO_TEST_PORT=${MINIO_TEST_PORT}|" .env
```

## Starting Services

After updating the `.env` file, start the services:

### 1. Start docker-compose (if docker-compose.yml exists)

```bash
docker compose up -d
```

This starts MinIO services in detached mode on the allocated ports. Docker Compose will automatically read the port values from the `.env` file.

### 2. Download Tailwind CSS (if needed)

```bash
make tailwindcss
```

This downloads the Tailwind CSS binary if it doesn't exist in the worktree.

### 3. Start Tailwind CSS watch (if tailwindcss exists)

```bash
./tailwindcss -i tailwind.css -o public/styles/app.css --watch &
```

This starts Tailwind CSS compilation in watch mode for automatic CSS rebuilding.

### 4. Start watch.sh (if it exists)

```bash
./watch.sh &
```

This starts the app with Air auto-reload in the background. The watch.sh script will read `SERVER_ADDRESS` from the `.env` file and start the HTTP server on the allocated port.

### 5. Inform the User

Report back to the user with:
- The worktree path (`.worktrees/<branch-name>`)
- The allocated ports:
  - App URL: `http://localhost:${SERVER_PORT}` (from BASE_URL)
  - MinIO S3: `http://localhost:${MINIO_PORT}`
  - MinIO Console: `http://localhost:${MINIO_CONSOLE_PORT}`
  - MinIO Test: `http://localhost:${MINIO_TEST_PORT}`
- Confirmation that services are running

## Stopping Services

When stopping work in a worktree or cleaning up, use the shutdown script:

```bash
cd .worktrees/<branch-name>
bash scripts/shutdown-services.sh
```

**Note:** The `scripts/` directory is part of the worktrees skill, not your project repository.

This script will:
1. Stop and remove docker compose services (if docker-compose.yml exists)
2. Stop the app server process by port (if .env exists)

## Port Tracking

Ports are stored **only** in each worktree's `.env` file - there is no central registry. When you need to find which ports a worktree is using, read its `.env` file:

```bash
grep -E "^(SERVER_ADDRESS|MINIO_PORT|MINIO_CONSOLE_PORT|MINIO_TEST_PORT)=" .worktrees/<branch-name>/.env
```

## Example Complete Workflow

```bash
# 1. Create worktree (from main skill.md)
git worktree add .worktrees/feature-auth -b feature-auth
cd .worktrees/feature-auth

# 2. Copy .env files
cp ../../.env* .

# 3. Allocate ports using the script
ports=($(bash scripts/allocate-ports.sh))
SERVER_PORT=${ports[1]}
MINIO_PORT=${ports[2]}
MINIO_CONSOLE_PORT=${ports[3]}
MINIO_TEST_PORT=${ports[4]}
# Example allocation: 9090, 9091, 9092, 9093

# 4. Update .env with allocated ports
sed -i '' "s|^SERVER_ADDRESS=.*|SERVER_ADDRESS=:${SERVER_PORT}|" .env
sed -i '' "s|^BASE_URL=.*|BASE_URL=http://localhost:${SERVER_PORT}|" .env
sed -i '' "s|^AWS_ENDPOINT_URL=.*|AWS_ENDPOINT_URL=http://localhost:${MINIO_PORT}|" .env
sed -i '' "s|^MINIO_PORT=.*|MINIO_PORT=${MINIO_PORT}|" .env
sed -i '' "s|^MINIO_CONSOLE_PORT=.*|MINIO_CONSOLE_PORT=${MINIO_CONSOLE_PORT}|" .env
sed -i '' "s|^MINIO_TEST_PORT=.*|MINIO_TEST_PORT=${MINIO_TEST_PORT}|" .env

# 5. Start services
docker compose up -d
make tailwindcss
./tailwindcss -i tailwind.css -o public/styles/app.css --watch &
./watch.sh &

# 6. Report to user
echo "Worktree created at .worktrees/feature-auth"
echo "App running at http://localhost:${SERVER_PORT}"
echo "MinIO S3 at http://localhost:${MINIO_PORT}"
echo "MinIO Console at http://localhost:${MINIO_CONSOLE_PORT}"
echo "Services started successfully"

# Later: Stop services
cd .worktrees/feature-auth
bash scripts/shutdown-services.sh
cd ../..
```
