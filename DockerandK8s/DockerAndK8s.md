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



### Sources

1. [Docker and Kubernetes `ahmed samy`](https://www.youtube.com/watch?v=PrusdhS2lmo&t=1449s)
2. [Containers vs. virtual machines](https://www.atlassian.com/microservices/cloud-computing/containers-vs-vms)
3. [Docker Docurmentation](https://docs.docker.com/)
4. [Docker Practical Course](https://www.youtube.com/playlist?list=PLzNfs-3kBUJnY7Cy1XovLaAkgfjim05RR)









