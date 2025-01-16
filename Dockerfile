FROM envoyproxy/envoy:v1.26-latest

# Install Python and dependencies
USER root
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/local/bin

# Copy the hot-restarter script into the container
COPY hot-restarter.py /usr/local/bin/hot-restarter.py
RUN chmod +x /usr/local/bin/hot-restarter.py

# Copy Envoy configuration into the container
COPY envoy.yaml /etc/envoy/envoy.yaml

# Expose necessary ports
EXPOSE 8080 8001 9000

# Set environment variables for optimization
ENV RESTART_EPOCH=0
ENV MALLOC_ARENA_MAX=2
ENV GOGC=50

# Define the entrypoint to run the hot-restarter script
CMD ["python3", "/usr/local/bin/hot-restarter.py", "/usr/local/bin/envoy", "-c", "/etc/envoy/envoy.yaml"]
