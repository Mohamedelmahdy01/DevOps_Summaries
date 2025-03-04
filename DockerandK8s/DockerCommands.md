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

- **`docker rmi -f $(docker images -q)`**  
To remove **all Docker images** from your system, you can use the following command:

```bash
docker rmi -f $(docker images -q)
```

### Explanation:
1. **`docker images -q`**:
   - Lists all image IDs (`-q` flag returns only the image IDs).
2. **`docker rmi -f`**:
   - Removes images forcefully (`-f` flag ensures even running containers' images are removed).

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


1


To remove **all Docker images** from your system, you can use the following command:

```bash
docker rmi -f $(docker images -q)
```

### Explanation:
1. **`docker images -q`**:
   - Lists all image IDs (`-q` flag returns only the image IDs).
2. **`docker rmi -f`**:
   - Removes images forcefully (`-f` flag ensures even running containers' images are removed).

---

### Additional Commands:
1. **Remove All Containers** (if you also want to clean up containers):
   ```bash
   docker rm -f $(docker ps -aq)
   ```
   - `docker ps -aq`: Lists all container IDs (including stopped ones).
   - `docker rm -f`: Forcefully removes containers.

2. **Remove All Unused Objects** (images, containers, volumes, networks):
   ```bash
   docker system prune -a --volumes
   ```
   - `prune`: Removes unused objects.
   - `-a`: Removes all unused images (not just dangling ones).
   - `--volumes`: Also removes unused volumes.

---

### WARNING:
- These commands will **delete all Docker images and containers** on your system. Use them carefully!
- If you have important data in containers or volumes, back it up before running these commands.