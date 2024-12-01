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

# Docker

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

## The Docker Platform

Docker enables you to encapsulate an application in a container. Containers hold everything needed to run the application, avoiding dependencies on the host environment and ensuring a stable, reproducible setup.

The Docker platform provides tools for managing the entire container lifecycle:

1. **Develop**: Build and containerize your application and its dependencies.
2. **Distribute**: Test and share your containerized application.
3. **Deploy**: Run your containerized application in any environment, from local systems to cloud infrastructure.

## Docker Architecture

### **Docker Components: Runtime, Daemon, and Orchestrator**  

#### **1. The Runtime: runc and containerd**

The runtime is the layer responsible for creating and managing containers by interacting directly with the host system's kernel and hardware.

##### **a. `runc`:**  
- **Definition:**  
  `runc` is a lightweight, low-level container runtime. It implements the **Open Containers Initiative (OCI)** runtime specifications.
- **Key Responsibilities:**  
  - **Start/Stop Containers:**  
    Responsible for launching and stopping containers based on OCI-compliant configuration files.
  - **Build OS Constructs:**  
    Creates essential components like namespaces, control groups (cgroups), and other isolation mechanisms.
  
##### **b. `containerd`:**  
- **Definition:**  
  `containerd` is a higher-level container runtime that abstracts and manages `runc` operations. It is an open-source project governed by the **Cloud Native Computing Foundation (CNCF)**.
- **Key Responsibilities:**  
  - **Pull Images:**  
    Downloads container images from registries like Docker Hub.
  - **Create Network Interfaces:**  
    Sets up network interfaces for container communication.
  - **Manage `runc`:**  
    Delegates tasks like starting and stopping containers to `runc`.

---

#### **2. The Daemon (`dockerd`):**  

The Docker daemon, known as **`dockerd`**, is the brain of the Docker ecosystem. It runs in the background and manages containers, images, networks, and volumes.

- **Expose the Docker Remote API:**  
  `dockerd` exposes a REST API, allowing external clients (like the Docker CLI) to interact with Docker.
  
- **Manage Images:**  
  - Handles operations like pulling, pushing, listing, and deleting Docker images.
  - Stores images locally and maintains image layers for efficient storage.

- **Manage Volumes:**  
  - Creates and manages Docker volumes, which allow data persistence across container restarts.
  
- **Manage Networks:**  
  - Creates Docker networks to enable communication between containers.
  - Supports bridge, overlay, and host networks.

- **Other Responsibilities:**  
  - Monitors container state (running, stopped, paused).
  - Handles resource allocation and limits (memory, CPU).
  
---

#### **3. The Orchestrator: Swarm**  

The orchestrator is responsible for managing and scheduling containers across multiple nodes in a cluster to ensure high availability, scalability, and resource efficiency.

- **Definition:**  
  Docker's native orchestration tool is called **Swarm**, and it allows Docker to run as a **cluster of nodes**.
  
- **Key Concepts:**  
  - **Cluster of Nodes:**  
    A **swarm** is a group of machines (nodes) running Docker, where:
    - **Manager Nodes** control and schedule tasks.
    - **Worker Nodes** execute tasks assigned by the managers.
  
  - **Tasks and Services:**  
    - A **service** is a definition of how containers should run.
    - A **task** is an instance of the service running on a node.
  
  - **High Availability:**  
    Ensures that containers are distributed across nodes, minimizing downtime if one node fails.

##### **Why Orchestration Matters:**
- **Scalability:**  
  Easily scale applications by adding more nodes or containers.
- **Load Balancing:**  
  Distributes requests across containers to optimize performance.
- **Self-Healing:**  
  Automatically restarts failed containers and reallocates them as needed.

---

### **Summary of Roles in Docker Architecture:**

| **Component**      | **Purpose**                                          | **Key Tools**            |
|--------------------|------------------------------------------------------|--------------------------|
| **Runtime**        | Directly manages container lifecycle and OS-level isolation. | `runc`, `containerd`     |
| **Daemon**         | Core service that manages Docker's images, containers, volumes, and networks. | `dockerd`                |
| **Orchestrator**   | Manages and scales clusters of containers across multiple nodes. | Docker Swarm, Kubernetes |

![docker-architecture](./Img/2.png)


