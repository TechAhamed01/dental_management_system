#!/bin/bash
set -e

# Install Flutter if it doesn't exist in the mounted volume
if [ ! -d "/opt/flutter/bin" ]; then
  echo "Flutter SDK not found in volume. Downloading and installing Flutter 3.47.1..."
  cd /opt
  curl -o flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.47.1-stable.tar.xz
  echo "Extracting Flutter SDK (this might take a few minutes)..."
  tar xf flutter.tar.xz
  rm flutter.tar.xz
  
  # Configure safe directories for Git
  git config --global --add safe.directory /opt/flutter
  git config --global --add safe.directory /workspace
  
  # Enable Web support
  flutter config --enable-web
  
  # Accept licenses and run doctor
  yes | flutter doctor --android-licenses || true
  flutter doctor
  
  echo "Flutter 3.47.1 installation complete!"
else
  echo "Flutter SDK already installed in volume."
  # Ensure safe directories are configured on container restart
  git config --global --add safe.directory /opt/flutter
  git config --global --add safe.directory /workspace
fi

# Execute the provided command
exec "$@"
