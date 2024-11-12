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

# Docker 

## What is Docker?

Docker is an open platform for developing, shipping, and running applications. It enables you to separate your applications from your infrastructure so you can deliver software quickly. With Docker, you can manage your infrastructure in the same way as your applications, significantly reducing the delay between writing code and running it in production.

## The Docker Platform

Docker provides the ability to package and run an application in a loosely isolated environment called a container. Containers are lightweight and contain everything needed to run the application, allowing you to avoid dependencies on the host environment. You can share containers while ensuring everyone gets the same environment for the application.

Docker provides tools for managing the lifecycle of containers:

1. Develop your application and its supporting components using containers.
2. Distribute and test your application using containers.
3. Deploy your application as a container in production, regardless of the environment (local data center, cloud provider, or hybrid).

## What Can I Use Docker For?

### Fast, Consistent Delivery of Applications

Docker streamlines the development lifecycle by allowing developers to work in standardized environments using containers, perfect for CI/CD workflows.

**Example Scenario**:
- Developers write code locally and share it using Docker containers.
- Applications are tested in a containerized test environment.
- Fixes are redeployed and validated in testing before reaching production.
- Deployment is as simple as pushing an updated image to the production environment.

### Responsive Deployment and Scaling

Docker’s container-based platform allows highly portable workloads. Containers can run locally, in data centers, on cloud providers, or in a mixed environment. Docker's lightweight nature makes it easy to scale workloads up or down based on demand.

### Running More Workloads on the Same Hardware

Docker is lightweight and fast, making it ideal for high-density environments and smaller deployments where cost-effectiveness and resource optimization are essential.

## Docker Architecture

Docker uses a client-server architecture:
- The Docker client talks to the Docker daemon (`dockerd`), which builds, runs, and distributes containers.
- The Docker client and daemon can run on the same system, or a client can connect to a remote daemon.
- They communicate using a REST API over UNIX sockets or a network interface.
- Another Docker client, Docker Compose, lets you work with applications consisting of a set of containers.

### Docker Architecture Diagram

![docker-architecture](./Img/docker-architecture.png)

### Docker Daemon

The Docker daemon (`dockerd`) listens for Docker API requests and manages Docker objects like images, containers, networks, and volumes. It can also communicate with other daemons to manage Docker services.

### Docker Client

The Docker client (`docker`) is the main interface for interacting with Docker. It sends commands to `dockerd` to execute tasks like running containers, creating images, etc. The Docker client can connect to multiple daemons.

### Docker Desktop

Docker Desktop is an easy-to-install application for Mac, Windows, or Linux environments. It includes Docker Daemon (`dockerd`), Docker CLI (`docker`), Docker Compose, Kubernetes, and Credential Helper.

### Docker Registries

A Docker registry stores Docker images. Docker Hub is a public registry by default, but you can also run a private registry. Commands like `docker pull` or `docker run` retrieve images from the registry, and `docker push` uploads images to the registry.

## Docker Objects

When using Docker, you work with various objects, including images, containers, networks, volumes, and plugins.

### Images

An image is a read-only template for creating Docker containers. It’s often based on another image, with additional customizations. You might build your own images using a Dockerfile or use existing images from a registry.

- A Dockerfile defines the steps to create an image, where each instruction creates a layer.
- Changes to a Dockerfile only rebuild modified layers, making images lightweight and fast.

### Containers

A container is a runnable instance of an image, with its own filesystem, network, and isolation from other containers and the host system.

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









