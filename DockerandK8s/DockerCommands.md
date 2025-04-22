# Docker Command Master Reference

## 1. System & Environment Commands
### Version & Info
```bash
docker version       # Show client/server versions
docker info          # Display system-wide information
docker system df     # Show disk usage
```

### Context Management
```bash
docker context ls    # List available contexts
docker context use <context>  # Switch active context
```

### Cleanup & Pruning
```bash
docker system prune [--all --volumes]  # Remove unused data
  # Example (remove all unused data):
  docker system prune -a --volumes

docker builder prune          # Remove build cache
docker container prune        # Remove stopped containers
docker image prune [--all]    # Remove unused images
docker volume prune           # Remove unused volumes
docker network prune          # Remove unused networks
```

---

## 2. Image Management
### Basic Operations
```bash
docker pull <image>[:tag]             # Download image
docker build -t <name>:<tag> .        # Build from Dockerfile
docker push <repository>:<tag>        # Upload to registry
docker images                         # List local images
docker history <image>                # Show image layers
docker inspect <image>                # Detailed image info
```

### Image Manipulation
```bash
docker tag <source>[:tag] <target>[:tag]  # Create new tag
docker save -o file.tar <image>      # Export to tar archive
docker load -i file.tar              # Import from tar archive
docker commit <container> <image>    # Create image from container
```

### Image Cleanup
```bash
docker rmi <image>                   # Remove specific image
docker rmi -f $(docker images -q)    # Remove ALL images forcefully
```

---

## 3. Container Management
### Lifecycle Operations
```bash
docker create [options] <image>      # Create container without starting
docker run [options] <image>         # Create and start container
  # Common options:
  -d, --detach       # Run in background
  -p 80:80           # Port mapping
  -v /host:/container # Volume mount
  -e VAR=value       # Set environment variable
  --name mycontainer # Assign name

docker start/stop/restart <container>  # Manage state
docker pause/unpause <container>     # Freeze/resume
docker kill <container>              # Force stop
```

### Inspection & Interaction
```bash
docker ps [-a]                       # List (all) containers
docker logs [-f] <container>         # Show/follow logs
docker exec [-it] <container> cmd    # Execute command
docker attach <container>            # Attach to running container
docker inspect <container>           # Detailed container info
docker top <container>               # Show running processes
docker stats [container]             # Live resource metrics
```

### Data Management
```bash
docker cp container:path hostpath    # Copy files to/from container
docker export container > file.tar   # Export filesystem
docker import file.tar <name>:<tag>  # Create image from tarball
```

### Cleanup
```bash
docker rm <container>                # Remove container
docker rm -f $(docker ps -aq)        # Remove ALL containers
```

---

## 4. Storage & Volumes
### Volume Management
```bash
docker volume create <name>          # Create persistent volume
docker volume ls                     # List volumes
docker volume inspect <name>         # Volume details
docker volume rm <name>              # Remove volume
```

### Bind Mounts
```bash
docker run -v /host/path:/container/path <image>
```

---

## 5. Network Management
```bash
docker network create <name>         # Create network
docker network ls                    # List networks
docker network inspect <name>        # Network details
docker network connect <net> <cont>  # Connect container
docker network disconnect <net> <cont> # Disconnect
docker network rm <name>             # Remove network
```

---

## 6. Docker Compose
```bash
docker-compose up [-d] [--build]     # Start services
docker-compose down [-v]             # Stop and remove
docker-compose build                 # Rebuild images
docker-compose logs [-f] [service]   # View logs
docker-compose ps                    # List services
docker-compose exec service cmd      # Execute command
```

---

## 7. Registry Operations
```bash
docker login [registry]              # Authenticate
docker logout [registry]             # Log out
docker search <term>                 # Search Docker Hub
docker manifest inspect <image>      # Inspect multi-arch manifest
```

---

## 8. Advanced Features
### Plugins
```bash
docker plugin ls                     # List installed plugins
docker plugin install <plugin>       # Install plugin
docker plugin enable/disable <plugin> # Manage state
docker plugin rm <plugin>            # Remove plugin
```

### Experimental
```bash
docker manifest create <name> <images...>  # Create manifest list
docker manifest push <name>                # Push manifest
```

---

