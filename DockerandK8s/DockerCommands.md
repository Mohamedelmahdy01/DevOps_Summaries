# **Docker Command Cheat Sheet with Examples**

## **1. Docker System and Version Commands**  
These commands help you manage and get information about Docker’s setup and environment.

- **`docker version`**  
  Displays the Docker version installed.

  ```sh
  docker version
  ```

- **`docker info`**  
  Provides detailed information about the Docker installation.

  ```sh
  docker info
  ```

- **`docker system df`**  
  Shows disk usage information for Docker resources.

  ```sh
  docker system df
  ```

- **`docker system prune [OPTIONS]`**  
  Removes unused data like containers, images, and volumes.

  - **Example (remove all unused data, including volumes):**
    ```sh
    docker system prune -a --volumes
    ```

---

## **2. Docker Image Commands**  
Images are templates used to create containers.

- **`docker images [OPTIONS]`**  
  Lists all local Docker images.

  ```sh
  docker images
  ```

- **`docker pull <image>`**  
  Downloads a Docker image from Docker Hub or another registry.

  ```sh
  docker pull nginx
  ```

- **`docker build [OPTIONS] <path>`**  
  Builds an image from a Dockerfile.

  ```sh
  docker build -t myapp:latest .
  ```

- **`docker rmi [OPTIONS] <image>`**  
  Removes an image.

  ```sh
  docker rmi nginx
  ```

- **`docker tag <image> <new_tag>`**  
  Assigns a new tag to an image.

  ```sh
  docker tag myapp:latest myapp:v2
  ```

---

## **3. Docker Container Commands**  
Containers are instances of images that run applications.

- **`docker run [OPTIONS] <image> [COMMAND]`**  
  Creates and starts a new container.

  ```sh
  docker run -d -p 80:80 --name mynginx nginx
  ```

  - **Common options:**  
    - `-d`: Run in detached mode.  
    - `-p <host_port>:<container_port>`: Map ports.  
    - `--name <name>`: Assign a container name.  
    - `-v <host_path>:<container_path>`: Mount a volume.  
    - `-e <env_var>`: Set environment variables.

- **`docker ps [OPTIONS]`**  
  Lists running containers.

  ```sh
  docker ps
  ```

  - **To list all containers (including stopped):**
    ```sh
    docker ps -a
    ```

- **`docker stop <container>`**  
  Stops a running container.

  ```sh
  docker stop mynginx
  ```

- **`docker start <container>`**  
  Starts a stopped container.

  ```sh
  docker start mynginx
  ```

- **`docker restart <container>`**  
  Restarts a running container.

  ```sh
  docker restart mynginx
  ```

- **`docker rm [OPTIONS] <container>`**  
  Removes a container.

  ```sh
  docker rm mynginx
  ```

- **`docker exec [OPTIONS] <container> <command>`**  
  Runs a command inside an existing container.

  ```sh
  docker exec -it mynginx bash
  ```

- **`docker logs [OPTIONS] <container>`**  
  Fetches the logs of a container.

  ```sh
  docker logs -f mynginx
  ```

  - **Follow real-time logs:**
    ```sh
    docker logs -f mynginx
    ```

- **`docker inspect <container>`**  
  Displays detailed information about a container.

  ```sh
  docker inspect mynginx
  ```

---

## **4. Docker Volume Commands**  
Volumes are used for persistent data storage.

- **`docker volume create <volume>`**  
  Creates a new volume.

  ```sh
  docker volume create myvolume
  ```

- **`docker volume ls`**  
  Lists all volumes.

  ```sh
  docker volume ls
  ```

- **`docker volume inspect <volume>`**  
  Displays information about a volume.

  ```sh
  docker volume inspect myvolume
  ```

- **`docker volume rm <volume>`**  
  Removes a volume.

  ```sh
  docker volume rm myvolume
  ```

---

## **5. Docker Network Commands**  
Networks allow communication between containers.

- **`docker network create <network>`**  
  Creates a new network.

  ```sh
  docker network create mynetwork
  ```

- **`docker network ls`**  
  Lists all networks.

  ```sh
  docker network ls
  ```

- **`docker network inspect <network>`**  
  Displays details of a network.

  ```sh
  docker network inspect mynetwork
  ```

