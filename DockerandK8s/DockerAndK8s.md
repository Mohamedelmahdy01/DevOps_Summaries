# Containers vs. Virtual Machines

Containers and virtual machines are both virtualization technologies, enabling a system’s resources (like RAM, CPU, Disk, or Networking) to be “virtualized” and represented as multiple, independent resources. The main difference is that virtual machines virtualize the entire machine down to the hardware level, whereas containers virtualize only the software layers above the operating system.

![Containers vs Virtual Machines](./Img/SWTM-2060_Diagram_Containers_VirtualMachines_v03.png)

## What is a Container?

Containers are lightweight software packages that include all dependencies required to execute the contained software application. These dependencies include system libraries, external third-party code packages, and other operating system level applications. The dependencies in a container exist in stack layers higher than the operating system.

### Pros of Containers

- **Iteration Speed**: Containers are lightweight and include only high-level software, making them quick to modify and iterate.
- **Robust Ecosystem**: Most container runtime systems offer a hosted repository of pre-made containers with popular applications (like databases and messaging systems) that can be instantly downloaded, saving development time.

### Cons of Containers

- **Shared Host Exploits**: Containers share the same underlying hardware and OS, so a vulnerability in one container could potentially affect the shared hardware. Using public container images from repositories like Docker Hub introduces security risks, as they may contain vulnerabilities or be susceptible to hijacking.

### Popular Container Providers

- **Docker**: The most widely-used container runtime, with a large public repository of containerized applications on Docker Hub.
- **RKT**: Pronounced "Rocket," it’s a security-focused container runtime that restricts insecure features by default.
- **Linux Containers (LXC)**: An open-source Linux container runtime for isolating OS-level processes, often used as a foundation for Docker.
- **CRI-O**: An implementation of the Kubernetes Container Runtime Interface (CRI) for using Open Container Initiative (OCI) compatible runtimes, providing a lightweight alternative to Docker in Kubernetes.

## What is a Virtual Machine?

Virtual machines (VMs) are more resource-heavy software packages that provide complete emulation of low-level hardware components like CPU, disk, and networking. VMs may also include an OS and software stack, resulting in a fully functional virtualized system.

### Pros of Virtual Machines

- **Full Isolation Security**: VMs operate as fully isolated systems, protecting them from interference by other VMs on the same host. Though a VM could be compromised, it won’t affect other VMs on the host.
- **Interactive Development**: Unlike containers, VMs allow dynamic, interactive development. Once the hardware setup is specified, software can be installed, and the VM can be snapshotted for future restoration or duplication.

### Cons of Virtual Machines

- **Iteration Speed**: Building or regenerating VMs can be time-consuming due to their full stack nature.
- **Storage Size Cost**: VMs often consume substantial storage, which can lead to disk space shortages on the host system.

### Popular Virtual Machine Providers

- **VirtualBox**: A free, open-source x86 emulator from Oracle, popular for its extensive ecosystem of tools.
- **VMware**: Known for enterprise-level virtualization with a hypervisor for managing multiple VMs and a robust UI.
- **QEMU**: A fast, command-line utility supporting generic hardware architecture emulation but lacking a GUI.

## Which Option is Better?

If your project has specific hardware requirements or you’re developing on one platform and need to target another (e.g., Windows vs. macOS), a virtual machine is recommended. However, most “software-only” needs can be met with containers.

## Using Containers and Virtual Machines Together

It’s possible to use containers and VMs together, although this is generally limited to specific use cases. For example, you could create a VM that emulates specific hardware, install an OS, and then run containers on top of it. This setup is useful for experimenting with system-on-chip deployments (e.g., Raspberry Pi emulation). However, in most cases, choosing either containers or VMs based on your resource needs and trade-offs will suffice.

## Differences Between VM Base Images and Container Images

The **base image** concept differs between virtual machines (VMs) and containers in the scope and components it includes.

### VM Base Image
A **VM base image** typically includes:
- The **entire operating system (OS)** (e.g., Linux, Windows).
- Low-level **hardware virtualization** (like CPU, memory, and network drivers).
- A basic **software stack** that runs on the emulated hardware, such as system utilities and default OS tools.

A VM base image is usually several gigabytes in size, as it simulates a full, independent computing environment. The VM image allows for extensive customization (e.g., adding software or configuring network settings) and is useful for cases where you need to emulate specific hardware or want a high degree of isolation.

### Container Image
A **container image**, on the other hand:
- **Shares the host OS kernel** (Linux or Windows) rather than including its own kernel, which is key to keeping containers lightweight.
- Includes only the **application code** and **necessary dependencies** (e.g., libraries and runtime environments) required for the application to run.
- Is built from a **Dockerfile** (or similar configuration) that specifies the layers and dependencies.

Container images are typically smaller and faster to deploy because they don’t carry the full OS stack. They’re also more lightweight and portable, as they focus only on the application layer and don’t include unnecessary system components.

### Key Differences
| Aspect              | VM Base Image                                          | Container Image                                     |
|---------------------|--------------------------------------------------------|-----------------------------------------------------|
| **OS Inclusion**    | Includes full OS                                       | Shares host OS kernel                               |
| **Size**            | Larger (often several GB)                              | Smaller (often in MBs)                              |
| **Isolation Level** | High (isolated hardware emulation)                     | Lower (shares resources with host)                  |
| **Use Case**        | Hardware emulation, OS-level isolation                 | Lightweight application packaging, fast deployment  |

In summary, VM base images simulate a full environment including the OS, while container images focus solely on the app and its dependencies, relying on the host OS to save resources.

## Namespaces and CGroups

In both **CGroups** and **Namespaces**, we have recorded in the **Linux** operating system that play a role in managing and isolating system resources, and are secondarily essential in the famous **Virtual Machines** and **Containers**. Here is how each of them works in machines and containers.

### 1. CG Groups (Control Groups)
**CGroups** is short for **Control Groups**, and is used to control the **allocation of resources** such as CPU, memory, disk, and various transaction network.

- **Conditional**:
- CGroups work to set maximum resource consumption limits for each container, so that resources can be distributed fairly and stimulate one container from consuming all available resources.
- For example, a certain percentage of CPU or RAM can be allocated to one container, allowing it to affect and the system is ready.

- **By default**:
- Automatically rely on CGroups when running on the same restaurant. Resources are allocated separately to each virtual machine separately so that they do not interfere in resource usage.
- CGroups are implemented at the core operating system layers, allowing the resource manager to configure and monitor virtual resources.

### 2. Namespaces (Namespaces)
**Namespaces** are the reason why you can isolate experimental domain names, so that each **process group** has its own namespace, allowing successful isolation.

- **Conditional**:
- Container namespaces provide a completely isolated environment in terms of **processing, networking, and filesystems**. A container has:
- **Network Namespace**: Its own network, meaning it has a different IP address and private network programs.
- **PID Namespace**: Isolated for processes so that each container has its own currencies.
- **Mount Namespace**: A private filesystem so that file paths starting in one container are usually invisible to the other.
- This isolation allows each workcoupon to have its own completely independent systems without affecting the other qualifier or the underlying system.

- **By default**:
- Usually relies on the hypervisor for isolation, but when special names are needed, namespaces are used at the platform level.
- Sometimes, namespace isolation is used in higher-level relationships, especially in network systems, where internal networks of smart devices can be isolated from other networks.

### Conclusion
- **CGroups** provide resource management and prevent resource overuse.
- **Namespaces** provide the need for environmental isolation, allowing processes, networks, and file systems to be managed separately for each container or virtual machine.


## Namespaces and cgroups to Control Docker Performance

To control Docker container performance using Linux namespaces and control groups (cgroups), let’s break down the main steps:

### 1. **Linux Namespaces for Isolation**
Namespaces provide process isolation within Docker, giving each container its own view of system resources.

- **Types of Namespaces in Docker**:
  - **PID** (Process ID): Isolates process numbers.
  - **Network**: Separates network interfaces for each container.
  - **Mount**: Provides unique filesystem views.
  - **User**: Isolates user IDs, which improves security.

- **Usage Example**:
  By default, Docker assigns the root user in the container to the host's root (UID 0). This can be dangerous since it can grant the container access to sensitive files on the host. Using **user namespaces** remaps container users to less privileged UIDs on the host.

- **Implementation**:
  1. Confirm user namespaces support with:
     ```bash
     grep -E '^CONFIG_USER_NS=' /boot/config-$(uname -r)
     ```
  2. Enable Docker’s user namespace remapping by adding `"userns-remap": "default"` in `/etc/docker/daemon.json`.
  3. Restart Docker and test file access from a container. With namespaces enabled, it should now show “Permission denied” for restricted host files.

### 2. **Linux cgroups for Resource Management**
Cgroups allow Docker to control CPU, memory, and I/O usage among containers.

- **Setting up Resource Limits**:
  - **CPU Limits**: Control CPU usage by using the `--cpus` option. For example:
    ```bash
    docker run --cpus 0.5 -d nginx
    ```
  - **Memory Limits**: Control memory with the `--memory` option:
    ```bash
    docker run --memory=512m -d nginx
    ```

- **Cgroup Versions**:
  Determine if your system uses **cgroup v1** or **cgroup v2**:
  ```bash
  test -f /sys/fs/cgroup/cgroup.controllers && echo "cgroup v2" || echo "cgroup v1"
  ```
  - For cgroup v1, look in `/sys/fs/cgroup/memory/docker/<container_id>/`.
  - For cgroup v2, find data in `/sys/fs/cgroup/system.slice/docker-<container_id>.scope/`.