## 9. Critical Operations (⚠️ Use Caution!)
```bash
# REMOVE ALL IMAGES AND CONTAINERS
docker rm -f $(docker ps -aq) && docker rmi -f $(docker images -q)

# Full system cleanup (including volumes):
docker system prune -a --volumes

# WARNING: These commands permanently delete data!
# Always verify backups before running destructive operations.
```



---

## 10. Docker Swarm Orchestration
### Cluster Management
```bash
docker swarm init [--advertise-addr <IP>]      # Initialize swarm
docker swarm join-token [worker|manager]      # Show join token
docker swarm join --token <token> <IP:port>   # Join swarm
docker node ls                                # List nodes
docker node promote <node>                    # Promote to manager
docker node demote <node>                     # Demote to worker
docker swarm leave [--force]                  # Leave swarm
docker swarm update --autolock=true           # Enable autolock
```

### Service Management
```bash
docker service create [options] <image>       # Create service
  # Common options:
  --name <name>               # Service name
  --replicas <num>            # Number of replicas
  --publish <host:target>     # Publish ports
  --mount type=volume,src=<vol>,dst=<path>  # Mount volumes
  --network <network>         # Attach to network
  --constraint <filter>       # Placement constraints

docker service ls              # List services
docker service ps <service>    # Service tasks
docker service scale <service>=<num>  # Scale service
docker service update [options] <service>  # Update service
docker service rollback <service>    # Rollback to previous version
docker service logs [--follow] <service>  # View logs
docker service rm <service>   # Remove service
```

---

## 11. Docker Stack (Swarm Deployments)
### Stack Operations
```bash
docker stack deploy -c compose.yml <stack-name>  # Deploy stack
docker stack ls                     # List stacks
docker stack services <stack-name>  # List stack services
docker stack ps <stack-name>        # Stack tasks
docker stack rm <stack-name>        # Remove stack
```

### Stack Compose Considerations
```yaml
# docker-compose.yml (version 3.8+)
services:
  web:
    image: nginx:latest
    deploy:
      replicas: 3
      update_config:
        parallelism: 2
        delay: 10s
      restart_policy:
        condition: on-failure
    networks:
      - frontend

networks:
  frontend:
    driver: overlay
```

---

## 12. Swarm Networking
```bash
docker network create --driver overlay <network>  # Create overlay network
docker network inspect <network>      # Network details
docker network rm <network>           # Remove network
```

---

## 13. Secrets Management
```bash
docker secret create <name> <file>     # Create from file
echo "pass123" | docker secret create db_pass -  # Create from stdin
docker secret ls                      # List secrets
docker secret inspect <secret>        # Secret details
docker secret rm <secret>             # Remove secret
```

### Using Secrets in Services
```bash
docker service create \
  --name db \
  --secret db_password \
  postgres:latest
```

---

## Key Swarm/Stack Concepts:
1. **Services vs Containers**  
   - Services = Managed containers in swarm mode
   - Automatic load balancing via swarm routing mesh

2. **Task**  
   - Atomic unit of work in swarm (container + commands)

3. **Global vs Replicated Services**  
   ```bash
   docker service create --mode global <image>    # One per node
   docker service create --replicas 3 <image>    # Fixed number
   ```

4. **Health Checks**  
   ```yaml
   healthcheck:
     test: ["CMD", "curl", "-f", "http://localhost"]
     interval: 30s
     timeout: 10s
     retries: 3
   ```

---

## Complete Workflow Example
1. Initialize Swarm
   ```bash
   docker swarm init --advertise-addr 192.168.0.100
   ```

2. Create Overlay Network
   ```bash
   docker network create -d overlay my-overlay
   ```

3. Deploy Stack
   ```bash
   docker stack deploy -c docker-compose.yml myapp
   ```

4. Monitor Services
   ```bash
   watch docker service ls
   ```

5. Scale Service
   ```bash
   docker service scale myapp_web=5
   ```

6. Update Stack
   ```bash
   docker stack deploy -c docker-compose-v2.yml myapp
   ```

---

## Important Notes:
- **Swarm Mode Requirements**:  
  - All nodes must have Docker 1.12+  
  - Open ports: TCP/2377 (management), TCP/7946 & UDP/7946 (node communication), UDP/4789 (overlay)