- **`docker network connect <network> <container>`**  
  Connects a container to a network.

  ```sh
  docker network connect mynetwork mynginx
  ```

- **`docker network disconnect <network> <container>`**  
  Disconnects a container from a network.

  ```sh
  docker network disconnect mynetwork mynginx
  ```

---

## **6. Docker Compose Commands**  
Docker Compose simplifies multi-container deployments.

- **`docker-compose up [OPTIONS]`**  
  Builds and starts containers defined in a `docker-compose.yml` file.

  ```sh
  docker-compose up -d
  ```

  - **Options:**  
    - `-d`: Detached mode (background).  
    - `--build`: Force rebuild of images.

- **`docker-compose down [OPTIONS]`**  
  Stops and removes containers and networks created by `up`.

  ```sh
  docker-compose down
  ```

- **`docker-compose logs [OPTIONS]`**  
  Displays logs for containers managed by Docker Compose.

  ```sh
  docker-compose logs -f
  ```

- **`docker-compose ps`**  
  Lists containers managed by Docker Compose.

  ```sh
  docker-compose ps
  ```

---

## **7. Docker Registry Commands**  
Manage interactions with Docker registries.

- **`docker login`**  
  Logs into a Docker registry.

  ```sh
  docker login
  ```

- **`docker logout`**  
  Logs out from a Docker registry.

  ```sh
  docker logout
  ```

- **`docker push <image>`**  
  Uploads an image to a registry.

  ```sh
  docker push myapp:latest
  ```

- **`docker search <term>`**  
  Searches for images on Docker Hub.

  ```sh
  docker search nginx
  ```

---

## **8. Advanced Docker Commands**

- **`docker stats [OPTIONS]`**  
  Displays real-time resource usage of containers.

  ```sh
  docker stats
  ```

- **`docker commit <container> <new_image>`**  
  Creates a new image from a container's changes.

  ```sh
  docker commit mynginx mycustomnginx
  ```

- **`docker export <container>`**  
  Exports a container's filesystem as a tar archive.

  ```sh
  docker export mynginx > mynginx.tar
  ```

- **`docker import <tarball> <new_image>`**  
  Creates an image from a tarball.

  ```sh
  docker import mynginx.tar mynginx:v1
  ```

---






### **Docker Architecture**  

Docker operates using a client-server architecture, consisting of key components that manage containers, images, volumes, and networks. Below is a detailed breakdown of Docker's architecture, components, and their roles.

---

### **1. Docker Components: Runtime, Daemon, and Orchestrator**  

#### **1.1 The Runtime: runc and containerd**  

The runtime is responsible for creating and managing containers by interacting directly with the host’s kernel and hardware. Docker uses a two-level runtime system:

##### **a. runc:**  
- **Definition:**  
  `runc` is a lightweight, low-level container runtime compliant with the Open Container Initiative (OCI) runtime specifications.  
- **Responsibilities:**  
  - Starts and stops containers based on OCI-compliant configurations.  
  - Sets up namespaces and control groups (cgroups) for container isolation.  

##### **b. containerd:**  
- **Definition:**  
  `containerd` is a higher-level container runtime that manages the lifecycle of containers, interacting with `runc`. It is maintained by the Cloud Native Computing Foundation (CNCF).  
- **Responsibilities:**  
  - Pulls images from registries.  
  - Creates and manages network interfaces for containers.  
  - Handles container storage and volumes.  
  - Delegates actual container management to `runc`.  

---

### **1.2 Docker Daemon (dockerd)**  

The Docker daemon, `dockerd`, is the core service that listens for Docker API requests and manages Docker objects like containers, images, and networks. It runs in the background and handles communication between the client and the underlying container runtimes.

- **Functions:**  
  - **Image Management:** Pulls, pushes, and manages image layers.  
  - **Container Management:** Creates, runs, stops, and removes containers.  
  - **Volume and Network Management:** Creates and attaches volumes and networks to containers.  
  - **API Exposure:** Exposes a REST API for external interactions.

---

### **1.3 The Orchestrator: Docker Swarm**  

An orchestrator manages clusters of containers across multiple nodes. Docker Swarm is Docker’s native orchestration tool.

- **Cluster Management:**  
  A swarm consists of multiple nodes:
  - **Manager Nodes:** Schedule tasks and manage cluster state.
  - **Worker Nodes:** Execute tasks assigned by the manager nodes.