Docker operates with a client-server architecture:

- **Docker Daemon (`dockerd`)**:  
   The Docker daemon listens for Docker API requests and manages Docker objects like images, containers, networks, and volumes. It can also interact with other daemons to manage Docker services.

- **Docker Client (`docker`)**:  
   The primary interface for interacting with Docker, allowing users to run commands for tasks like container management, image creation, and more. The Docker client communicates with `dockerd` either locally or remotely.

- **Docker Desktop**:  
   Docker Desktop is an easy-to-install application for Mac, Windows, and Linux. It includes Docker Daemon, Docker CLI, Docker Compose, Kubernetes, and Credential Helper for streamlined Docker management.

- **Docker Registries**:  
   A Docker registry stores Docker images, making it easy to pull and push images as needed. Docker Hub is the default public registry, but private registries can be set up as well.

### Docker Architecture Diagram

![docker-architecture](./Img/docker-architecture.png)

## Docker Objects

Docker enables you to work with various objects:

1. **Images**:  
   An image is a read-only template used to create containers, often based on a parent image with added customizations. Images are typically built using a Dockerfile, where each instruction in the Dockerfile creates a layer, making them lightweight and efficient.

2. **Containers**:  
   A container is a runnable instance of an image, offering a separate filesystem, network settings, and other resources. Containers can be run, stopped, restarted, and removed, allowing fine-grained control over application instances.

3. **Networks**:  
   Docker allows you to define networks to connect containers, enabling communication between them in isolated or shared environments.

4. **Volumes**:  
   Docker volumes store data generated and used by containers, enabling persistence beyond container lifecycle. Volumes are the preferred mechanism for persistent data storage.

5. **Plugins**:  
   Docker plugins extend Docker’s functionalities, offering additional capabilities like network drivers, volume drivers, and security features.



### **The Open Container Initiative (OCI)**  

#### **Overview:**  
The **Open Container Initiative (OCI)** is an open governance structure formed in 2015 to establish standards for container formats and runtimes. It is supported by the **Linux Foundation** and major tech companies, aiming to promote interoperability and avoid fragmentation in the container ecosystem.

---

### **Key Objectives of OCI:**
1. **Standardization:**  
   Create industry-wide standards for container image formats and runtime specifications, ensuring containers can run consistently across different platforms and tools.

2. **Interoperability:**  
   Enable container portability between different environments (e.g., development, staging, production) and across various tools and orchestration platforms (Docker, Kubernetes, etc.).

3. **Vendor Neutrality:**  
   Provide a neutral, community-driven space for developing container standards, free from vendor lock-in.

---

### **Core Components of OCI:**

#### 1. **OCI Runtime Specification (runtime-spec):**  
   - Defines how to run a container, including process lifecycle management, namespaces, cgroups, and file system mounts.
   - **Example:**  
     - `runc` is an implementation of the OCI runtime-spec. It handles container creation, starting, and stopping based on the defined standard.

#### 2. **OCI Image Specification (image-spec):**  
   - Defines the format and structure of container images, including how images are built, stored, and distributed.
   - **Layers and Manifests:**  
     Images are composed of layers, and the specification dictates how these layers are organized and referenced.

#### 3. **OCI Distribution Specification (distribution-spec):**  
   - Standardizes how container images are distributed across different registries, ensuring consistent image pulls and pushes.
   - **Example:**  
     Docker Hub and other container registries adhere to this spec to ensure seamless image transfers.

---

### **How OCI Relates to DevOps:**

1. **Portability Across Environments:**  
   DevOps pipelines rely on container standards to ensure that applications run consistently from development to production. OCI-compliant containers can move between different CI/CD pipelines, cloud providers, and orchestration tools without modification.

2. **Interchangeability of Tools:**  
   Since OCI defines the standards, DevOps teams can choose different tools (e.g., Docker, Podman, Kubernetes) that comply with OCI specs, reducing tool lock-in.

3. **Automation and CI/CD:**  
   With standardized containers, DevOps teams can automate builds, tests, and deployments more effectively, leveraging OCI-compliant runtimes and images across their pipelines.

4. **Security and Compliance:**  
   By adhering to a standard, organizations can more easily implement security measures and compliance checks on container images and runtimes, improving the overall reliability and security of deployments.

