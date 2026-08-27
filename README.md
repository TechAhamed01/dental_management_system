# Dental Management System

This repository contains the complete Dental Management System.

## Development Environment Onboarding (Docker + Dev Containers)

We use Docker and VS Code Dev Containers to ensure a consistent, zero-install development environment for the entire team. You do **not** need to install Dart, Flutter, Serverpod, PostgreSQL, or Redis on your host machine.

### Prerequisites
1. [Docker Desktop](https://www.docker.com/products/docker-desktop) installed and running.
2. [Visual Studio Code](https://code.visualstudio.com/) installed.
3. [Dev Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) installed in VS Code.

### Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone <repository_url>
   cd dental_management_system
   ```

2. **Configure Environment:**
   Copy the example environment file:
   ```bash
   cp .env.example .env
   ```

3. **Start the Environment:**
   Open the repository folder in VS Code. You should see a prompt: **"Folder contains a Dev Container configuration file. Reopen in Container"**. Click **Reopen in Container**.
   *(If you don't see the prompt, press `Ctrl+Shift+P` and type `Dev Containers: Reopen in Container`)*.

   Docker will now build the `frontend` container (with Flutter) and start the `backend`, `postgres`, and `redis` services in the background.

### Running the Application

Inside the VS Code integrated terminal (which is now securely inside the `frontend` container):

**Start the Backend (if not already running automatically):**
```bash
docker compose logs -f backend
```
*(The backend automatically boots, fetches dependencies, applies migrations, and runs Serverpod in `docker` mode).*

**Seed Initial Data (Admin & Receptionist):**
If you have just cloned the repo and want to initialize the database with test profiles, open a new terminal (on your local machine) and run:
```bash
# Creates the default admin
docker compose exec backend bash -c "cd /app/dental/dental_server && dart bin/create_admin.dart"

# Creates the default Test Hospital and Receptionist
docker compose exec backend bash -c "cd /app/dental/dental_server && dart bin/seed_receptionist.dart"
```

**Run a Flutter Web App:**
Open a new VS Code terminal (inside the `frontend` container) and navigate to your desired app:
```bash
cd receptionist_dashboard
```

**Important Note for Linux/Web Builds:** The `file_picker` package sometimes fails to compile on web due to missing Linux dependencies (`dbus`) in the pub cache. To fix this, always clean your project before running for the first time:
```bash
flutter clean
flutter pub get
```

Then start the app:
```bash
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 65157
```
*(Use `--web-hostname=0.0.0.0` so it is accessible outside the container).*

**Ports mapped for Flutter Apps:**
- Doctor App: `45010`
- Admin Dashboard: `45011`
- Patient App: `49594`
- Receptionist Dashboard: `65157`

### Data Persistence
- **PostgreSQL Database**, **Redis**, **Dentist Documents**, and **Dental Images** are securely stored in persistent Docker volumes.
- Running `docker compose down` will safely stop the containers without destroying data.
- **WARNING:** Do NOT run `docker compose down -v` unless you explicitly want to wipe the database and all uploaded files!

### Serverpod Code Generation
To regenerate Serverpod protocol files, open a terminal inside the `dental/dental_server` folder and run:
```bash
serverpod generate
```