- **Key Features:**  
  - **Scalability:** Easily scale services up or down.  
  - **High Availability:** Distributes workloads across nodes for redundancy.  
  - **Load Balancing:** Balances traffic between running containers.  
  - **Self-Healing:** Automatically restarts failed containers.

---

### **2. Docker Client-Server Architecture**  

Docker uses a client-server model where the Docker client communicates with the Docker daemon (server).

#### **Docker Client:**  
- The Docker client (`docker`) is the primary interface for users to interact with Docker. It sends commands to the Docker daemon.  
- Common commands:  
  - `docker build`: Build images from a Dockerfile.  
  - `docker run`: Create and run containers from images.  
  - `docker ps`: List running containers.

#### **Docker Daemon:**  
- The daemon (`dockerd`) handles all the heavy lifting, such as managing images, containers, and networks. It interacts with `containerd` and `runc` to manage the lifecycle of containers.

---

### **3. Docker Objects**  

Docker manages several types of objects:

#### **3.1 Images:**  
- Images are read-only templates used to create containers. They consist of layers, with each layer representing an instruction in the Dockerfile.  
- **Commands:**  
  - `docker pull`: Pull an image from a registry.  
  - `docker build`: Build an image from a Dockerfile.

#### **3.2 Containers:**  
- Containers are runnable instances of images, providing an isolated environment with their own filesystem, network, and resources.  
- **Commands:**  
  - `docker start`: Start a stopped container.  
  - `docker stop`: Stop a running container.  
  - `docker exec`: Run a command inside a container.

#### **3.3 Volumes:**  
- Volumes are used for persistent storage, allowing data to survive container restarts.  
- **Commands:**  
  - `docker volume create`: Create a new volume.  
  - `docker volume ls`: List available volumes.

#### **3.4 Networks:**  
- Docker networks enable communication between containers.  
- Types of networks:  
  - **Bridge:** Default network type.  
  - **Host:** Shares the host’s networking namespace.  
  - **Overlay:** Enables multi-host networking for Swarm services.  
- **Commands:**  
  - `docker network create`: Create a network.  
  - `docker network connect`: Connect a container to a network.

---

### **4. Docker Compose**  

Docker Compose is a tool for defining and managing multi-container applications using a YAML file (`docker-compose.yml`).

- **Usage:**  
  - Define services, networks, and volumes in a single file.  
  - Run the entire application stack with one command: `docker-compose up`.  
- **Example:**
  ```yaml
  version: '3'
  services:
    web:
      image: nginx
      ports:
        - "80:80"
    db:
      image: mysql
      environment:
        MYSQL_ROOT_PASSWORD: example
  ```

---

### **5. Docker Registry**  

A Docker registry stores Docker images. Docker Hub is the default public registry, but private registries can be set up.

- **Commands:**  
  - `docker push`: Push an image to a registry.  
  - `docker pull`: Pull an image from a registry.

---

### **6. Open Container Initiative (OCI)**  

The **Open Container Initiative (OCI)** is a project under the Linux Foundation that establishes open standards for container formats and runtimes.

- **Key Standards:**  
  - **Runtime Specification:** Defines how containers should be run.  
  - **Image Specification:** Defines how images are built and distributed.  
- **Example Implementations:**  
  - `runc` is a reference implementation of the OCI runtime spec.

---

### **7. Summary of Docker Components**

| **Component**       | **Role**                                             | **Examples/Tools**        |
|---------------------|------------------------------------------------------|---------------------------|
| **Runtime**          | Manages container lifecycle and isolation.           | `runc`, `containerd`      |
| **Daemon**           | Core service managing Docker objects.                | `dockerd`                 |
| **Orchestrator**     | Manages container clusters and scaling.              | Docker Swarm, Kubernetes  |
| **Client**           | User interface for Docker commands.                  | Docker CLI (`docker`)     |
| **Registry**         | Stores and distributes container images.             | Docker Hub, Private Registry |

---

### **Conclusion:**  

Docker provides a robust architecture for containerization, offering flexibility, scalability, and efficiency. Understanding its core components, from the runtime and daemon to orchestration, is crucial for managing and deploying containerized applications effectively.