---

### **Conclusion:**
The Open Container Initiative (OCI) plays a crucial role in creating a unified and interoperable container ecosystem. For DevOps teams, adopting OCI standards ensures portability, flexibility, and consistency across environments, enabling more efficient and reliable software delivery.
## What Can I Use Docker For?

### Fast, Consistent Delivery of Applications

Docker streamlines the development lifecycle by providing standardized environments with containers, perfect for CI/CD workflows. Developers can work on code locally and share it via Docker, ensuring consistency across all environments. The application can be tested and validated in containerized test environments and deployed by pushing updated images to production.

### Responsive Deployment and Scaling

Docker’s container-based approach allows highly portable workloads, making it easy to run containers in various setups, from local machines to cloud providers. This flexibility supports rapid scaling of applications up or down as needed.

### Efficient Use of Resources

Docker containers are lightweight, making them ideal for high-density environments where resource efficiency is crucial. They allow you to run more workloads on the same hardware, reducing costs and improving performance.

---

## How to Install Docker

To install Docker on your system, follow the official Docker installation guides:

- **[Install Docker for Windows](https://docs.docker.com/desktop/install/windows-install/)**
- **[Install Docker for macOS](https://docs.docker.com/desktop/install/mac-install/)**
- **[Install Docker for Linux](https://docs.docker.com/engine/install/)**

---

## [Play with Docker](https://labs.play-with-docker.com/)



# Setting Up User Permissions with Docker**

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

### **Importance in DevOps:**
- **Efficiency:** Running Docker commands without `sudo` speeds up workflows.
- **Automation:** Avoids permission issues when running Docker commands in scripts or CI/CD pipelines.
- **Security Considerations:** Be cautious when adding users to the Docker group, as it grants elevated privileges similar to root access.


---


# Docker User Permissions, Basic Commands, and Image Management


## **1. User Permissions and Docker Group Setup**  
By default, Docker requires `sudo` to run commands. Adding a user to the **docker** group allows them to run Docker commands without `sudo`, improving efficiency and automation.

### **Steps:**
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

## **2. Managing Docker Images and Containers**

### **List Images:**
```sh
docker image ls
```
- Shows all downloaded images.

### **Pull an Image:**
```sh
docker image pull ubuntu:latest
```
- Downloads the latest version of the Ubuntu image.

### **Run a Container:**
```sh
docker container run -it ubuntu:latest /bin/bash
```
- Launches a container interactively with a bash shell.

### **Exit a Container Without Stopping:**
- **Shortcut:** `Ctrl + P, Ctrl + Q`

### **Reattach to a Running Container:**
```sh
docker container exec -it <container_name> bash
```

## **Stop a Running Container:**
```sh
docker container stop <container_name>
```

### **Start a Stopped Container:**
```sh
docker container start <container_name>
```

### **Remove a Stopped Container:**
```sh
docker container rm <container_name>
```

---

## **3. Building and Running Custom Images**  
Useful for DevOps teams creating custom applications.

### **Clone a Repository with a Dockerfile:**
```sh
git clone https://github.com/nigelpoulton/psweb.git
```

### **Inspect the Dockerfile:**
```sh
cat Dockerfile
```
- Displays the contents of the Dockerfile, detailing the image build instructions.

### **Build a Custom Image:**
```sh
docker image build -t test:latest .
```
- Builds an image from the Dockerfile in the current directory (`.`) and tags it as `test:latest`.

### **List Built Images:**
```sh
docker image ls
```
- Confirms the creation of the new image alongside any base images used.

### **Run a Container from the Custom Image:**
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

## **4. DevOps Perspective**  
- **Automation:** Automating Docker tasks in CI/CD pipelines boosts efficiency.  
- **Customization:** Custom images allow teams to standardize environments.  
- **Flexibility:** Docker supports dynamic deployments and simplifies testing in isolated environments.  


# **The Docker Engine: Overview and Deep Dive**  


## **1. Docker Engine - TLDR**  

![Docker Client](./Img/5.png)
The Docker Engine manages the lifecycle of containers. It consists of several components that work together to build, run, and manage containers efficiently.

---

## **2. Docker Engine - Deep Dive Components**  

![Docker Engine](./Img/6.png)

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









