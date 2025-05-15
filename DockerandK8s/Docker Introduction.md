# Docker Deep Dive

<img src="./images/book.jpeg" alt="book cover" width="300" align="left"/>
<img src="./images/NigelPoulton.jpg" alt="Nigel Poulton" width="314" align="left"/>

**[Docker Deep Dive: Zero to Docker in a single book](https://www.amazon.com/gp/product/B01LXWQUFF/ref=dbs_a_def_rwt_bibl_vppi_i1)**

---

## Virtualization
- **HW-Level Virtualization**
  - Network Virtualization
  - Storage Virtualization
  - Server Virtualization
- **Application Virtualization**
- **OS-Level Virtualization**

---

## 1: Containers from 30,000 Feet
### The Bad Old Days
### Hello VMWare!
### Hello Containers!
- **Linux Subsystems**
- **Mainframe**

### Hello Docker!
- **Docker, Inc. (Founded in 2013)**
- **Windows Containers**
- **[Docker on GitHub](https://github.com/docker)**

### Windows vs Linux Containers
### Mac Containers
### Kubernetes Overview

---

## 2: Docker
### Docker - The TLDR
- Runs on Windows/Linux
- Create, manage, and orchestrate containers
- Developed by Docker, Inc.

### Docker, Inc.
<img src="./images/1.png" alt="Docker Inc. timeline" width="300" align="left"/>
- Originally dotCloud (PaaS provider)
- Transitioned to Docker in 2013
- Key Products:
  - Docker Desktop
  - Docker Hub

### Docker Technology Architecture
<img src="./images/2.png" alt="Docker architecture" width="900"/>

#### 1. The Runtime
- `runc`: OCI-compliant runtime
- `containerd`: Manages lifecycle, images, networks

#### 2. The Daemon (`dockerd`)
- Manages images, volumes, networks
- Exposes Docker API

#### 3. Orchestration
- Native Swarm mode for cluster management

---

## 3: Installing Docker
### Supported Platforms
- **Docker Desktop**: Windows 10, macOS
- **Server Installs**: Linux, Windows Server
- **Play with Docker Lab**

### Linux Installation (Ubuntu)
```bash
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

**[Play with Docker](https://labs.play-with-docker.com/)**

---

## 4: The Big Picture
### Ops Perspective
- Image management: `docker image pull`, `docker container run`
- **Example Commands**:
  ```bash
  docker container run -it ubuntu:latest /bin/bash
  docker container exec -it <container> bash
  ```

### Dev Perspective
- Build images from Dockerfiles:
  ```bash
  git clone https://github.com/elmahdy/psweb.git
  docker image build -t web:latest .
  ```

---

## 5: The Docker Engine
### Core Components
<img src="./images/5.png" alt="Docker Engine" width="900"/>

- **`dockerd`**: Daemon process
- **`containerd`**: Container runtime
- **`runc`**: OCI runtime

### Security
- Secure daemon communication with TLS
- **[Protecting Docker Daemon Socket](https://docs.docker.com/engine/security/protect-access/)**

---

## 6: Images
### Key Concepts
- Immutable layers
- Pull from registries (e.g., Docker Hub)
- **Example**:
  ```bash
  docker image pull alpine:latest
  docker image inspect alpine
  ```

### Multi-Architecture Images
- Use `docker manifest inspect` to check platform support

---

## 7: Containers
### Lifecycle Management
- Start/stop containers:
  ```bash
  docker container run -d --name web1 -p 8080:8080 web:latest
  docker container stop web1
  ```

### Self-Healing with Restart Policies
- `always`, `unless-stopped`, `on-failure`

---

## 8: Containerizing Apps
### Dockerfile Example
```Dockerfile
FROM alpine:latest
RUN apk add --update nodejs npm
COPY . /src
WORKDIR /src
RUN npm install
EXPOSE 8080
ENTRYPOINT ["node", "./app.js"]
```

### Multi-Stage Builds
```Dockerfile
# Build stage
FROM node:latest AS build
COPY . .
RUN npm install && npm run build

# Production stage
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
```

---

## 9: Docker Compose
### Example `docker-compose.yml`
```yaml
version: "3.8"
services:
  web:
    build: .
    ports:
      - "5000:5000"
  redis:
    image: "redis:alpine"
```

### Commands
```bash
docker-compose up -d
docker-compose down
```

---

## 10: Docker Networking
### Network Types
- **Bridge**: Default network for single-host communication
- **Overlay**: Multi-host networking for Swarm
- **Macvlan**: Direct MAC-level network access

### Create a Network
```bash
docker network create -d bridge mynet
```

---

## 11: Volumes
### Persistent Data Management
```bash
docker volume create myvol
docker run -d --name app --mount source=myvol,target=/data nginx:latest
```

---

## 12: Security Best Practices
- Use non-root users in containers
- Scan images for vulnerabilities with `docker scan`
- Limit container capabilities with `--cap-drop`

---

# Updated Repositories and Usernames
- Changed `asami76` to **`elmahdy`** in all Docker Hub references:
  ```bash
  docker image tag web:latest elmahdy/newweb:latest
  docker push elmahdy/newweb:latest
  ```
- Updated Docker Hub links:  
  [elmahdy/web on Docker Hub](https://hub.docker.com/repository/docker/elmahdy/web)

---

# Used Images
- **Microsoft Official Images**:  
  [Docker Hub - Microsoft](https://hub.docker.com/publishers/microsoftowner)


---