- **Stack vs Compose**:  
  | Feature            | Docker Compose | Docker Stack  |
  |--------------------|----------------|---------------|
  | Environment        | Local machine  | Swarm cluster |
  | Deployments        | Containers     | Services      |
  | Compose version    | Up to 3.8      | 3.0+          |
  | Volumes            | Local          | Named volumes |


---
## 14. Docker file 
a comprehensive Dockerfile that includes all key Docker instructions.


```dockerfile
# ==============================================================
# METADATA & CONFIGURATION INSTRUCTIONS (No Filesystem Layers)
# ==============================================================

# 1. FROM: Base image (required for all Dockerfiles)
FROM alpine:latest AS builder

# 2. LABEL: Add metadata (key-value pairs)
LABEL maintainer="admin@example.com" \
      description="Production App" \
      license="MIT"

# 3. ENV: Persistent environment variables (runtime)
ENV NODE_ENV=production \
    APP_PORT=3000

# 4. ARG: Build-time variables (not persisted in final image)
ARG BUILD_VERSION=1.0

# 5. EXPOSE: Document ports the container listens on
EXPOSE 3000 80

# 6. USER: Set runtime user/group (security best practice)
USER appuser:appgroup

# 7. SHELL: Override default shell for RUN/CMD/ENTRYPOINT
SHELL ["/bin/bash", "-c"]

# 8. ENTRYPOINT: Define the executable (immutable command)
ENTRYPOINT ["npm"]

# 9. CMD: Default arguments for ENTRYPOINT (can be overridden)
CMD ["start"]

# 10. ONBUILD: Trigger for child images
ONBUILD COPY --chown=appuser:appgroup . /app

# 11. STOPSIGNAL: Signal sent to stop the container
STOPSIGNAL SIGTERM

# 12. HEALTHCHECK: Monitor container health
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl --fail http://localhost:3000 || exit 1


# ==============================================================
# FILESYSTEM & LAYER-CREATING INSTRUCTIONS
# ==============================================================

# 13. WORKDIR: Set working directory (creates dir if missing)
WORKDIR /app

# 14. COPY: Copy files with ownership control (preferred over ADD)
COPY --chown=appuser:appgroup package.json .

# 15. ADD: Auto-extract TAR/ZIP or fetch remote URLs
ADD https://example.com/data.tar.gz /tmp

# 16. RUN: Execute commands during build
RUN npm install --production && \
    chmod -R 755 /app

# 17. VOLUME: Declare persistent storage mount points
VOLUME ["/app/data", "/logs"]

# 18. Multi-stage build: Copy artifacts from previous stage
FROM alpine:latest AS final
COPY --from=builder /app /app


# ==============================================================
# DEPRECATED & RARE INSTRUCTIONS (Included for completeness)
# ==============================================================

# 19. MAINTAINER: Deprecated (use LABEL instead)
MAINTAINER legacy-maintainer@example.com
```

---

### Explanation of Added/Important Instructions:

1. **`STOPSIGNAL`**  
   - Specifies the system call signal sent to stop the container (e.g., `SIGTERM` or `SIGKILL`).

2. **`HEALTHCHECK`**  
   - Defines a command to monitor container health (e.g., check if an API endpoint is responsive).

3. **`ADD` vs `COPY`**  
   - `COPY` is preferred for simplicity, but `ADD` can auto-extract archives or fetch remote URLs.

4. **Multi-Stage Builds**  
   - Uses multiple `FROM` statements to separate build and runtime environments, reducing final image size.

5. **`--chown` in `COPY`/`ADD`**  
   - Sets file ownership during copy (better than `RUN chown` for security and layer optimization).

6. **`VOLUME`**  
   - Declares mount points for persistent data (avoids data loss when container restarts).

---

### Best Practices Embedded:
- **Security**: Non-root `USER`, `--chown`, and `chmod` in `RUN`.  
- **Layer Caching**: Order stable operations (e.g., `COPY package.json`) before volatile steps (e.g., `COPY .`).  
- **Multi-Stage**: Reduces bloat by discarding build tools in the final image.  
- **`.dockerignore`**: Not shown here, but always include one to exclude unnecessary files (e.g., `node_modules`).

---

### Final Notes:
- **Deprecated**: Avoid `MAINTAINER`; use `LABEL` instead.  
- **Order Matters**: Metadata instructions early, layer-heavy steps later.  
- **Minimize Layers**: Combine related `RUN` commands with `&&` and `\`.

---