Using these configurations with namespaces and cgroups helps enhance Docker’s security by isolating containers and controlling resource usage, making it an effective solution for performance tuning in high-density environments.

---

Here's a comprehensive document combining the topics discussed in both files on Docker:

---

# **Docker Introduction**

## What is Docker?

Docker is an open platform designed to develop, ship, and run applications. It enables developers to package applications and their dependencies into isolated environments called containers. This consistency between development and production environments helps streamline software delivery and reduce deployment issues. Docker simplifies the deployment process, making it faster and more reliable across different infrastructures, such as on-premises, cloud, or hybrid environments.

## Problem and Why Docker?

### Key Challenges Without Docker

1. **Inconsistent Environments**:  
   Applications may work in one environment but fail in another due to differences in libraries, dependencies, or configurations. Docker ensures consistency across various environments, avoiding the “it works on my machine” problem.

2. **Dependency Conflicts**:  
   Managing dependencies manually can cause conflicts, particularly when different applications require different versions of the same library.

3. **Complex Setup**:  
   Setting up environments without Docker can be time-consuming and error-prone. Docker packages all dependencies into a single container, simplifying setup.

4. **Scalability Issues**:  
   Scaling applications without Docker can be challenging, while Docker enables easy horizontal scaling by running multiple containers.

5. **Resource Inefficiency**:  
   Running applications directly on the host system without isolation can lead to inefficient resource use. Docker containers share the host system’s kernel, making them more lightweight and resource-efficient than virtual machines.

### Examples

- **Developer Onboarding**:  
  A new developer can easily set up an application’s environment using Docker without complex installations or version downgrades, reducing setup time.
  
- **Consistent Deployment**:  
  Docker ensures that applications behave the same across testing, staging, and production environments, reducing unexpected issues during deployment.

## Docker’s Key Benefits

1. **Consistency Across Environments**:  
   Docker containers provide a uniform environment that behaves the same on a developer’s machine, in a test setup, or in production.

2. **Isolation**:  
   Containers run independently from each other and the host system, preventing interference between applications.

3. **Resource Efficiency**:  
Unlike virtual machines, Docker containers share the host OS’s kernel, making them lightweight and efficien.
=======
   Unlike virtual machines, Docker containers share the host OS’s kernel, making them lightweight and efficient.

4. **Portability**:  
   Docker containers are highly portable, allowing easy migration across different environments.

5. **Scalability**:  
   Docker supports scaling applications by running multiple containers, either on a single host or distributed across several hosts.

6. **Streamlined Development & Deployment**:  
   Docker provides a consistent environment that simplifies development, testing, and deployment processes, making it ideal for CI/CD workflows.

Understood! I will reorganize the content without cutting down on details. I'll focus on improving structure and flow while keeping everything intact. I'll send the updated sections progressively. Let's begin with **Docker Components: Runtime, Daemon, and Orchestrator**.

---

## The Docker Platform

Docker enables you to encapsulate an application in a container. Containers hold everything needed to run the application, avoiding dependencies on the host environment and ensuring a stable, reproducible setup.

The Docker platform provides tools for managing the entire container lifecycle:

1. **Develop**: Build and containerize your application and its dependencies.
2. **Distribute**: Test and share your containerized application.
3. **Deploy**: Run your containerized application in any environment, from local systems to cloud infrastructure.


# **Docker Architecture** 

Docker uses a client-server architecture. The Docker client talks to the Docker daemon, which does the heavy lifting of building, running, and distributing your Docker containers. The Docker client and daemon can run on the same system, or you can connect a Docker client to a remote Docker daemon. The Docker client and daemon communicate using a REST API, over UNIX sockets or a network interface. Another Docker client is Docker Compose, that lets you work with applications consisting of a set of containers.


![Docker Components](Img/docker-architecture.png)


---
## **1. Docker Components: Runtime, Daemon, and Orchestrator**

![Docker_Components](Img/Docker_Component.png)
### **1.1 The Runtime: runc and containerd**  

The **Runtime** is responsible for interacting with the host system’s kernel and hardware to create and manage containers. It serves as the bridge between Docker and the underlying system resources.

#### **a. `runc`:**  
- **Definition:**  
  `runc` is a lightweight, low-level container runtime that adheres to the **Open Containers Initiative (OCI)** specifications.
  
- **Key Responsibilities:**  
  - **Start and Stop Containers:**  
    It initializes and terminates containers based on configurations defined in OCI-compliant files.  
  - **OS Constructs:**  
    `runc` sets up essential components such as:
    - **Namespaces:** For process and resource isolation.
    - **Control Groups (cgroups):** To allocate and monitor resources like CPU and memory.
  
#### **b. `containerd`:**  
- **Definition:**  
  `containerd` is a higher-level runtime that manages `runc` and simplifies container lifecycle tasks. It is a CNCF (Cloud Native Computing Foundation) project.

- **Key Responsibilities:**  
  - **Image Management:**  
    Pulls and manages images from container registries (e.g., Docker Hub).  
  - **Container Management:**  
    Delegates tasks such as starting, stopping, and monitoring containers to `runc`.  
  - **Networking:**  
    Sets up network interfaces for container communication.  

---

### **1.2 The Daemon (`dockerd`):**  

The **Docker Daemon** (`dockerd`) is the core service that controls and manages all Docker operations. It listens for API requests and interacts with both the Docker CLI and container runtimes.

- **Key Functions:**
  - **Expose the Docker API:**  
    `dockerd` provides a REST API that allows external tools and the Docker CLI to communicate with it.
  - **Manage Images:**  
    Handles pulling, pushing, and deleting images, as well as managing image layers for efficiency.
  - **Manage Volumes:**  
    Creates and manages Docker volumes to persist data across container lifecycles.
  - **Manage Networks:**  
    Configures networks for container communication, supporting various types such as:
    - **Bridge Networks** (default for containers on the same host).  
    - **Overlay Networks** (for multi-host container communication).  
    - **Host Networks** (sharing the host’s network namespace).  
  - **Monitor and Control Containers:**  
    Tracks container states (running, stopped, paused) and manages resource allocation.  

---

### **1.3 The Orchestrator: Swarm**  

Orchestration is critical for managing large-scale container deployments across multiple nodes. Docker’s native orchestration tool is **Swarm**, though Kubernetes is also widely used.

#### **Docker Swarm Overview:**  
- **Definition:**  
  Swarm transforms a group of Docker hosts into a single virtual cluster, where tasks can be distributed and managed efficiently.

- **Key Concepts:**  
  - **Nodes:**  
    - **Manager Nodes:** Handle cluster management and scheduling.  
    - **Worker Nodes:** Execute tasks assigned by managers.  
  - **Services and Tasks:**  
    - A **service** defines how a container should run.  
    - A **task** is an individual instance of a service running on a node.  
  - **Load Balancing:**  
    Distributes workloads evenly across nodes.  
  - **Self-Healing:**  
    Automatically restarts or reschedules failed tasks.

#### **Why Orchestration Matters:**  
- **Scalability:**  
  Easily scale services by adding more nodes or containers.  
- **High Availability:**  
  Ensures minimal downtime by redistributing tasks if a node fails.  
- **Automation:**  
  Simplifies container deployment and management across multiple environments.


## **2. Docker Client-Server Architecture**  

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

## **3. Docker Objects**  

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

## **4. Docker Compose**  

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

## **5. Docker Registry**  

A Docker registry stores Docker images. Docker Hub is the default public registry, but private registries can be set up.

- **Commands:**  
  - `docker push`: Push an image to a registry.  
  - `docker pull`: Pull an image from a registry.

---

## **6. Open Container Initiative (OCI)**  

The **Open Container Initiative (OCI)** is a project under the Linux Foundation that establishes open standards for container formats and runtimes.

- **Key Standards:**  
  - **Runtime Specification:** Defines how containers should be run.  
  - **Image Specification:** Defines how images are built and distributed.  
- **Example Implementations:**  
  - `runc` is a reference implementation of the OCI runtime spec.

---

## **7. Summary of Docker Components**

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


---
# Install Docker

### **What Can I Use Docker For?**

#### Fast, Consistent Delivery of Applications

Docker streamlines the development lifecycle by providing standardized environments with containers, perfect for CI/CD workflows. Developers can work on code locally and share it via Docker, ensuring consistency across all environments. The application can be tested and validated in containerized test environments and deployed by pushing updated images to production.

#### Responsive Deployment and Scaling

Docker’s container-based approach allows highly portable workloads, making it easy to run containers in various setups, from local machines to cloud providers. This flexibility supports rapid scaling of applications up or down as needed.

#### Efficient Use of Resources

Docker containers are lightweight, making them ideal for high-density environments where resource efficiency is crucial. They allow you to run more workloads on the same hardware, reducing costs and improving performance.



## How to Install Docker

To install Docker on your system, follow the official Docker installation guides:

