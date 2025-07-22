# Use a base image with wine for Windows binaries
FROM jlesage/baseimage-gui:debian-11

LABEL maintainer="omnidevops"

# Install wine and sqlite3
RUN apt-get update && \
    apt-get install -y wine sqlite3 && \
    rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /app

# Copy the compiled binary and related files
COPY dmvc-todo/delphitodohtmx.dpr /app/delphitodohtmx.dpr
COPY dmvc-todo/bin /app/bin

# Expose app port (use .env file config)
EXPOSE 8090

# Run your Delphi executable with Wine
CMD ["wine", "/app/delphitodohtmx.dpr"]
