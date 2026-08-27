FROM dart:3.12.2

WORKDIR /app

# Install necessary system dependencies if needed (e.g., for Serverpod or Postgres client)
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install Serverpod CLI globally to allow regenerating code from within the dev container
RUN dart pub global activate serverpod_cli 3.4.11
ENV PATH="$PATH:/root/.pub-cache/bin"

# We don't copy the source code here because we will mount the repository via Docker Compose 
# to enable live editing and immediate reflection of changes.
# The entrypoint will be handled manually or by docker-compose commands.