- **[Install Docker for Windows](https://docs.docker.com/desktop/install/windows-install/)**
- **[Install Docker for macOS](https://docs.docker.com/desktop/install/mac-install/)**
- **[Install Docker for Linux](https://docs.docker.com/engine/install/)**

---

### [Play with Docker](https://labs.play-with-docker.com/)



## Setting Up User Permissions with Docker**

### **1. Confirming Docker Installation:**
- **Command:**
   ```sh
   sudo docker version
   ```
- **Purpose:**  
  Displays the Docker client and server version information, confirming that Docker is installed and running properly.

---

### **2. Adding a User to the Docker Group:**
- **Why?**  
  By default, Docker commands require `sudo` because they need administrative privileges. Adding your user to the **docker** group allows you to run Docker commands without `sudo`.

---

### **3. Steps for Checking and Configuring Permissions:**

#### **(1) Check Existing System Groups:**
- **Command:**
   ```sh
   sudo getent group
   ```
- **Purpose:**  
  Lists all groups on the system, including the **docker** group if it exists.

#### **(2) Check Groups Associated with Your User:**
- **Command:**
   ```sh
   groups
   ```
- **Purpose:**  
  Shows the groups the current user belongs to. This helps confirm if you are already a member of the **docker** group.

#### **(3) Add User to the Docker Group:**
- **Command:**
   ```sh
   sudo usermod -a -G docker <username>
   ```
- **Details:**
   - **`-a`:** Appends the user to the specified group without removing them from other groups.
   - **`-G docker`:** Specifies the **docker** group.
   - **`<username>`:** Replace with your actual username.

- **Example:**
   ```sh
   sudo usermod -a -G docker mohamed
   ```

#### **(4) Verify Group Membership:**
- **Command:**
   ```sh
   groups
   ```
- **Purpose:**  
  Confirms that the user has been added to the **docker** group.



---


# **Docker Storage**

By default all files created inside a container are stored on a writable container layer. This means that:

- The data doesn't persist when that container no longer exists, and it can be difficult to get the data out of the container if another process needs it.
- A container's writable layer is tightly coupled to the host machine where the container is running. You can't easily move the data somewhere else.
- Writing into a container's writable layer requires a storage driver to manage the filesystem. The storage driver provides a union filesystem, using the Linux kernel. This extra abstraction reduces performance as compared to using data volumes, which write directly to the host filesystem.
Docker has two options for containers to store files on the host machine, so that the files are persisted even after the container stops: volumes, and bind mounts.

Docker also supports containers storing files in-memory on the host machine. Such files are not persisted. If you're running Docker on Linux, tmpfs mount is used to store files in the host's system memory. If you're running Docker on Windows, named pipe is used to store files in the host's system memory.

## Choose the right type of mount
No matter which type of mount you choose to use, the data looks the same from within the container. It is exposed as either a directory or an individual file in the container's filesystem.

An easy way to visualize the difference among volumes, bind mounts, and tmpfs mounts is to think about where the data lives on the Docker host.


![types-of-mounts](./Img/types-of-mounts.png)

- **Volumes**: Volumes are stored in a part of the host filesystem which is managed by Docker (/var/lib/docker/volumes/ on Linux). Non-Docker processes should not modify this part of the filesystem. Volumes are the best way to persist data in Docker.

- **Bind Mounts**: Bind mounts may be stored anywhere on the host system. They may even be important system files or directories. Non-Docker processes on the Docker host or a Docker container can modify them at any time.
- **tmpfs Mounts**:  mounts are stored in the host system's memory only, and are never written to the host system's filesystem.

- **Named Pipes**: Mechanism for communication between the Docker host and containers.

Bind mounts and volumes can both be mounted into containers using the -v or --volume flag, but the syntax for each is slightly different. For tmpfs mounts, you can use the --tmpfs flag. We recommend using the --mount flag for both containers and services, for bind mounts, volumes, or tmpfs mounts, as the syntax is more clear.
Each storage option provides unique benefits and trade-offs. Choosing the right one depends on your application's needs, whether you prioritize portability, performance, or security.

---

## Docker Storage: Volumes, Bind Mounts, tmpfs, and Named Pipes

### 1. Volumes

Volumes are the preferred mechanism for persisting data in Docker. They offer advantages such as easy sharing of data between containers and the ability to use volume drivers for storage on remote hosts or cloud providers.


### Why Use Volumes:
- **Independence**: Volumes are managed by Docker, unlike bind mounts, which depend on the host OS.
- **Portability**: Easier to back up and migrate.
- **Cross-Platform**: Work on both Linux and Windows.
- **Sharing**: Safely share data among multiple containers.
- **Customization**: Support remote storage, encryption, and more through drivers.

### Managing Volumes:
- **Create**: `docker volume create <name>`
- **List**: `docker volume ls`
- **Inspect**: `docker volume inspect <name>`
- **Remove**: `docker volume rm <name>`

### Using Volumes:

#### Creating and Using Volumes
- **Create a named volume:**
  ```bash
  docker volume create my_volume
  ```

- **Mount a named volume to a container:**
  ```bash
  docker run -d --name my_container -v my_volume:/data nginx
  ```

- **Anonymous volumes:**
  Docker creates an anonymous volume with a random name when no specific name is provided.
  ```bash
  docker run -d -v /data nginx
  ```

- **Remove unused volumes:**
  ```bash
  docker volume prune
  ```

#### Sharing Anonymous Volumes
To share an anonymous volume, use its volume ID:
```bash
docker run -d --volumes-from <source-container> nginx
```

#### Using Volumes
- **With Containers**:  
  Example:  
  ```bash
  docker run -d --name my-container --mount source=myvol,target=/app nginx:latest
  ```
- **With Docker Compose**:  
  ```yaml
  services:
    app:
      image: myapp:latest
      volumes:
        - myvol:/app
  volumes:
    myvol:
  ```

### Key Options:
- **Read-Only Mount**:  
  Use `readonly` or `ro` to limit write access.
- **Subdirectory Mounting**:  
  Use `volume-subpath` to mount specific subdirectories.

### Syntax Differences:
- **`-v` vs. `--mount`**:  
  - `-v` is concise but less explicit.  
  - `--mount` is more verbose and flexible, especially for advanced configurations.

---

### 2. Bind Mounts

Bind mounts allow you to mount a file or directory from the host into the container. They are useful for scenarios where you need direct access to host files.


#### What Are Bind Mounts?

- Bind mounts **map files or directories** from the host system to a container.
- Unlike volumes, bind mounts use the **host's absolute file paths** and are more **limited in functionality**.
- Files/directories do **not need to pre-exist** on the host; they are created on demand.
  
**Key Features:**
  - Mounts a file or directory by its full path.
  - `No Direct Management`: Bind mounts are not managed by Docker CLI commands.
  - Allows changes to host files from the container.
  - Created on-demand if the file or directory doesn’t exist.
  - `High Performance`: Fast but depends on host filesystem structure.

#### Using Bind Mounts:

#### Syntax Differences:
- **`-v` / `--volume`:**  
  - Compact but less readable.
  - Format: `host_path:container_path[:options]`.
  
- **`--mount`:**  
  - More explicit, easier to understand.
  - Key-value pairs format: `type=bind,source=host_path,target=container_path[,options]`.

#### Example Commands:

- **`--mount` syntax:**
   ```bash
   docker run -d -it --name devtest --mount type=bind,source="$(pwd)"/target,target=/app nginx:latest
   ```

- **`-v` syntax:**
   ```bash
   docker run -d -it --name devtest -v "$(pwd)"/target:/app nginx:latest
   ```

---

#### Options:

- **Read-Only Mount:**
   - Use `readonly` or `ro`:
     ```bash
     --mount type=bind,source="$(pwd)"/target,target=/app,readonly
     ```

- **SELinux Labels (Linux-only):**
   - `z`: Shared among containers.
   - `Z`: Private to a container.
   ```bash
   -v "$(pwd)"/target:/app:z
   ```

---

#### Advanced Configurations:

- **Bind Propagation (Linux-only):**
   - Controls submount visibility between host and container.
   - Common values:
     - `shared`, `slave`, `private` (default), `rshared`, `rslave`, `rprivate`.

- **Recursive Read-Only Mounts:**  
   - Supported only on Linux Kernel **v5.12+**.
   - Option: `bind-recursive=readonly`.

---

#### Docker Compose Example:

```yaml
services:
  frontend:
    image: node:lts
    volumes:
      - type: bind
        source: ./static
        target: /opt/app/static
```

---

#### Key Considerations:
- **Mounting Non-Empty Directories:** Existing container contents may be hidden.
- **Synchronized File Shares:** For performance improvements in complex setups.
- **SELinux Caution:** Incorrect labeling can make the host system inoperable.
---

### 3. tmpfs Mounts

A `tmpfs` mount is used to store non-persistent data. It exists only in the container's memory and is lost when the container stops.

Here's a summarized version of **tmpfs mounts** in Docker:

---

### **What Are Tmpfs Mounts?**  
- A **tmpfs mount** allows files to be created outside a container's writable layer but stored in **host memory only**.
- Unlike **volumes** and **bind mounts**, **tmpfs** is **temporary** and gets removed when the container stops.
  
### **Use Cases**  
- Useful for **temporary storage** of sensitive data that shouldn't persist on the host or in the container’s layer.

---

### **Key Features and Limitations**  
- **Temporary Storage:** Files are stored in RAM and not persisted after the container stops.
- **Linux-Only:** Tmpfs mounts work only on Linux hosts.
- **Permissions:** Setting `uid`/`gid` can be tricky as permissions may reset after restart.
- **Container Isolation:** Tmpfs mounts **cannot** be shared across multiple containers.
  
---

### **Syntax Options**  
1. **`--tmpfs` Flag:**  
   - Simple and quick but **no configurable options**.
   - Example:  
   ```bash
   docker run -d -it --name tmptest --tmpfs /app nginx:latest
   ```

2. **`--mount` Flag:**  
   - More **flexible** and allows for configuration like size and permissions.  
   - Syntax: `--mount type=tmpfs,destination=<path>,tmpfs-size=<size>,tmpfs-mode=<mode>`  
   - Example:  
   ```bash
   docker run -d -it --name tmptest --mount type=tmpfs,destination=/app,tmpfs-mode=1770 nginx:latest
   ```

---

### **Common Options for Tmpfs Mounts**  
| **Option**     | **Description**                                   |
|----------------|---------------------------------------------------|
| **tmpfs-size** | Sets size limit in bytes (default is 50% of RAM). |
| **tmpfs-mode** | Sets file permissions (e.g., `0770`, default `1777`). |

---

### **Checking Tmpfs Mounts**  
- To verify a tmpfs mount, use:  
  ```bash
  docker inspect tmptest --format '{{ json .Mounts }}'
  ```

### **Clean Up**  
- Stop and remove the container:  
   ```bash
   docker stop tmptest  
   docker rm tmptest  
   ```

---


### 4. Named Pipes


#### **What Are Named Pipes?**

A **named pipe** (also known as a FIFO) is a method of **inter-process communication (IPC)** that allows data to be passed between processes. Unlike regular pipes (`|` in shell commands), named pipes have a persistent name in the filesystem and can be accessed by unrelated processes.

In Docker, named pipes enable communication between the host and containers or between containers. They are commonly used for tools that need to interact with the Docker Engine API.



---

#### **How Named Pipes Work**  

1. **Creation**: A named pipe is created as a file using the `mkfifo` command.
2. **Data Flow**: One process writes to the pipe, while another reads from it.
3. **Blocking Behavior**: A process writing to a named pipe will pause until another process reads from it, and vice versa.

---

#### **Example Usage in Docker**  

##### 1. **Creating a Named Pipe in the Host**  

```bash
mkfifo /tmp/mypipe
```

##### 2. **Running a Docker Container with a Named Pipe**  

```bash
docker run -it --rm -v /tmp/mypipe:/mypipe ubuntu bash
```

- **`-v /tmp/mypipe:/mypipe`**: Mounts the named pipe from the host into the container.

##### 3. **Writing and Reading from the Pipe**  

- **On Host**:

    ```bash
    echo "Hello from Host" > /tmp/mypipe
    ```

- **In Container**:

    ```bash
    cat /mypipe
    ```

**Output**: The container will display `Hello from Host`.

---

#### **Use Cases for Named Pipes in Docker**  

1. **Logging and Monitoring**: Containers can write logs to a named pipe, which the host or another service reads for real-time monitoring.
2. **Data Streaming**: Stream data between host processes and containers without using temporary files.
3. **Command Passing**: Send commands from the host to a running container in real-time.

---

#### **Best Practices and Considerations**  

- **Security**: Be cautious when using named pipes, as they can expose sensitive data if improperly secured.
- **Performance**: Named pipes are efficient for small, continuous streams of data but not ideal for bulk data transfers.
- **Blocking**: Ensure both reading and writing processes are properly synchronized to avoid deadlocks.

---

#### **Summary Table: Storage Options in Docker**

| **Type**     | **Persistence** | **Use Case**                                           | **Command Example**                             |
|--------------|-----------------|--------------------------------------------------------|-------------------------------------------------|
| Volumes      | Persistent      | Share data between containers, remote storage.         | `docker run -v my_volume:/path`                 |
| Bind Mounts  | Persistent      | Direct access to host files.                           | `docker run -v /host/path:/container/path`      |
| tmpfs        | Non-persistent  | Temporary or sensitive data.                           | `docker run --tmpfs /path`                      |
| Named Pipes  | Communication   | Communication between Docker host and container.       | `docker run -v //./pipe/docker_engine`          |


---
# Docker Networking

Docker networking enables seamless communication between containers, the host system, and external networks, abstracting the complexity of network configurations while ensuring isolation, scalability, and security. This guide expands on the core concepts, components, and practical applications of Docker networking, providing detailed explanations and examples to help you deploy containerized applications effectively.

## 1. Docker Network Drivers

Docker uses **network drivers** to implement various network architectures, each tailored to specific use cases. Below is a detailed overview of the key drivers, including their features, use cases, and examples.

| **Driver** | **Description** | **Use Case** | **Example Command** |
|------------|-----------------|--------------|---------------------|
| **bridge** | Creates a private internal network with NAT for external access. Default for standalone containers. | Single-host microservices or local development. | `docker network create -d bridge my-bridge-net` |
| **host**   | Uses the host’s network stack directly, bypassing isolation. | High-performance apps needing direct host access. | `docker run --network host nginx` |
| **none**   | Disables all networking for the container. | Isolated tasks like batch processing. | `docker run --network none busybox` |
| **overlay** | Connects containers across multiple hosts, used in Swarm mode. | Multi-host distributed applications. | `docker network create -d overlay my-overlay-net` |
| **macvlan** | Assigns containers MAC addresses, appearing as physical devices on the network. | Legacy apps requiring direct network access. | `docker network create -d macvlan --subnet=192.168.40.0/24 -o parent=eth0 my-macvlan-net` |

### Detailed Driver Explanations
- **Bridge**:
  - The default driver creates a private network (e.g., `docker0`) for containers on the same host.
  - Containers communicate via IP or names (on user-defined networks).
  - **Example**: Create a bridge network and run two containers:
    ```bash
    docker network create -d bridge my-bridge-net
    docker run -d --network my-bridge-net --name web nginx
    docker run -it --network my-bridge-net --name app busybox
    # Inside app container
    ping web  # Resolves to web’s IP, e.g., 172.18.0.2
    ```
  - **Note**: Avoid the default bridge (`docker0`) in production due to limited DNS resolution.

- **Host**:
  - Removes network isolation, allowing containers to share the host’s network.
  - Ideal for performance-critical apps but not supported on Docker Desktop for macOS/Windows.
  - **Example**: Run an Nginx container using the host network:
    ```bash
    docker run -d --network host --name my-nginx nginx
    # Access Nginx on host’s port 80
    curl http://localhost
    ```

- **None**:
  - Completely isolates the container from networking.
  - Useful for security-sensitive tasks.
  - **Example**:
    ```bash
    docker run -it --network none --name isolated busybox
    # No network interfaces except loopback
    ip addr
    ```

- **Overlay**:
  - Enables multi-host networking using VXLAN, ideal for Docker Swarm or Kubernetes.
  - Supports DNS-based service discovery.
  - **Example**: Create an overlay network and connect containers across hosts:
    ```bash
    docker network create -d overlay my-overlay-net
    # On Host 1
    docker run -d --network my-overlay-net --name web1 nginx
    # On Host 2
    docker run -it --network my-overlay-net --name web2 busybox
    # Inside web2
    ping web1
    ```

- **Macvlan**:
  - Assigns containers their own MAC and IP addresses, bypassing NAT.
  - Useful for integrating with existing networks.
  - **Example**:
    ```bash
    docker network create -d macvlan --subnet=192.168.40.0/24 --gateway=192.168.40.1 -o parent=eth0 my-macvlan-net
    docker run -d --network my-macvlan-net --name web nginx
    # Access web directly via its IP
    curl http://192.168.40.2
    ```

## 2. Key Components

Docker networking relies on several components to manage connectivity and isolation:

| **Component** | **Description** | **Role** |
|---------------|-----------------|----------|
| **Network Namespaces** | Isolate network stacks (IP, interfaces, routing tables) for each container. | Ensures containers operate independently. |
| **Linux Bridge** | Virtual switch (e.g., `docker0`) connecting containers to the host and external networks. | Facilitates container communication. |
| **veth Pairs** | Virtual Ethernet interfaces linking container namespaces to the bridge. | Connects containers to networks. |
| **iptables** | Manages NAT, port forwarding, and firewall rules. | Controls traffic flow and security. |
| **DNS Resolution** | Embedded DNS server resolves container names within the same network. | Simplifies service discovery. |
| **IPAM** | Assigns IP addresses to containers from subnet pools. | Automates IP management. |

### Detailed Component Explanations
- **Network Namespaces**:
  - Each container has its own namespace, isolating its network stack.
  - **Example**: Run a container and check its interfaces:
    ```bash
    docker run -it --name test busybox ip addr
    # Shows eth0 and lo interfaces, isolated from host
    ```

- **Linux Bridge**:
  - Acts as a virtual switch for containers on a bridge network.
  - **Example**: Inspect the default bridge:
    ```bash
    ip addr show docker0
    # Shows bridge interface on host
    ```

- **veth Pairs**:
  - Connects a container’s `eth0` to the host’s bridge.
  - **Example**: When a container starts, Docker creates a veth pair visible on the host:
    ```bash
    ip link
    # Shows veth interfaces like vethABCDEF
    ```

- **iptables**:
  - Configures rules for NAT and port forwarding.
  - **Example**: Publish a port and check iptables:
    ```bash
    docker run -d -p 8080:80 nginx
    sudo iptables -t nat -L
    # Shows forwarding rule for port 8080
    ```

- **DNS Resolution**:
  - Containers on user-defined networks resolve each other by name.
  - **Example**:
    ```bash
    docker network create my-net
    docker run -d --network my-net --name db postgres
    docker run -it --network my-net --name app busybox
    # Inside app
    ping db
    ```

- **IPAM (IP Address Management)**:
  - Assigns IPs from a subnet pool.
  - **Example**: Create a network with a custom subnet:
    ```bash
    docker network create --subnet=172.20.0.0/16 mynet
    docker run -d --network mynet --name web nginx
    # web gets IP like 172.20.0.2
    ```

## 3. Docker Network Architecture

Docker’s networking is built on the **libnetwork** library, which implements the Container Network Model (CNM). Key architectural components include:

- **libnetwork**: Manages network creation and configuration, supporting multiple drivers.
- **Sandbox**: Holds a container’s network stack (namespace, interfaces, routing, DNS).
- **Endpoint**: Virtual interface (e.g., veth) connecting a container to a network.
- **Network**: Group of endpoints that can communicate (e.g., bridge or overlay network).

**Example**: Inspect a network to see its components:
```bash
docker network inspect my-bridge-net
# Shows endpoints, containers, and IP assignments
```

## 4. Advanced Features and Examples

### Connecting to Multiple Networks
Containers can join multiple networks for flexible communication.
```bash
docker network create net1
docker network create net2
docker run -d --network net1 --name myapp nginx
docker network connect net2 myapp
# myapp can communicate on both net1 and net2
```

### Port Publishing
Expose container ports to the host or external networks.
```bash
docker run -d -p 8080:80 nginx
# Access Nginx at http://localhost:8080
```

### IPv6 Support
Enable IPv6 for containers.
```bash
docker network create --ipv6 --subnet=fd00::/64 my-v6-net
docker run -d --network my-v6-net --name web nginx
```

### Service Discovery
Docker’s DNS allows containers to find each other by name.
```bash
docker network create my-net
docker run -d --network my-net --name db postgres
docker run -it --network my-net --name app myapp
# Inside app
psql -h db
```

## 5. Use Cases and Best Practices

### Use Cases
- **Single-Host Apps**: Use `bridge` for microservices communicating internally.
- **Multi-Host Apps**: Use `overlay` in Docker Swarm for distributed systems.
- **Legacy Apps**: Use `macvlan` for direct network integration.

### Best Practices
- Use user-defined networks for better isolation and DNS resolution.
- Avoid the default bridge (`docker0`) in production.
- Name networks and containers meaningfully.
- Secure exposed ports with firewall rules.

### Troubleshooting
- List networks: `docker network ls`
- Inspect network: `docker network inspect my-net`
- Check container details: `docker container inspect myapp`
- View logs for errors: `docker logs myapp`

## 6. Security Considerations

- **Network Isolation**: Containers on different networks are isolated by default.
- **Port Publishing**: Exposing ports can risk external access; use `127.0.0.1` for host-only access:
  ```bash
  docker run -d -p 127.0.0.1:8080:80 nginx
  ```
- **Network Policies**: Use Docker Enterprise or Kubernetes for fine-grained control.

## 7. Docker Compose Networking

Docker Compose simplifies multi-container apps by creating a default network.
```yaml
version: '3'
services:
  web:
    image: nginx
    networks:
      - frontend
  db:
    image: postgres
    networks:
      - backend
networks:
  frontend:
  backend:
```
- `web` and `db` are isolated unless connected to the same network.

## 8. Integrating with External Networks

- **Macvlan/IPv6**: Assign containers IPs on external networks.
- **Third-Party Tools**: Use Weave or Flannel for advanced multi-host networking.

## Conclusion

Docker networking provides a powerful framework for container communication, from simple single-host setups to complex multi-host deployments. By leveraging network drivers, components, and best practices, you can build secure, scalable, and efficient containerized applications.

---

# **Deep Dive in Docker**

## Docker User Permissions, Basic Commands, and Image Management


### **1. User Permissions and Docker Group Setup**  
By default, Docker requires `sudo` to run commands. Adding a user to the **docker** group allows them to run Docker commands without `sudo`, improving efficiency and automation.

#### **Steps:**
1. **Check Existing Groups:**
   ```sh
   sudo getent group
   ```
   - Lists all system groups, including **docker** if available.

2. **Check User’s Groups:**
   ```sh
   groups
   ```
   - Shows groups associated with the current user.

3. **Add User to Docker Group:**
   ```sh
   sudo usermod -a -G docker <username>
   ```
   - Adds the user to the **docker** group.

4. **Verify Group Membership:**
   ```sh
   groups
   ```
   - Confirms the user is now in the **docker** group.

---

### **2. Managing Docker Images and Containers**

#### **List Images:**
```sh
docker image ls
```
- Shows all downloaded images.

#### **Pull an Image:**
```sh
docker image pull ubuntu:latest
```
- Downloads the latest version of the Ubuntu image.

#### **Run a Container:**
```sh
docker container run -it ubuntu:latest /bin/bash
```
- Launches a container interactively with a bash shell.

#### **Exit a Container Without Stopping:**
- **Shortcut:** `Ctrl + P, Ctrl + Q`

#### **Reattach to a Running Container:**
```sh
docker container exec -it <container_name> bash
```

#### **Stop a Running Container:**
```sh
docker container stop <container_name>
```

#### **Start a Stopped Container:**
```sh
docker container start <container_name>
```

#### **Remove a Stopped Container:**
```sh
docker container rm <container_name>
```

---

### **3. Building and Running Custom Images**  
Useful for DevOps teams creating custom applications.

#### **Clone a Repository with a Dockerfile:**
```sh
git clone https://github.com/nigelpoulton/psweb.git
```

#### **Inspect the Dockerfile:**
```sh
cat Dockerfile
```
- Displays the contents of the Dockerfile, detailing the image build instructions.

#### **Build a Custom Image:**
```sh
docker image build -t test:latest .
```
- Builds an image from the Dockerfile in the current directory (`.`) and tags it as `test:latest`.

#### **List Built Images:**
```sh
docker image ls
```
- Confirms the creation of the new image alongside any base images used.

#### **Run a Container from the Custom Image:**
```sh
docker container run -d \
  --name web1 \
  --publish 8080:8080 \
  test:latest
```
- **Explanation:**
   - **`-d`:** Runs the container in detached mode.
   - **`--name web1`:** Names the container **web1**.
   - **`--publish 8080:8080`:** Maps port 8080 on the host to port 8080 in the container.

---

### **4. DevOps Perspective**  
- **Automation:** Automating Docker tasks in CI/CD pipelines boosts efficiency.  
- **Customization:** Custom images allow teams to standardize environments.  
- **Flexibility:** Docker supports dynamic deployments and simplifies testing in isolated environments.  


## **The Docker Engine: Overview and Deep Dive**  


## **1. Docker Engine - TLDR**  

![Docker Client](./Img/5.png)
The Docker Engine manages the lifecycle of containers. It consists of several components that work together to build, run, and manage containers efficiently.

---

## **2. Docker Engine - Deep Dive Components**  

![Docker Engine](./Img/Docker_Architecture.png)

### **CLI Wrapper (Docker CLI)**  
- The command-line tool users interact with (`docker` command).  
- Sends commands to the Docker daemon using the Docker API.

---

### **`runc` (OCI Runtime Layer)**  
- **Purpose:**  
  - A lightweight runtime that creates and runs containers according to the Open Container Initiative (OCI) standards.  
  - Directly interfaces with the OS to create container processes.  
- **Role:**  
  - Only creates containers and exits after the container starts running.

- **Key Point:**  
  - Decoupling from the Docker daemon allows for “daemonless” containers, meaning containers keep running even if the daemon stops.  

- **Latest Release:**  
  [runc releases](https://github.com/opencontainers/runc/releases)

---

### **`containerd` (Container Lifecycle Manager)**  
- **Background Process:**  
  - Can be viewed with the command:  
    ```sh
    ps -elf | grep containerd
    ```  
- **Responsibilities:**  
  - Manages the entire container lifecycle: starting, stopping, pausing, and removing containers.  
  - Handles image pulls, volumes, and networking.  

- **Origins:**  
  - Originally developed by Docker, later donated to the Cloud Native Computing Foundation (CNCF).  

- **Latest Release:**  
  [containerd releases](https://github.com/containerd/containerd/releases)

---

### **Shim Process (`docker-containerd-shim`)**  
- A lightweight process that stays running after `runc` exits.  
- **Purpose:**  
  - Keeps STDIN/STDOUT streams open.  
  - Reports container status to the Docker daemon.  
  - Allows containers to keep running even if the Docker daemon is restarted.  

---

### **Starting a Container: Example Flow**  
```sh
docker container run --name ctr1 -it alpine:latest sh
```

#### **Execution Steps:**
1. **Docker CLI** sends the command to the Docker daemon through an API call (`/var/run/docker.sock` on Linux).  
2. **Docker Daemon (`dockerd`)** communicates with `containerd`.  
3. **`containerd`** prepares an OCI-compliant bundle and invokes `runc`.  
4. **`runc`** creates the container by interfacing with the OS kernel.  
5. **Shim (`containerd-shim`)** stays active after `runc` exits to manage the container.

---

### **Key Benefit: Decoupling of Daemon and Container Runtime**  
- **“Daemonless Containers”**:  
  - Containers can continue running even if the Docker daemon (`dockerd`) is restarted or upgraded.  
  - Improves system maintenance and stability.

---

## **3. Securing Docker Client and Daemon Communication**  

### **Local Communication:**  
- **Linux Socket:** `/var/run/docker.sock`  
- **Windows Pipe:** `//./pipe/docker_engine`  

### **Network Communication:**  
- **Unsecured HTTP Socket:** Port `2375/tcp` (not recommended).  

### **TLS (Transport Layer Security):**  
- TLS secures communication between the Docker client and daemon over the network.

#### **Steps to Enable TLS:**
1. **Set up a Certificate Authority (CA).**  
2. **Create and sign keys for the Docker daemon.**  
3. **Create and sign keys for the client.**  
4. **Distribute the CA and keys to both client and daemon.**  
5. **Configure Docker to use TLS:**  
   - Modify both daemon and client configuration files.

### **Further Security Guidance:**  
- [Protect Docker Daemon Socket](https://docs.docker.com/engine/security/protect-access/)

---

### **Summary of Components:**
- **CLI:** Sends commands to Docker.  
- **Daemon (`dockerd`):** Manages containers.  
- **`containerd`:** Oversees the container lifecycle.  
- **`runc`:** Creates containers based on OCI standards.  
- **Shim:** Keeps containers running after daemon restart

---


#### Example `docker run` Command

The following command runs an Ubuntu container with interactive terminal access.

```bash
docker run -i -t ubuntu /bin/bash
```

**What Happens:**
1. Docker pulls the `ubuntu` image if it’s not already available.
2. Docker creates a new container.
3. Docker allocates a read-write filesystem layer for the container.
4. Docker assigns the container an IP address and network interface.
5. Docker starts the container and executes `/bin/bash`.

When you exit the shell, the container stops but isn’t removed. You can restart or delete it.

## The Underlying Technology

Docker is written in Go and utilizes Linux kernel features to provide container isolation. Docker uses namespaces for creating isolated workspaces (containers) by limiting access to resources and isolating processes within each container.

Each Docker container operates within its own set of namespaces to ensure isolation and security.

## Dockerfile Example (Node.js Project)

This file contains instructions to build a Docker image. For instance, it specifies the base image, environment setup, application dependencies, and the command to run the application.

```dockerfile
# Use the specified Node.js version
FROM node:14  # Sets the base image to Node.js version 14

# Set the working directory inside the container
WORKDIR /app  # Defines /app as the working directory

# Copy package.json to the working directory
COPY package.json .  # Copies package.json to the working directory

# Install dependencies from package.json
RUN npm install  # Runs npm install to install dependencies

# Copy the rest of the project files to the working directory
COPY . .  # Copies all files from the current directory to the working directory in the container

# Expose port 4000 for external communication
EXPOSE 4000  # Specifies that the container listens on port 4000

# Define the command to run the application
CMD ["npm", "start"]  # Runs npm start to start the application
```

---

## Docker Hub

**Docker Hub** is a cloud-based repository for storing, managing, and sharing container images. It is the world’s largest container registry and simplifies the process of developing, distributing, and deploying containerized applications.

### Key Features of Docker Hub:

1. **Image Repository**:  
   Docker Hub hosts a vast collection of container images that you can use as a base for your projects.

2. **Public & Private Repositories**:  
   You can create public repositories to share your images with the community or private repositories to share with your team securely.

3. **Automated Builds**:  
   Docker Hub can automatically build images from a Dockerfile and push them to the repository.

4. **Collaboration**:  
   It allows teams to collaborate on container images, making it easier to manage and distribute applications.

5. **Pre-built Images**:  
   Docker Hub provides a wide range of pre-built images for popular software, which can speed up your development process.

---

## Build the Docker Image

Use the Dockerfile to create a Docker image with the following command:

```bash
docker build -t my-node-app .
```

- `-t my-node-app`: Tags the image with the name `my-node-app`.
- `.`: Specifies the current directory as the build context.

---

## Run Docker Containers

Once you have the image, you can create multiple containers from it. Each container runs as an isolated instance of the application.

1. **Run the first container**:
    ```bash
    docker run -d --name container1 -p 4001:4000 my-node-app
    ```
    This runs the container in detached mode, mapping port `4001` on the host to port `4000` in the container.

2. **Run the second container**:
    ```bash
    docker run -d --name container2 -p 4002:4000 my-node-app
    ```

---

## Docker Optimization

### Do I Need to Copy All Files?

No, you don’t need to copy all files. Using a `.dockerignore` file helps exclude unnecessary files and directories from the build context. This can speed up the build process and reduce the image size.

Example `.dockerignore`:

```plaintext
/node_modules
Dockerfile
.env
```

This ensures Docker does not include these files during the build.

---

### Why Did We Split the `package.json` Copy Command?

Splitting the `COPY` command into two parts is a common optimization strategy. By copying `package.json` first and running `npm install` before copying the rest of the files, Docker can cache the layers more efficiently. Here’s why:

- If only `package.json` and `package-lock.json` have changed, Docker can reuse the cached layers for installing dependencies, making the build process faster.
- If we copy all files first and then run `npm install`, any change in your source files will cause Docker to rerun the `npm install` step, which can be time-consuming.

---

By using Docker, you can streamline development, eliminate inconsistencies, and easily scale your applications, all while improving resource efficiency.


---

# Dockerfile
## 1. Introduction: What is a Dockerfile?

A **Dockerfile** is a text document that contains a series of instructions on how to build a Docker image. Think of it as a blueprint, a recipe, or an automation script for creating a standardized and reproducible environment for your application.

Docker reads these instructions sequentially, executing each one to assemble the final image. This image contains everything needed to run your application: code, runtime, libraries, environment variables, and configuration files.

**Key Purpose:**

*   **Automation:** Automates the process of creating container images.
*   **Reproducibility:** Ensures that the same image is built every time, regardless of where or when the build process runs (given the same base image and source code).
*   **Standardization:** Provides a standard way to define application environments.
*   **Versioning & Distribution:** Dockerfiles can be version controlled (like code), and the resulting images can be easily shared via registries (like Docker Hub).

## 2. What is a Docker Image?

Before diving deeper into the Dockerfile, it's crucial to understand what it produces: a **Docker Image**.

*   An image is a **read-only template** used to create Docker containers.
*   It's built in **layers**. Each instruction in the Dockerfile typically creates a new layer on top of the previous ones.
*   These layers are **cached**, which speeds up subsequent builds if the instructions haven't changed.
*   Images are **immutable**; once built, they don't change. If you need to make changes, you rebuild the image (potentially creating a new one or overwriting a tag).

When you run an image using `docker run`, Docker creates a writable container layer on top of the read-only image layers. This is where your application runs and where any changes are made during the container's lifetime.

## 3. Dockerfile Structure

A Dockerfile follows a simple format:

```dockerfile
# This is a comment
INSTRUCTION argument1 argument2...
```

*   **Comments:** Lines starting with `#` are treated as comments (except for parser directives like `# syntax=...`).
*   **Instructions:** These are commands Docker executes during the build process. By convention, they are written in `UPPERCASE` (e.g., `FROM`, `RUN`, `COPY`).
*   **Arguments:** These follow the instruction and provide the necessary details for its execution.
*   **Execution Order:** Instructions are executed sequentially from top to bottom.
*   **Layers:** Many instructions (especially `RUN`, `COPY`, `ADD`) create a new image layer. Docker caches these layers. If a layer's instruction and its inputs haven't changed since the last build, Docker reuses the cached layer, significantly speeding up the build process.

## 4. Core Dockerfile Instructions

These are some of the most fundamental instructions used in almost every Dockerfile:

### `FROM <image>[:<tag>] [AS <name>]`

*   **Purpose:** Specifies the **base image** for your build. Every Dockerfile *must* start with a `FROM` instruction (unless it's using a `scratch` base image, which is an empty starting point).
*   **Details:** You can pull images from registries like Docker Hub (e.g., `ubuntu:22.04`, `python:3.9-slim`, `node:18-alpine`). Using specific tags (like `3.9-slim` instead of just `python`) is recommended for reproducibility.
*   **`AS <name>`:** This optional part assigns a name to this build stage, which is useful in multi-stage builds.

### `RUN <command>` (shell form) or `RUN ["executable", "param1", "param2"]` (exec form)

*   **Purpose:** Executes commands in a new layer on top of the current image. Used for installing packages, creating directories, compiling code, etc. – essentially any command you'd run on the command line to set up your application environment.
*   **Details:**
    *   **Shell Form:** Runs the command using the default shell ( `/bin/sh -c` on Linux, `cmd /S /C` on Windows). Environment variable substitution works. Example: `RUN apt-get update && apt-get install -y --no-install-recommends package1 package2`
    *   **Exec Form:** Runs the executable directly without a shell. Preferred if you don't need shell processing. Parses as a JSON array. Example: `RUN ["apt-get", "update"]`
*   **Best Practice:** Chain related commands using `&&` within a single `RUN` instruction to reduce the number of layers and image size (e.g., update package list, install packages, and clean up cache files all in one `RUN`).

### `COPY [--chown=<user>:<group>] <src>... <dest>`

*   **Purpose:** Copies files or directories from your **build context** (the directory where you run `docker build`) into the image's filesystem at the specified `<dest>`.
*   **Details:**
    *   `<src>` must be relative to the build context.
    *   `<dest>` is an absolute path inside the image or a path relative to the `WORKDIR`.
    *   If `<dest>` doesn't exist, it will be created (along with parent directories).
    *   `--chown`: Optionally sets the user and group ownership of the copied files. Useful for running as a non-root user.
*   **Example:** `COPY . /app` (copies everything from the build context to `/app` in the image). `COPY --chown=appuser:appgroup ./config.json /etc/myapp/config.json`

### `ADD [--chown=<user>:<group>] <src>... <dest>`

*   **Purpose:** Similar to `COPY`, but with additional features:
    *   Can copy from URLs.
    *   Can automatically extract compressed archives (tar, gzip, bzip2, xz) if `<src>` is a recognized archive format.
*   **Details:** Due to the "magic" of auto-extraction and potential unpredictability with URLs, `COPY` is generally preferred for simply copying local files. Use `ADD` specifically when you need its URL or extraction capabilities.
*   **Example:** `ADD https://example.com/file.tar.gz /tmp/` (downloads and extracts). `ADD myapp.tar.gz /usr/src/`

### `CMD ["executable","param1","param2"]` (exec form, preferred) or `CMD command param1 param2` (shell form) or `CMD ["param1","param2"]` (as default parameters for ENTRYPOINT)

*   **Purpose:** Provides the **default command and/or parameters** for an executing container.
*   **Details:**
    *   There can only be **one** `CMD` instruction in a Dockerfile. If you list more than one, only the last `CMD` will take effect.
    *   The primary purpose of `CMD` is to define the default executable that runs when a container starts *if the user doesn't specify a command when running `docker run`*.
    *   If used with `ENTRYPOINT` (in exec form), `CMD` provides default arguments *to* the `ENTRYPOINT`.
*   **Example (Exec Form):** `CMD ["python", "app.py"]` (runs `python app.py` by default)
*   **Example (Shell Form):** `CMD python app.py` (runs `/bin/sh -c 'python app.py'`)
*   **Example (with ENTRYPOINT):**
    ```dockerfile
    ENTRYPOINT ["python", "app.py"]
    CMD ["--port", "8080"]
    # Default run: python app.py --port 8080
    # docker run image --port 9000 -> runs: python app.py --port 9000 (CMD overridden)
    ```

### `ENTRYPOINT ["executable", "param1", "param2"]` (exec form, preferred) or `ENTRYPOINT command param1 param2` (shell form)

*   **Purpose:** Configures a container to run as an **executable**. Makes the container behave like a specific command.
*   **Details:**
    *   Also, only the last `ENTRYPOINT` takes effect.
    *   Unlike `CMD`, the command specified with `docker run <image> [command]` is appended as arguments to the `ENTRYPOINT` (in exec form), rather than overriding it.
    *   Often used in combination with `CMD` to set default parameters that can be easily overridden.
*   **Example (Exec Form):**
    ```dockerfile
    ENTRYPOINT ["ping"]
    CMD ["localhost"]
    # docker run image -> runs: ping localhost
    # docker run image google.com -> runs: ping google.com
    ```
*   **Example (Shell Form):** `ENTRYPOINT /entrypoint.sh` (Runs the script, but makes it harder to pass arguments or override gracefully. Exec form is generally better).

**`CMD` vs. `ENTRYPOINT` Summary:**

*   Use `CMD` if you want to provide a default executable/arguments that can be easily overridden from the `docker run` command line.
*   Use `ENTRYPOINT` if you want the container to primarily run as a specific executable, where `docker run` arguments are treated as flags/parameters *to* that executable.
*   Use `ENTRYPOINT` with `CMD` to set default parameters for the main executable defined by `ENTRYPOINT`.

## 5. Metadata and Configuration Instructions

These instructions don't typically execute commands during the build but define metadata or configure the build/runtime environment. They usually don't create new layers (or create zero-size layers).

### `LABEL <key>=<value> [<key>=<value> ...]`

*   **Purpose:** Adds metadata to an image in key-value pairs. Useful for organization, automation, versioning info, licensing, etc.
*   **Example:** `LABEL maintainer="Your Name <your.email@example.com>" version="1.0" description="My awesome web application"`

### `EXPOSE <port> [<port>/<protocol>...]`

*   **Purpose:** Informs Docker that the container **listens on the specified network ports** at runtime. It acts as documentation between the image builder and the person running the container.
*   **Details:**
    *   Does **NOT** actually publish the port. It's documentation.
    *   To make the port accessible from the host, you still need to use the `-p` or `-P` flag with `docker run`.
    *   Protocol can be `tcp` (default) or `udp`.
*   **Example:** `EXPOSE 8080/tcp` or simply `EXPOSE 80`

### `ENV <key>=<value> [<key>=<value> ...]`

*   **Purpose:** Sets **environment variables** within the image.
*   **Details:**
    *   These variables are available during the **build process** (for subsequent `RUN`, `COPY`, `CMD`, `ENTRYPOINT` instructions) and **when the container runs**.
    *   Values can be overridden when running the container using the `-e` flag with `docker run`.
*   **Example:** `ENV APP_HOME=/app DATABASE_URL=postgresql://user:pass@host:port/db`

### `ARG <name>[=<default value>]`

*   **Purpose:** Defines variables that users can pass **at build-time** using the `--build-arg <varname>=<value>` flag with the `docker build` command.
*   **Details:**
    *   `ARG` variables are **not** persisted in the image or available in the running container by default, *unless* they are also defined with `ENV`.
    *   An `ARG` declared *before* the first `FROM` can be used in any `FROM` line within the Dockerfile.
    *   Scope: An `ARG` defined after a `FROM` is only available until the end of that build stage.
*   **Example:**
    ```dockerfile
    ARG USER=guest
    ARG RAILS_ENV=development
    ENV RAILS_ENV=${RAILS_ENV} # Persist the ARG value into an ENV var

    RUN echo "Building for user ${USER}" # USER is available here
    # USER will not be available in the running container unless also set via ENV
    # RAILS_ENV will be available in the running container because of the ENV instruction
    ```

### `USER <user>[:<group>]` or `USER <UID>[:<GID>]`

*   **Purpose:** Sets the **user name** (or UID) and optionally the **group name** (or GID) to use for subsequent `RUN`, `CMD`, and `ENTRYPOINT` instructions. Also sets the default user for the running container.
*   **Details:** Running containers as a non-root user is a crucial security best practice. You typically need to create the user and group first (e.g., using `RUN groupadd ... && useradd ...`).
*   **Example:**
    ```dockerfile
    RUN groupadd -r myapp && useradd --no-log-init -r -g myapp myapp
    USER myapp
    WORKDIR /home/myapp
    ```

### `WORKDIR /path/to/workdir`

*   **Purpose:** Sets the **working directory** for subsequent `RUN`, `CMD`, `ENTRYPOINT`, `COPY`, and `ADD` instructions.
*   **Details:** If the directory doesn't exist, it will be created. It's better than using `RUN cd ...` because it persists across multiple instructions.
*   **Example:**
    ```dockerfile
    WORKDIR /app
    COPY . . # Copies to /app inside the image
    RUN bundle install # Runs in /app
    CMD ["rails", "server"] # Runs relative to /app
    ```

### `VOLUME ["/path/to/volume"]`

*   **Purpose:** Creates a **mount point** with the specified name and marks it as holding externally mounted volumes from the host or other containers.
*   **Details:**
    *   Often used to designate directories for databases, logs, or user-uploaded content that should persist beyond the container's lifecycle or be shared.
    *   The contents of the directory specified in the `VOLUME` instruction are typically managed outside the container's lifecycle (e.g., using named volumes or host mounts).
    *   Data written to a volume bypasses the Union File System.
*   **Example:** `VOLUME /var/log` `VOLUME /data`

### `STOPSIGNAL <signal>`

*   **Purpose:** Sets the system call signal that will be sent to the container to exit. This signal can be a valid signal number (e.g., 9) or a signal name in the `SIGNAME` format (e.g., `SIGKILL`). Defaults to `SIGTERM`.
*   **Example:** `STOPSIGNAL SIGQUIT`

### `HEALTHCHECK [OPTIONS] CMD <command>` or `HEALTHCHECK NONE`

*   **Purpose:** Defines how Docker should test a container to check that it is still working (e.g., by checking if a web server is responding).
*   **Details:**
    *   `OPTIONS`: Can include `--interval=DURATION` (default: 30s), `--timeout=DURATION` (default: 30s), `--start-period=DURATION` (default: 0s), `--retries=N` (default: 3).
    *   `<command>`: The command to run inside the container. If it exits with status 0, the container is healthy; status 1 is unhealthy.
    *   `HEALTHCHECK NONE`: Disables any healthcheck inherited from the base image.
*   **Example:** `HEALTHCHECK --interval=5m --timeout=3s CMD curl -f http://localhost:8080 || exit 1`

### `SHELL ["executable", "parameters"]`

*   **Purpose:** Overrides the default shell used for the *shell form* of `RUN`, `CMD`, and `ENTRYPOINT`. The default is `/bin/sh -c` on Linux and `cmd /S /C` on Windows.
*   **Example:** `SHELL ["/bin/bash", "-c"]` (Use bash instead of sh)

## 6. Example Dockerfile (Simple Node.js App)

```dockerfile
# === Stage 1: Build ===
# Use an official Node.js runtime as a parent image (specify version)
FROM node:18-alpine AS builder

# Set the working directory in the container
WORKDIR /usr/src/app

# Install app dependencies
# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies using npm ci for faster, reproducible builds
RUN npm ci --only=production

# Copy the rest of the application source code
COPY . .

# (Optional) Add any build steps here if needed, e.g., TypeScript compilation
# RUN npm run build


# === Stage 2: Production ===
# Use a minimal base image for production
FROM node:18-alpine

# Set the working directory
WORKDIR /usr/src/app

# Create a non-root user and group
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy built artifacts and dependencies from the builder stage
COPY --from=builder --chown=appuser:appgroup /usr/src/app/node_modules ./node_modules
COPY --from=builder --chown=appuser:appgroup /usr/src/app/package.json ./package.json
COPY --from=builder --chown=appuser:appgroup /usr/src/app/dist ./dist # Assuming a build step outputted to 'dist'
COPY --from=builder --chown=appuser:appgroup /usr/src/app/server.js ./server.js # Or your main entry file

# Switch to the non-root user
USER appuser

# Make port 8080 available to the world outside this container (documentation)
EXPOSE 8080

# Add metadata
LABEL maintainer="Your Name <you@example.com>"
LABEL version="1.0"

# Define environment variable
ENV NODE_ENV=production

# Run the app when the container launches
CMD ["node", "server.js"] # Or "node", "dist/server.js" if you have a build step
```

**Explanation of the Example:**

1.  **Multi-Stage Build:** Uses two `FROM` instructions (`AS builder` names the first stage).
2.  **Builder Stage:**
    *   Starts with a full Node.js image (`node:18-alpine`).
    *   Sets `WORKDIR`.
    *   Copies *only* `package.json`/`lock` first to leverage Docker caching. If these files don't change, the `npm ci` layer is reused.
    *   Installs *only* production dependencies (`npm ci --only=production`).
    *   Copies the rest of the source code.
    *   (Commented out) Could include a build step like `npm run build`.
3.  **Production Stage:**
    *   Starts fresh from a minimal base image (`node:18-alpine`) for a smaller final image.
    *   Sets `WORKDIR`.
    *   Creates a non-root user (`appuser`) for security.
    *   Uses `COPY --from=builder` to copy *only* the necessary built artifacts (e.g., `node_modules`, compiled code, `package.json`) from the previous stage. Sets ownership with `--chown`.
    *   Switches to the `appuser` using `USER`.
    *   Documents the port using `EXPOSE`.
    *   Adds `LABEL` metadata.
    *   Sets `NODE_ENV` using `ENV`.
    *   Defines the default command to run the app using `CMD`.

## 7. Building an Image

To build an image from a Dockerfile located in the current directory:

```bash
# Syntax: docker build [OPTIONS] PATH | URL | -
# Example: Build image tagged 'my-app:1.0' from current directory '.'
docker build -t my-app:1.0 .

# Example: Build with a build argument
docker build --build-arg USER=admin -t my-app:latest .
```

## 8. Conclusion

Dockerfiles are the cornerstone of reproducible containerized environments. By understanding their structure and the purpose of each instruction, you can create efficient, secure, and maintainable Docker images for your applications. Remember to follow best practices like using specific base image tags, minimizing layers, leveraging build cache, running as non-root users, and using multi-stage builds for smaller, more secure production images.

---

# **Docker Compose**  

## **Table of Contents**  
1. [What is Docker Compose?](#1-what-is-docker-compose)  
2. [Why Use Docker Compose?](#2-why-use-docker-compose)  
3. [Docker Compose vs. Docker CLI](#3-docker-compose-vs-docker-cli)  
4. [Installing Docker Compose](#4-installing-docker-compose)  
5. [Docker Compose File Structure](#5-docker-compose-file-structure)  
6. [Key Sections of `docker-compose.yml`](#6-key-sections-of-docker-composeyml)  
   - [**`version`**](#1-version)  
   - [**`services`**](#2-services)  
   - [**`networks`**](#3-networks)  
   - [**`volumes`**](#4-volumes)  
7. [Common Docker Compose Commands](#7-common-docker-compose-commands)  
8. [Example: Multi-Service Application](#8-example-multi-service-application)  
9. [Best Practices](#9-best-practices)  

---

## **1. What is Docker Compose?**  
**Docker Compose** is a tool for defining and running **multi-container Docker applications**. Instead of manually running `docker run` for each container, you define all services, networks, and volumes in a single YAML file (`docker-compose.yml`) and start them with one command (`docker-compose up`).  

---

## **2. Why Use Docker Compose?**  
  **Simplifies Multi-Container Apps** – Run multiple services (e.g., web app + database + Redis) with a single command.  
  **Reproducible Environments** – Ensures consistency across development, testing, and production.  
  **Declarative Configuration** – Define everything in YAML, avoiding long `docker run` commands.  
  **Networking & Volumes** – Automatically sets up networks and storage between containers.  
  **Service Dependencies** – Start services in the correct order (e.g., database before app).  

---

## **3. Docker Compose vs. Docker CLI**  
| Feature | `docker run` (CLI) | `docker-compose` |
|---------|-------------------|------------------|
| **Single Container** |  Yes |  No (but possible) |
| **Multi-Container** |  Manual setup |  Single YAML file |
| **Networking** | Manual `--network` | Auto-created networks |
| **Volume Management** | Manual `-v` flag | Declarative in YAML |
| **Environment Variables** | `-e` flag | Defined in YAML |
| **Scaling** | Manual | Easy with `docker-compose scale` |

---

## **4. Installing Docker Compose**  
Docker Compose is included in **Docker Desktop** (Windows/Mac). For Linux:  
```bash
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version  # Verify
```

---

## **5. Docker Compose File Structure**  
The `docker-compose.yml` file has 4 main sections:  

1. **`version`** → Specifies the Compose file format.  
2. **`services`** → Defines the containers to run.  
3. **`networks`** → Configures container networking.  
4. **`volumes`** → Manages persistent storage.  

Example:  
```yaml
version: "3.9"  # Compose file version
services:       # Define containers
  web:
    build: .
    ports:
      - "5000:5000"
  db:
    image: postgres:15
    volumes:
      - db-data:/var/lib/postgresql/data

volumes:        # Persistent storage
  db-data:

networks:       # Networking (optional)
  default:
    driver: bridge
```

---

## **6. Key Sections of `docker-compose.yml`**  

### **1. `version`**  
Specifies the **Compose file syntax version** (not Docker Engine version).  
```yaml
version: "3.9"  # Latest stable (Docker Compose v2+ supports "3.x")
```

### **2. `services`**  
Defines each container (service) in your app.  

#### **Key Service Directives**  
| Directive | Description | Example |
|-----------|-------------|---------|
| `build` | Build from a `Dockerfile` | `build: ./app` |
| `image` | Use a pre-built image | `image: nginx:alpine` |
| `ports` | Map `host:container` ports | `"80:8080"` |
| `volumes` | Mount host/container storage | `./data:/app/data` |
| `environment` | Set env variables | `DB_HOST: db` |
| `depends_on` | Start order dependencies | `depends_on: [db]` |
| `restart` | Auto-restart policy (`no`, `always`, `on-failure`) | `restart: unless-stopped` |

Example:  
```yaml
services:
  web:
    build: .
    ports:
      - "8000:8000"
    depends_on:
      - db
    environment:
      DB_URL: "postgres://user:pass@db:5432/mydb"

  db:
    image: postgres:15
    environment:
      POSTGRES_PASSWORD: mypassword
    volumes:
      - pg-data:/var/lib/postgresql/data
```

### **3. `networks`**  
Custom networks improve isolation and security.  

```yaml
networks:
  app-net:
    driver: bridge  # Default (others: overlay, host)
```

### **4. `volumes`**  
Persistent storage for databases, logs, etc.  

```yaml
volumes:
  pg-data:  # Named volume (managed by Docker)
  ./app/logs:/var/logs  # Host-mounted volume
```

---

## **7. Common Docker Compose Commands**  

| Command | Description |
|---------|-------------|
| `docker-compose up` | Start all services |
| `docker-compose up -d` | Run in detached mode |
| `docker-compose down` | Stop & remove containers |
| `docker-compose ps` | List running services |
| `docker-compose logs` | View logs (`-f` to follow) |
| `docker-compose exec` | Run a command in a container |
| `docker-compose build` | Rebuild images |

---

## **8. Example: Multi-Service Application**  

### **`docker-compose.yml` (Flask + PostgreSQL + Redis)**  
```yaml
version: "3.9"

services:
  web:
    build: .
    ports:
      - "5000:5000"
    environment:
      - DB_HOST=db
      - REDIS_HOST=redis
    depends_on:
      - db
      - redis

  db:
    image: postgres:15
    environment:
      POSTGRES_PASSWORD: mypassword
    volumes:
      - pg-data:/var/lib/postgresql/data

  redis:
    image: redis:alpine
    ports:
      - "6379:6379"

volumes:
  pg-data:
```

### **How to Run**  
```bash
docker-compose up -d  # Start all services
docker-compose ps    # Check running containers
docker-compose down  # Stop and clean up
```

---

