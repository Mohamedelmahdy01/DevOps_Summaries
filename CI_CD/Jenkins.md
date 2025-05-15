
# Introduction to CI/CD

CI/CD, which stands for **Continuous Integration** and **Continuous Delivery/Deployment**, aims to streamline and accelerate the software development lifecycle. It enables teams to quickly integrate code changes, automatically test them, and deploy new features with minimal manual intervention.

---

## Overview

- **Continuous Integration (CI)** is the practice of automatically and frequently integrating code changes into a shared repository. With CI, developers commit code several times a day, triggering automated builds and tests that catch issues early and ensure that the codebase remains stable.
  
- **Continuous Delivery (CD)** automates the process of preparing code for production. It ensures that the codebase is always in a deployable state by running a series of automated tests and build steps. In continuous delivery, a manual trigger is usually required to deploy to production.
  
- **Continuous Deployment (CD)** takes automation one step further by automatically releasing every change that passes the tests into the production environment without any manual steps.

Together, these practices create a **CI/CD pipeline** that supports agile development and enables development and operations teams to work together seamlessly.

---

## CI/CD Flow

A typical CI/CD pipeline consists of the following stages:

1. **Source Code Management**:  
   Developers commit code changes to a version control system (e.g., Git).

2. **Build**:  
   Automated systems compile the code into an executable format or container image.

3. **Automated Testing**:  
   A suite of tests—including unit, integration, and sometimes end-to-end tests—is executed to validate that the new code does not break existing functionality.

4. **Artifact Creation**:  
   Successful builds produce deployable artifacts such as binaries, packages, or Docker images.

5. **Deployment**:  
   - **Continuous Delivery**: Artifacts are automatically deployed to a staging environment and are ready for production, pending manual approval.
   - **Continuous Deployment**: Artifacts that pass all tests are automatically released into production.

6. **Monitoring and Feedback**:  
   Post-deployment, monitoring tools track application performance and health, providing feedback that can be used to improve future releases.

---

## Why is CI/CD Important?

CI/CD plays a vital role in modern software development by:

- **Reducing Risk**:  
  Frequent integration and automated testing catch issues early, reducing the risk of large-scale failures.

- **Increasing Efficiency**:  
  Automation minimizes manual processes, leading to faster and more reliable deployments.

- **Improving Code Quality**:  
  Continuous testing ensures that every code change is validated, maintaining high standards for the codebase.

- **Enhancing Responsiveness**:  
  Rapid feedback loops allow teams to quickly incorporate user feedback and release new features, keeping applications up-to-date and competitive.

- **Simplifying Complexity**:  
  Incremental updates are easier to manage and troubleshoot compared to large, monolithic releases.

---

## Continuous Integration (CI)

CI focuses on merging code changes into a shared repository regularly, which helps prevent the build-up of conflicts. Key elements include:

- **Automated Builds and Tests**:  
  Every code commit triggers a build process along with unit and integration tests to verify that the new changes work correctly.

- **Frequent Code Merges**:  
  Regular integration helps ensure that multiple developers can work on different features without conflicts.

- **Rapid Feedback**:  
  Immediate test results enable developers to fix issues as soon as they are introduced.

---

## Continuous Delivery vs. Continuous Deployment

- **Continuous Delivery**:  
  In this model, every change that passes automated tests is automatically prepared for production release. However, deployment to production requires a manual approval step. This ensures the codebase is always in a deployable state.

- **Continuous Deployment**:  
  This approach automates the entire process, so every change that passes all tests is immediately released into production. It requires a robust testing framework to ensure quality since there is no manual gate before production.

---

## CI/CD and DevOps

CI/CD is a cornerstone of the DevOps culture, which emphasizes close collaboration between development and operations teams. By automating the process from code commit to production deployment, CI/CD helps:

- **Accelerate Development Cycles**:  
  Automation shortens the time between code changes and live deployment, enabling rapid iteration.

- **Enhance Collaboration**:  
  Shared responsibility between teams improves communication and speeds up problem resolution.

- **Integrate Security**:  
  Security measures, such as automated vulnerability scans and compliance checks, can be built into the CI/CD pipeline, ensuring that code meets quality and security standards before reaching production.

---

## CI/CD Security

Security is a critical component of any CI/CD pipeline. Best practices include:

- **Automated Security Testing**:  
  Integrate vulnerability scanning and security checks early in the pipeline to detect and fix issues before deployment.

- **Access Controls and Secrets Management**:  
  Use encrypted storage and strict access permissions to protect sensitive data and credentials.

- **Shift-Left and Shift-Right Security**:  
  Implement security testing at every stage of the pipeline—from code integration to post-deployment monitoring—to ensure comprehensive protection.

---

## Common CI/CD Tools

There is a wide array of tools available to implement CI/CD pipelines, including:

- **Jenkins**:  
  A popular open-source automation server for building, testing, and deploying code.

- **GitLab CI/CD**:  
  An integrated solution that supports the entire CI/CD process within the GitLab ecosystem.

- **CircleCI, Travis CI, Bamboo**:  
  Cloud-based or self-hosted platforms that offer robust CI/CD functionalities.

- **Tekton Pipelines**:  
  A Kubernetes-native framework for creating cloud-native CI/CD pipelines.

- **Spinnaker**:  
  A continuous delivery platform designed for multi-cloud environments.

Additional tools for configuration management (like Ansible, Chef, and Puppet), containerization (Docker), and orchestration (Kubernetes) often complement CI/CD workflows, helping to create reproducible and scalable environments.

---

## Conclusion

CI/CD transforms the software development lifecycle by automating the integration, testing, and deployment processes. This automation reduces risks, improves code quality, and accelerates the delivery of new features and updates. By adopting CI/CD practices, teams can create more efficient workflows, respond faster to user feedback, and maintain a competitive edge in today’s fast-paced development landscape.

---
# Jenkins and Virtual Machine Setup Guide

## Introduction to Jenkins
- **What is Jenkins?**
  - Open-source automation server used for Continuous Integration (CI) and Continuous Delivery (CD).
  - Automates tasks like building, testing, and deploying software.
  - Integrates with tools like Git, Maven, Ansible, and AWS.

- **Key Use Cases**
  - Automate repetitive development tasks.
  - Implement CI/CD pipelines.
  - Streamline integration with cloud services and DevOps tools.

---

## Lab Environment Setup with VirtualBox

### Step 1: Install VirtualBox
- Download VirtualBox for Windows from [virtualbox.org](https://www.virtualbox.org/).
- Follow the installation wizard (default settings recommended). 

### Step 2: Create a CentOS Virtual Machine (VM)
1. **Download CentOS Minimal ISO**
   - Visit [CentOS download page](https://www.centos.org/download/).
   - Choose the minimal 64-bit ISO (e.g., `CentOS-7-x86_64-Minimal-XXXX.iso`).

2. **Configure VM in VirtualBox**
   - Click **New** > Name: `Jenkins-Lab` > Type: **Linux** > Version: **Red Hat (64-bit)**.
   - Allocate Resources:
     - RAM: **2 GB** (adjust based on host machine capabilities).
     - Hard Disk: **20 GB** (VDI format, dynamically allocated).

3. **Network Settings**
   - Use **Bridged Adapter** for network connectivity:
     - Allows the VM to get an IP from your local network (like a physical device).
     - Choose `Ethernet` or `Wi-Fi` based on your host machine's active connection.

---

## CentOS Installation Guide

### Step 3: Install CentOS on the VM
1. **Boot from ISO**
   - Start the VM > Select the CentOS ISO as the startup disk.
   - Choose **Install CentOS 7** from the boot menu.

2. **Initial Configuration**
   - Language: **English**.
   - Software Selection: **Minimal Install** (no GUI).
   - Disk Partitioning: Use **Automatic Partitioning**.
   - Network Configuration:
     - Enable the Ethernet adapter to retrieve an IP via DHCP.
     - Note the assigned IP for future access (e.g., SSH).

3. **User Setup**
   - **Root Password**: Set a secure password (e.g., `123456`).
   - **Create a Non-Root User**:
     - Username: `jenkins-admin`.
     - Check **Make this user administrator** to grant sudo privileges.
     - Set a password (e.g., `123456`).

4. **Complete Installation**
   - Click **Begin Installation** > Reboot after completion.

---

## Post-Installation Steps

### Step 4: Remote Access with PuTTY
1. **Install PuTTY on Windows**
   - Download from [putty.org](https://www.putty.org/).
   - Install using default settings.

2. **Connect to VM**
   - Launch PuTTY > Enter VM's IP address:
     ```bash
     ssh jenkins-admin@<VM_IP>
     ```
   - First connection: Accept security warning.
   - Adjust font size in PuTTY settings if needed (Window > Appearance).

3. **Verify Connectivity**
   ```bash
   ping google.com  # Ensure internet access
   ip a            # Confirm IP address
   ```

---

## Docker Installation

### Step 5: Install Docker Engine
1. **Add Docker Repository**
   ```bash
   sudo yum install -y yum-utils
   sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
   ```

2. **Install Docker Packages**
   ```bash
   sudo yum install docker-ce docker-ce-cli containerd.io
   ```

3. **Start and Enable Docker**
   ```bash
   sudo systemctl start docker
   sudo systemctl enable docker
   ```

4. **Configure User Permissions**
   ```bash
   sudo usermod -aG docker jenkins-admin
   ```
   - **Important**: Log out and back in for group changes to take effect.

5. **Verify Installation**
   ```bash
   docker ps  # Should show empty container list
   ```

---

## Docker Compose Installation

### Step 6: Install Docker Compose
1. **Download Binary**
   ```bash
   sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   ```

2. **Set Permissions**
   ```bash
   sudo chmod +x /usr/local/bin/docker-compose
   ```

3. **Verify Installation**
   ```bash
   docker-compose --version
   ```

---

## Jenkins Installation with Docker

### Step 7: Deploy Jenkins Container
1. **Pull Jenkins Image**
   ```bash
   docker pull jenkins/jenkins:lts-jdk11 # or docker pull jenkins:jdk17
   ```

2. **Create Persistent Storage**
   ```bash
   mkdir ~/jenkins_data
   ```

3. **Run Jenkins Container**
   ```bash
   docker run -d \
   --name jenkins \
   -p 8080:8080 \
   -p 50000:50000 \
   -v ~/jenkins_data:/var/jenkins_home \
   jenkins/jenkins:lts-jdk17
   ```

4. **Access Jenkins**
   - Open web browser: `http://localhost:8080`
   - Retrieve initial admin password:
     ```bash
     docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
     ```

---


# Jenkins Docker Deployment Guide

## 1. Prepare Docker Environment
### Create Project Directory
```bash
mkdir jenkins-docker && cd jenkins-docker
mkdir jenkins_home
```
### get user id (e.g., `1000`).
```bash
   id # to get user id (output = 1000)
```
### Set Permissions
```bash
sudo chown 1000:1000 -R jenkins_home
```

## 2. Docker Compose Configuration
Create `docker-compose.yml`:
```yaml
services:
  jenkins:
    container_name: jenkins
    image: jenkins/jenkins:jdk17
    ports:
      - "8080:8080"
      - "50000:50000"
    volumes:
      - jenkins_home:/var/jenkins_home
    networks:
      - net

volumes:
  jenkins_home:
networks:
  net:
```

## 3. Start Jenkins Container
```bash
docker-compose up -d
```

## 4. Access Jenkins
1. Get initial admin password:
```bash
docker logs jenkins
```
2. Access in browser: `http://localhost:8080`

## 5. Initial Setup
1. **Install Plugins**:
   - Select "Install suggested plugins"
   - Wait for installation to complete

2. **Create Admin User**:
   ```plaintext
   Username: admin
   Password: 12345678 (for lab use only)
   Email: jenkins@example.com
   ```

3. **Instance Configuration**:
   - Keep default URL settings
   - Click "Save and Finish"

## 6. Container Management
### Common Commands
```bash
# Stop container
docker-compose stop

# Start container
docker-compose start

# Restart container
docker-compose restart

# View logs
docker logs jenkins

# Destroy container
docker-compose down
```

## 7. Advanced Configuration
### Local DNS Setup (Windows)
1. Edit `C:\Windows\System32\drivers\etc\hosts`
2. Add entry:
```plaintext
<VM_IP>  jenkins.local
```
3. Access via: `http://jenkins.local:8080`

### Alternative SSH Clients
Use either:
- **PuTTY** (Windows)
- **WSL/Ubuntu** (Recommended for better visibility)
```bash
ssh jenkins-admin@jenkins.local
```

## 8. Troubleshooting
### Common Issues
1. **Container Not Starting**:
```bash
# Check permissions
sudo chown 1000:1000 -R jenkins_home

# Rebuild container
docker-compose up -d --force-recreate
```

2. **Port Conflicts**:
- Verify no other services using ports 8080/50000
- Adjust ports in `docker-compose.yml` if needed


---

# Getting Started with Jenkins
 
This guide provides an in-depth overview of Jenkins—a powerful, open-source automation server used for continuous integration and continuous delivery (CI/CD). You'll learn how to navigate the Jenkins dashboard, create and manage jobs, incorporate dynamic variables, and handle file outputs—all within a Docker containerized environment.

## Introduction to the Jenkins Dashboard

After logging in with the default credentials (**admin/1234**—remember to change these for security), you'll land on the Jenkins dashboard. Here’s what you need to know:

- **New Item**: Use this option to create new jobs, pipelines, or multi-branch projects.
- **People**: Manage users, roles, and permissions to control access.
- **Build History**: View detailed logs and statistics from recent job executions, which is crucial for troubleshooting.
- **Manage Jenkins**: Access system configuration, security settings, plugin management, and credential storage.

**Note:** Jenkins runs inside a Docker container. This means all operations occur within container isolation, ensuring a consistent and reproducible environment.

## Creating Your First Jenkins Job

To create a job:

1. **Create a New Item**:  
   Click on **New Item** on the dashboard. Choose **Freestyle Project**, name it (e.g., "My First Job"), and click **OK**.

2. **Configure the Job**:  
   In the build section of the job configuration, add an **Execute Shell** build step. Enter a simple command like:
   ```bash
   echo "Hello World"
   ```
   This command prints "Hello World" to the console output when the job runs.

3. **Execution Context**:  
   Remember, Jenkins jobs execute within the Docker container. To inspect the container’s environment, use:
   ```bash
   docker exec -it jenkins bash
   ```
   This opens a bash shell inside the container, allowing you to explore its filesystem and environment.

## Using Dynamic Variables and Command Substitution

Jenkins jobs can dynamically generate output using shell variables and command substitution. For example, you can include a timestamp in your job’s output:
```bash
CURRENT_DATE=$(date)
echo "Current date/time: $CURRENT_DATE"
```
- **Command Substitution**: The syntax `$(command)` executes the command and replaces it with its output.
- **Dynamic Output**: Capturing and printing variables (like the current date and time) adds context to your build logs, making them more informative.

## Output Redirection and File Management

Managing file output within Jenkins is straightforward. You can redirect command outputs to files as shown below:
```bash
# Redirect output to a file (overwrites if the file exists)
echo "User: $(whoami)" > /tmp/user_info.txt

# Append additional information to the file
date >> /tmp/user_info.txt
```
- The `>` operator creates or overwrites the file.
- The `>>` operator appends data to the file without overwriting existing content.

**Important Considerations:**
- Files created in directories like `/tmp` exist only within the container’s filesystem.
- To persist files beyond the container’s lifecycle or access them from the host machine, use Docker volumes.
- To verify the file contents, you can run:
  ```bash
  docker exec -it jenkins cat /tmp/user_info.txt
  ```


---

## Execute Bash Scripts from Jenkins

Jenkins can run shell scripts as part of its build steps, allowing you to automate tasks such as deployments, testing, and notifications.

### Steps to Execute a Bash Script

1. **Create the Bash Script**

   Create a script file (e.g., `greet.sh`) with the following content:
   ```bash
   #!/bin/bash
   # greet.sh: A simple greeting script that takes two parameters.
   # $1: First name
   # $2: Last name

   if [ -z "$1" ] || [ -z "$2" ]; then
     echo "Usage: $0 <FirstName> <LastName>"
     exit 1
   fi

   echo "Hello $1 $2"
   ```
   - **Explanation**:
     - `#!/bin/bash` specifies that the script should run using Bash.
     - The script checks if both parameters are provided and displays a usage message if not.
     - It then prints a greeting message using the passed parameters.

2. **Make the Script Executable**

   Set the executable permission on your script:
   ```bash
   chmod +x greet.sh
   ```

3. **Copy the Script to the Jenkins Container**

   Use Docker to copy the script into the Jenkins container’s filesystem:
   ```bash
   docker cp greet.sh jenkins:/tmp/greet.sh
   ```
   - **Tip**: If you frequently update your scripts, consider using Docker volumes to share files between the host and container.

4. **Configure the Jenkins Job**

   - In your Jenkins job configuration, add a build step that executes a shell command.
   - Use the command:
     ```bash
     /tmp/greet.sh "Mohamed" "Elmahdy"
     ```
     or 
     ```bash
     NAME=Mohamed
     LASTNAME=Elmahdy
     /tmp/greet.sh $NAME $LASTNAME
     ```
   - **Note**: Replace `"Mohamed"` and `"Elmahdy"` with desired values or parameters passed from Jenkins.

5. **Troubleshooting and Testing**

   - Use the command:
     ```bash
     docker exec -it jenkins bash
     ```
     to open a shell inside the Jenkins container and manually test the script.
   - Check the job’s console output in Jenkins for logs and any error messages.

---

## Add Parameters to Jenkins Jobs

Adding parameters to your jobs allows for dynamic input, making your build processes more flexible and customizable.

### Creating String Parameters

1. **Enable Parameterization**

   - In the job configuration, check the option **"This project is parameterized"**.

2. **Add a String Parameter**

   - **Parameter Name**: `FIRST_NAME`
   - **Default Value**: `Mohamed`
   - **Description**: (Optional) Provide a description so users know what input is expected.

3. **Use Parameters in the Build Script**

   In your build step (Execute Shell), reference the parameter using environment variable syntax:
   ```bash
   echo "Hello ${FIRST_NAME}"
   ```
   - **Note**: Jenkins passes parameters as environment variables, making them accessible in scripts.

### Execution Flow

- When the job is triggered, Jenkins prompts the user to input or confirm parameter values.
- The script then uses the provided values, enabling dynamic behavior based on user input.

---

## Create List (Choice) Parameters

Choice parameters allow you to define a set of predefined options from which users can select.

### Configuration Steps

1. **Add a Choice Parameter**

   - **Parameter Name**: `LAST_NAME`
   - **Choices**:  
     ```
     Mahmoud
     Elmahdy
     Abdulkader
     ```
   - **Description**: (Optional) Explain what the choices represent.

2. **Use the Choice Parameter in the Script**

   In your shell command, reference the parameter:
   ```bash
   echo "Selected Last Name: ${LAST_NAME}"
   ```
   - **Behavior**:  
     - Jenkins displays a dropdown list with the specified choices.
     - The selected value is passed to the script via the environment variable `${LAST_NAME}`.

---

## Boolean Parameters & Conditional Logic

Boolean parameters provide a simple true/false option that can control the flow of your build scripts.

### Add a Boolean Parameter

1. **Configure the Boolean Parameter**

   - **Parameter Name**: `SHOW_DETAILS`
   - **Default Value**: Checked (interpreted as `true`)
   - **Description**: (Optional) Explain that this parameter toggles additional output.

2. **Implement Conditional Logic in the Script**

   Modify your script to react to the boolean parameter:
   ```bash
   #!/bin/bash
   # greet_with_condition.sh: Greets only if SHOW_DETAILS is true.
   # $1: First name, $2: Last name, $SHOW_DETAILS: Boolean parameter
   NAME=$1
   LAST_NAME=$2
   SHOW_DETAILS=$3


   if [ "${SHOW_DETAILS}" = "true" ]; then
     echo "Hello $1 $2"
   else
     echo "Enable SHOW_DETAILS to view the full greeting."
   fi
   ```
   - **Usage Example**:
     - **True**: If `SHOW_DETAILS` is true, the output will be `Hello John Doe`.
     - **False**: If `SHOW_DETAILS` is false, the output will be `Enable SHOW_DETAILS to view the full greeting.`

   - **Note**: Jenkins converts boolean parameters to strings (`true` or `false`), so ensure your comparisons reflect that.

3. **Copy the Script to the Jenkins Container**

   Use Docker to copy the script into the Jenkins container’s filesystem:
   ```bash
   docker cp script.sh jenkins:/tmp/script.sh
   ```

4. **Configure the Jenkins Job**

   - In your Jenkins job configuration, add a build step that executes a shell command.
   - Use the command:
     ```bash
     /tmp/script.sh "Mohamed" "Elmahdy" false
     ```
     or 
     ```bash
     NAME=Mohamed
     LASTNAME=Elmahdy
     SHOW_DETAILS=false
     /tmp/greet.sh $NAME $LASTNAME $SHOW_DETAILS
     ```

---

## Key Points and Best Practices

- **Containerized Environment**:  
  All Jenkins operations occur within a Docker container, ensuring isolation and consistency across development and production environments.

- **Shell Integration**:  
  Jenkins fully supports Bash scripting. This allows you to execute complex shell commands, use dynamic variables, and perform real-time output redirection.

- **File Persistence**:  
  Use Docker volumes to share and persist files between the container and the host machine, ensuring that your build artifacts and logs are not lost when the container restarts.

- **Debugging**:  
  Always review the Jenkins console output after each job execution. It provides real-time feedback and detailed logs that are invaluable for troubleshooting.

- **Security and Maintenance**:  
  - Update default credentials and manage user permissions carefully.
  - Regularly update plugins and backup your Jenkins configuration to ensure a secure and reliable CI/CD environment.


- **Parameter Naming Conventions**
   - Use clear, descriptive names (e.g., `ENVIRONMENT` instead of `env`) to reduce ambiguity.
   
- **Error Handling in Scripts**
   - Validate parameters at the beginning of your script and provide usage instructions if needed.
   - Use exit codes to signal errors, making it easier to detect failures in the Jenkins job.

- **Default Values**
   - Set sensible default values to streamline user input and reduce errors during manual triggers.

- **Script Organization**
   - Include comments in your scripts for maintainability.
   - Consider modularizing common functions into separate scripts or functions.

- **Logging and Debugging**
   - Ensure your scripts produce detailed logs to help troubleshoot issues during job execution.
   - Regularly check Jenkins console output to verify that parameters are correctly passed and scripts execute as expected.

---

# Jenkins & Docker 
This guide explains how to integrate Jenkins with Docker and SSH to execute jobs on remote Docker containers. In this setup, you’ll work with two main containers:
- **Jenkins Container**: Runs the main CI/CD server.
- **Remote Host Container**: A CentOS-based SSH server used as the target for job execution.

Secure, passwordless SSH connections are established using SSH key authentication. Follow the steps below to set up and test this integration.

---

## 1. Create the Remote SSH Server Container

### 1.1 Dockerfile Configuration

Create a `Dockerfile` for your SSH server container. This container uses CentOS 7 (for compatibility) and sets up an SSH service:

```dockerfile
FROM centos:latest

# Install OpenSSH Server and Clients
RUN yum install -y openssh-server openssh-clients

# Create a new user and set a password
RUN useradd remote_user && \
    echo "remote_user:1234" | chpasswd && \
    mkdir /home/remote_user/.ssh && \
    chmod 700 /home/remote_user/.ssh

# Copy the public SSH key into authorized_keys for passwordless authentication
COPY remote-key.pub /home/remote_user/.ssh/authorized_keys
RUN chown remote_user:remote_user /home/remote_user/.ssh -R && \
    chmod 600 /home/remote_user/.ssh/authorized_keys

# Generate SSH host keys and start the SSH daemon
RUN ssh-keygen -A
CMD ["/usr/sbin/sshd", "-D"]
```

or 
```dockerfile
FROM almalinux:9

USER root

RUN dnf install -y openssh-server openssh-clients && \
    dnf clean all

RUN useradd -m -s /bin/bash remote_user && \
    mkdir /home/remote_user/.ssh && \
    chmod 700 /home/remote_user/.ssh

COPY jenkins-remote-key.pub /home/remote_user/.ssh/authorized_keys

RUN chown -R remote_user:remote_user /home/remote_user/.ssh && \
    chmod 600 /home/remote_user/.ssh/authorized_keys

RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config && \
    echo "AllowUsers remote_user" >> /etc/ssh/sshd_config

RUN ssh-keygen -A && \
    chmod 600 /etc/ssh/sshd_config

CMD ["/usr/sbin/sshd", "-D", "-e"]

```

### Key Steps Explained:
- **SSH Installation**: Installs OpenSSH server/client packages.
- **User Creation**: A new user `remote_user` is created with password `1234`.
- **SSH Key Setup**:  
  - A public key (to be generated later) is copied into `authorized_keys` for secure, passwordless access.
  - Directory and file permissions are set to secure the SSH configuration.
- **Service Configuration**:  
  - Host keys are generated (`ssh-keygen -A`).
  - The container runs the SSH daemon in the foreground.

---

## 2. Set Up Docker Compose

Use Docker Compose to run both the Jenkins and remote host containers on an isolated network.

### docker-compose.yml

  ```yaml
  version: '3.8'

services:
  jenkins:
    container_name: jenkins
    image: jenkins-ansible
    build:
      context: jenkins-ansible
      dockerfile: Dockerfile.jenkins-ansible
    networks:
      - net  # Ensure this network is defined below or use "host" mode
    ports:
      - "8080:8080"
      - "50000:50000"
    volumes:
      - /home/jenkins/jenkins-docker/jenkins-data:/var/jenkins_home
      - /var/run/docker.sock:/var/run/docker.sock
      #- /usr/bin/docker:/usr/bin/docker  # Optional: Mount Docker CLI binary if not in the image

  remote-host:
    container_name: remote-host
    image: remote-host
    build:
      context: centos
      dockerfile: Dockerfile.remote-host

    networks:
      - net

networks:
  net:  # Networks section (no trailing colon here)

volumes:
  jenkins-data:
   ```
### Key Features:
- **Network Isolation**: Both containers are on the same Docker network (`net`), enabling communication.
- **Custom Build**: The remote host container is built from your custom Dockerfile.
- **Persistent Jenkins Data**: A Docker volume (`jenkins-data`) is used for Jenkins home directory persistence.

---

## 3. Configure SSH Key Authentication

### 3.1 Generate SSH Keys

Generate an RSA key pair on your host machine:
```bash
ssh-keygen -t rsa -f jenkins-remote-key
```
This command creates:
- `jenkins-remote-key` (private key)
- `jenkins-remote-key.pub` (public key)

### 3.2 Configure the Remote Host Container

If not already copied via Dockerfile, manually copy the public key into the container:
```bash
docker cp remote-key.pub remote-host:/home/remote_user/.ssh/authorized_keys
```
Then, set appropriate permissions (if needed):
```bash
docker exec -it remote-host chmod 700 /home/remote_user/.ssh
docker exec -it remote-host chmod 600 /home/remote_user/.ssh/authorized_keys
```

---

## 4. Connect from the Jenkins Container

### 4.1 Test SSH Connection Manually

To verify the SSH connection, access the Jenkins container and attempt an SSH connection:
```bash
docker exec -it jenkins bash
ssh -i /tmp/remote-key remote_user@remote-host
```
*Note*: Ensure that the private key (`remote-key`) is copied into the Jenkins container at a suitable location (e.g., `/tmp/remote-key`) with secure permissions.

### 4.2 Jenkins Job Configuration

In your Jenkins job:
1. **Add SSH Credentials**:
   - **Username**: `remote_user`
   - **Private Key**: Paste the content of `remote-key` (do not commit your private key to version control).
   
2. **Configure the Build Step**:
   In the job’s shell build step, use a command like:
   ```bash
   ssh -o StrictHostKeyChecking=no -i /var/jenkins_home/.ssh/id_rsa remote_user@remote-host "echo Hello World"
   ```
   Adjust the path to your private key if you stored it elsewhere.

---

## 5. Troubleshooting Common Issues

| **Issue**                 | **Solution**                                                                              |
|---------------------------|-------------------------------------------------------------------------------------------|
| **CentOS Compatibility**  | Use the `centos:7` base image to avoid issues with newer CentOS versions.                 |
| **SSH Key Permissions**   | Ensure the private key has `600` permissions and the `.ssh` directory is set to `700`.     |
| **Connection Refused**    | Verify that both containers are on the same Docker network (`net`) and that SSH is running. |
| **Key Not Found**         | Confirm that the key file is in the correct location inside the Jenkins container.         |

### Key Commands for Verification:
```bash
# Build and start containers
docker-compose build
docker-compose up -d

# Access Jenkins container shell
docker exec -it jenkins bash

# Test network connectivity from Jenkins container
ping remote-host
```

---



## Installing Jenkins Plugins (SSH Plugin)

### Overview

To establish secure connections between Jenkins and remote hosts, you must install the SSH plugin. This plugin allows Jenkins to execute shell commands on remote machines over SSH.

### Detailed Steps

1. **Verify Internet Connectivity**
   - Ensure that your Jenkins container (or VM) has a working internet connection.
   - Test by running:
     ```bash
     ping -c 4 google.com
     ```
   - A successful ping confirms that Jenkins can reach external repositories.

2. **Access the Jenkins Plugin Manager**
   - **Log in to Jenkins Dashboard**: Open your Jenkins URL in a web browser and log in.
   - Navigate to **Manage Jenkins**.
   - Click on **Manage Plugins**. In the Plugin Manager, you will see several tabs:
     - **Installed Plugins**: Shows plugins currently in use.
     - **Available Plugins**: Shows plugins available for installation.
     - **Updates**: Lists plugins with available updates.

3. **Search and Install the SSH Plugin**
   - Under the **Available Plugins** tab, type “SSH” in the search box.
   - Locate the SSH plugin from the search results.
   - Check the box next to the SSH plugin and click **Install without restart** (or **Download now and install after restart** if prompted).
   - Wait for the plugin to download and install.
   - After installation, verify that the SSH plugin appears under the **Installed Plugins** tab.

---

## Integrating Your Docker SSH Server with Jenkins

### Overview

This section describes how to configure Jenkins to communicate with your Docker-based SSH server (the remote host). You will define the remote host details and set up the credentials required for secure, passwordless SSH connections.

### Detailed Steps

1. **Configure the Remote Host in Jenkins**
   - From the Jenkins dashboard, click on **Manage Jenkins** > **Configure System**.
   - Scroll down to the section labeled **SSH remote hosts** (this may be within an SSH plugin-specific configuration section).
   - Click **Add** (or a similar button) to create a new remote host entry.
   - **Hostname**: Enter the internal hostname as defined in your Docker Compose file (e.g., `remote-host`).
   - **Port**: Enter the SSH port (default is `22`).

2. **Set Up Connection Details**
   - Specify any additional options such as connection timeout, retry count, and default remote directory if available.
   - These settings ensure that Jenkins can reliably connect even if there are minor network delays.

3. **Add Credentials (Username & Private Key)**
   - Go to **Manage Jenkins** > **Global Credentials**.
   - Click **Add Credentials**.
   - Choose the **Username with private key** option.
   - **Username**: Enter the SSH username (e.g., `remote_user` as configured in your Dockerfile).
   - **Private Key**: Paste the content of your private key file (e.g., the content of `remote-key` generated using `ssh-keygen`).
   - Optionally, add a description (e.g., “SSH key for remote Docker host”).
   - Save the credentials.

4. **Test the Connection**
   - Return to the **Configure System** page under SSH remote hosts.
   - Select the newly added credentials.
   - Click **Check Connection** (or similar) to test if Jenkins can successfully connect to the remote host.
   - A successful test confirms that the configuration is correct.
   - Save the configuration once verified.

---

## Running a Jenkins Job on Your Docker Remote Host via SSH

### Overview

This section explains how to create and run a Jenkins job that executes commands on your Docker-based remote host through SSH. This allows you to offload tasks (such as deployments, file operations, or other maintenance tasks) to remote containers.

### Detailed Steps

1. **Create a New Jenkins Job**
   - From the Jenkins dashboard, click on **New Item**.
   - Enter a job name (e.g., `Remote_Task`) and select **Freestyle Project**.
   - Click **OK** to create the job.

2. **Configure the Job to Run Remote Commands**
   - In the job configuration page, scroll to the **Build** section.
   - Click on **Add build step** and choose **Execute shell script on remote host using SSH**.
     - This option should appear after installing the SSH plugin.
   - From the dropdown menus, select:
     - **Remote Host**: The one you configured earlier (e.g., `remote-host`).
     - **Credentials**: The SSH credentials you added (e.g., for `remote_user`).

3. **Specify the Command to Execute**
   - In the command text box, enter the shell command that should run on the remote host. For example:
     ```bash
     echo "Hello, my name is Jenkins. The current date and time is $(date)" > /tmp/remote_file
     ```
   - This command writes a message (including the dynamic output of `date`) to `/tmp/remote_file` on the remote host.

4. **Run and Verify the Job**
   - Save the job configuration.
   - Click **Build Now** to trigger the job.
   - Open the **Console Output** to monitor the execution and verify that the job ran successfully.
   - To confirm the remote command, access the remote host (e.g., via `docker exec -it remote-host bash`) and check that `/tmp/remote_file` contains the expected output.

---

## Conclusion

By following the steps above, you have now enhanced your Jenkins & Docker Integration setup with SSH capabilities. You learned how to:

- **Install the SSH Plugin** in Jenkins to enable secure remote connections.
- **Configure and Integrate** your Docker-based SSH server with Jenkins by setting up remote host details and adding proper credentials.
- **Create and Run Jenkins Jobs** that execute commands on a remote host via SSH, enabling distributed task execution across your Docker containers.

This setup is especially useful in environments where you need Jenkins to manage deployments or maintenance tasks on remote servers or containers through secure SSH connections.

--- 
# MySQL Backup to AWS S3 with Jenkins

## 1. Introduction MySQL + AWS + Shell Scripting + Jenkins

This section introduces the goal of the tutorial, which is to create a Jenkins job that automates MySQL database backups and uploads them to Amazon S3.

The process involves:

*   Taking a MySQL database backup.
*   Uploading the backup over the internet to Amazon S3.

- **Technologies Used**:
  - **MySQL**: Database management system.
  - **AWS S3**: Cloud storage for backups.
  - **Shell Scripting**: Automate backup and upload processes.
  - **Jenkins**: Continuous Integration/Continuous Deployment (CI/CD) tool.
  - **Docker**: Containerization for consistent environments.

The aim is to create a one-click Jenkins job to perform the entire backup and upload process.

## 2. Create a MySQL server on Docker

This section explains how to create a MySQL server using Docker.

Steps include:

*   Modifying the `docker-compose.yml` file in the Jenkins data folder.
*   Adding a new service named `dbhost` to the `docker-compose.yml` file.
*   Using the `mysql:5.7` image for the MySQL service.
*   Setting an environment variable `MYSQL_ROOT_PASSWORD` to give the MySQL root user a password, which is set to `password`.
*   Creating a volume named `db_data` to persist MySQL data. This volume is mapped to `/var/lib/mysql` inside the container.
*   Adding the `dbhost` service to the `remote-net` network so it can communicate with other containers like Jenkins.
# Automating MySQL Backups to AWS S3 with Jenkins and Docker

## 1. Introduction to MySQL, AWS, Shell Scripting, and Jenkins Integration

**Objective**: Create a Jenkins job to automate MySQL database backups and upload them to Amazon S3.

- **Technologies Used**:
  - **MySQL**: Database management system.
  - **AWS S3**: Cloud storage for backups.
  - **Shell Scripting**: Automate backup and upload processes.
  - **Jenkins**: Continuous Integration/Continuous Deployment (CI/CD) tool.
  - **Docker**: Containerization for consistent environments.

- **Workflow**:
  1. Jenkins triggers a backup process.
  2. Shell script dumps the MySQL database.
  3. Backup is uploaded to AWS S3 via AWS CLI.
  4. Entire process is containerized using Docker.

---

## 2. Create a MySQL Server on Docker

**Steps**:

1. **Modify Docker Compose File**:
   
  ```yaml
  version: '3.8'

services:
  jenkins:
    container_name: jenkins
    image: jenkins-ansible
    build:
      context: jenkins-ansible
      dockerfile: Dockerfile.jenkins-ansible
    networks:
      - net  # Ensure this network is defined below or use "host" mode
    ports:
      - "8080:8080"
      - "50000:50000"
    volumes:
      - /home/jenkins/jenkins-docker/jenkins-data:/var/jenkins_home
      - /var/run/docker.sock:/var/run/docker.sock
      #- /usr/bin/docker:/usr/bin/docker  # Optional: Mount Docker CLI binary if not in the image

  remote-host:
    container_name: remote-host
    image: remote-host
    build:
      context: centos
      dockerfile: Dockerfile.remote-host

    networks:
      - net


  db:
    container_name: mysql_db
    image: mysql:5.7
    secrets:
      - mysql_root_password
    environment:
      MYSQL_ROOT_PASSWORD_FILE: /run/secrets/mysql_root_password
    networks:
      - net

    volumes:
      - mysql_data:/var/lib/mysql

networks:
  net:  # Networks section (no trailing colon here)

volumes:
  jenkins-data:
  mysql_data:
secrets:
  mysql_root_password:
    file: /home/jenkins/jenkins-data/db/mysql_root_password.txt  # Store password in an external file
   ```
*   Using the command `docker-compose up -d` to create and start the MySQL container.
*   Verifying the MySQL container is running using `docker ps`.
*   Checking the logs of the `dbhost` container using `docker logs -f dbhost` to confirm that MySQL is ready for connections, looking for the line "MySQL is ready for connections".
*   Accessing the MySQL container using `docker exec -it dbhost bash`.
*   Logging into the MySQL server from within the container using 
`mysql -u root -p` and the password **`mysql -u root -p$(cat /run/secrets/mysql_root_password)`** .
*   Running `SHOW DATABASES;` in the MySQL client to verify the connection.

## 3. Install MySQL Client and AWS CLI

This section details how to install the MySQL client and AWS Command Line Interface (CLI) inside the `remote-host` Docker container.

Steps include:

*   Accessing the `remote-host` container using `docker exec -it remote-host bash`.
*   Trying to run `mysql` and `aws` commands to demonstrate they are not installed initially.
*   Modifying the `Dockerfile` for the `remote-host` service, which is located in the `centos-7` directory.
*   Adding `RUN yum install mysql -y` to the `Dockerfile` to install the MySQL client.
*   Adding `RUN yum install python-pip -y && pip install awscli --upgrade` to the `Dockerfile` to install the AWS CLI using pip.

    or
```yaml
FROM almalinux:9

USER root


# Install all required packages (OpenSSH, MySQL Client, Python, AWS CLI dependencies)
RUN dnf install -y openssh-server openssh-clients mysql unzip python3 && \
    dnf clean all

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws

# Setting up SSH users and keys
RUN useradd -m -s /bin/bash remote_user && \
    mkdir /home/remote_user/.ssh && \
    chmod 700 /home/remote_user/.ssh

COPY jenkins-remote-key.pub /home/remote_user/.ssh/authorized_keys

RUN chown -R remote_user:remote_user /home/remote_user/.ssh && \
    chmod 600 /home/remote_user/.ssh/authorized_keys

# Configure SSH settings
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config && \
    echo "AllowUsers remote_user" >> /etc/ssh/sshd_config

RUN ssh-keygen -A && \
    chmod 600 /etc/ssh/sshd_config

CMD ["/usr/sbin/sshd", "-D", "-e"]

```
*   Building the Docker image using `docker-compose build`.
*   Recreating the `remote-host` container to apply the changes from the updated image using `docker-compose up -d`. This will restart the `remote-host` service and use the newly built image.
*   Verifying the installation by accessing the `remote-host` container again and running `mysql --version` and `aws --version` commands, which should now be recognized.

## 4. Create a MySQL Database

This section guides through creating a sample MySQL database and table for backup purposes.

Steps include:

*   Ensuring the Docker containers are running using `docker ps`.
*   Accessing the `remote-host` container using `docker exec -it remote-host bash`.
*   Logging into the MySQL server from the `remote-host` container using the MySQL client:
    `mysql -u root -p -h dbhost`
    Providing the password `password` when prompted.
    ```bash
    mysql -h db_host -u root -p
    ```
*   Creating a new database named `test_db` using the SQL command: `CREATE DATABASE test_db;`.
*   Switching to the `test_db` database using: `USE test_db;`.
*   Creating a table named `info` with columns `name`, `last_name`, and `age` using the SQL command:
    ```sql

    CREATE DATABASE test_db;
    USE test_db;
    CREATE TABLE info (name VARCHAR(20), lastname VARCHAR(20), age INT);

    ```
*   Inserting sample data into the `info` table:
    ```sql
    INSERT INTO info (name, last_name, age) VALUES ('YourName', 'YourLastName', 30);
    ```
*   Verifying the data insertion by querying the table: `SELECT * FROM info;`.
*   Exiting the MySQL client using `exit`.

## 5. Create a S3 Bucket on AWS

This section explains how to create an S3 bucket on Amazon Web Services (AWS) to store database backups.

Steps include:

*   Navigating to the AWS Management Console by searching for "AWS console" in a web browser and clicking on the AWS Management Console link.
*   Signing into the AWS console. If you do not have an AWS account, you will need to create one.
*   Once in the console, clicking on "Services" and searching for "S3".
*   Clicking on "S3" to access the S3 management console.
*   Clicking on the "Create bucket" button.
*   Providing a unique name for the bucket, for example, `your-unique-bucket-name-for-mysql-backups`. Bucket names must be globally unique across all AWS accounts.
*   Clicking "Create" to create the S3 bucket.
*   Optionally, demonstrating how to manually upload files to the bucket through the AWS console by clicking on the bucket name, then "Upload", and selecting files to upload.

## 6. Create a user (IAM) for AWS authentication

This section describes how to create an Identity and Access Management (IAM) user in AWS with permissions to access the S3 bucket.

Steps include:

*   Navigating back to the AWS Management Console if not already there.
*   Clicking on "Services" and searching for "IAM".
*   Clicking on "IAM" to access the IAM management console.
*   On the left-hand menu, clicking on "Users" and then "Add user".
*   Providing a user name, for example, `jenkins-backup-user`.
*   Selecting "Programmatic access" as the access type.
*   Clicking "Next: Permissions".
*   Selecting "Attach existing policies directly".
*   Searching for and selecting the "AmazonS3FullAccess" policy. **Note**: For production environments, it is strongly recommended to grant least privilege and create a custom policy that only allows necessary access to specific buckets. Full access is used here for simplicity in a tutorial.
*   Clicking "Next: Tags" (tags are optional, you can skip this step).
*   Clicking "Next: Review".
*   Clicking "Create user".
*   After user creation, noting down or downloading the "Access key ID" and "Secret access key". These are crucial credentials for programmatic access. **Important**: The secret access key is only shown once. Download the `.csv` file or copy the keys to a secure location. These keys will be used later to configure AWS CLI authentication.

## 7. Learn how to take a backup and upload it manually to S3

This section explains how to manually take a MySQL backup and upload it to S3 using the AWS CLI from within the `remote-host` container.

Steps include:

*   Ensuring Docker containers are running using `docker ps`.
*   Accessing the `remote-host` container using `docker exec -it remote-host bash`.
*   Taking a MySQL backup using `mysqldump`:
    `mysqldump -u root -p -h mysql_db test_db > /tmp/test_db.sql`
    Providing the password `password` when prompted. This command dumps the `test_db` database to a file named `test_db.sql` in the `/tmp` directory.

    ```bash
    mysqldump -h mysql_db -u root -p1234 test_db > /tmp/db_backup.sql
    ```
*   Verifying the backup file by viewing its contents: `cat /tmp/test_db.sql`.
*   Configuring AWS CLI authentication using environment variables. Setting the Access Key ID and Secret Access Key obtained from the IAM user creation:
    ```bash
    export AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY_ID"
    export AWS_SECRET_ACCESS_KEY="YOUR_SECRET_ACCESS_KEY"
    ```
    **Replace** `"YOUR_ACCESS_KEY_ID"` and `"YOUR_SECRET_ACCESS_KEY"` with the actual keys. **Important**: In a real-world scenario, avoid hardcoding credentials in scripts or command history. Use secure credential management practices.
*   Uploading the backup file to the S3 bucket using the AWS CLI `aws s3 cp` command:
    `aws s3 cp /tmp/test_db.sql s3://your-unique-bucket-name-for-mysql-backups/test_db.sql`
    **Replace** `your-unique-bucket-name-for-mysql-backups` with the name of your S3 bucket.

    ```bash
    export AWS_ACCESS_KEY_ID="AKIAEXAMPLEKEY"
    export AWS_SECRET_ACCESS_KEY="s3cr3tAcc3ssK3y"
    aws s3 cp /tmp/db_backup.sql s3://mysql-backup26-4-2025 /db_backup.sql
    ```
*   Verifying the upload by checking the S3 bucket in the AWS console. Refresh the bucket content, and the `test_db.sql` file should be present.

## 8. Automate the backup and upload process with a shell script

This section guides through creating a shell script to automate the MySQL backup and S3 upload process.

Steps include:

*   Accessing the `remote-host` container using `docker exec -it remote-host bash`.
*   Creating a new shell script file, for example, `/tmp/backup_script.sh`, using a text editor like `vi` or `nano`: `vi /tmp/backup_script.sh`.
*   Adding the following script content to `/tmp/backup_script.sh`:
    ```bash
    #!/bin/bash

    BUCKET_NAME=$1
    DB_HOST=$2
    DB_PASSWORD=$3
    DB_NAME=$4
    AWS_SECRET_ACCESS_KEY=$5

    export AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY_ID" # Replace with your actual Access Key ID. Consider secure storage.
    export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}"

    DATE_TIME=$(date +%Y%m%d_%H%M%S)
    BACKUP_FILE="/tmp/${DB_NAME}_backup_${DATE_TIME}.sql"
    S3_BACKUP_PATH="s3://${BUCKET_NAME}/backup_${DB_NAME}_${DATE_TIME}.sql"

    mysqldump -u root -p"${DB_PASSWORD}" -h ${DB_HOST} ${DB_NAME} > ${BACKUP_FILE}
    echo "MySQL backup created: ${BACKUP_FILE}"

    aws s3 cp ${BACKUP_FILE} ${S3_BACKUP_PATH}
    echo "Backup uploaded to S3: ${S3_BACKUP_PATH}"
    ```
*   Making the script executable: `chmod +x /tmp/backup_script.sh`.
*   Testing the script manually by running it with parameters for database host, password, and database name:
    `/tmp/backup_script.sh dbhost password test_db`
*   Verifying that a backup file with a timestamp is created in the `/tmp` directory, for example, `/tmp/test_db_backup_YYYYMMDD_HHMMSS.sql`.

## 9. Integrate your script with AWS CLI

This section extends the shell script to include AWS CLI commands for uploading the backup to S3 and manage AWS credentials within the script.

Steps include:

*   Modifying the `/tmp/backup_script.sh` script to include AWS authentication and S3 upload commands.
*   Updating the script content as follows:
    ```bash
    #!/bin/bash

    BUCKET_NAME=$1
    DB_HOST=$2
    DB_PASSWORD=$3
    DB_NAME=$4
    AWS_SECRET_ACCESS_KEY=$5

    export AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY_ID" # Replace with your actual Access Key ID. Consider secure storage.
    export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}"

    DATE_TIME=$(date +%Y%m%d_%H%M%S)
    BACKUP_FILE="/tmp/${DB_NAME}_backup_${DATE_TIME}.sql"
    S3_BACKUP_PATH="s3://${BUCKET_NAME}/backup_${DB_NAME}_${DATE_TIME}.sql"

    mysqldump -u root -p"${DB_PASSWORD}" -h ${DB_HOST} ${DB_NAME} > ${BACKUP_FILE}
    echo "MySQL backup created: ${BACKUP_FILE}"

    aws s3 cp ${BACKUP_FILE} ${S3_BACKUP_PATH}
    echo "Backup uploaded to S3: ${S3_BACKUP_PATH}"
    ```
    **Important**: Replace `"YOUR_ACCESS_KEY_ID"` with your actual AWS Access Key ID in the script. In a production environment, do not hardcode sensitive information directly in scripts. Use secure methods for credential management, especially in Jenkins.
*   Testing the updated script manually, providing the bucket name, database host, password, database name, and AWS Secret Access Key as parameters:
    `/tmp/backup_script.sh <your-unique-bucket-name-for-mysql-backups> <dbhost-name> <password> <DB_NAME> <YOUR_SECRET_ACCESS_KEY>`
    
    **ex** 
    `/tmp/backup_script.sh mysql-backup26-4-2025 mysql_db 1234 test_db qEWkbifZ2Nf7ynItJMJ5qFb3C+V7k6wretsdfdfb1`
*   Verifying that the backup is created locally in `/tmp` and uploaded to the specified S3 bucket. Check the S3 bucket in the AWS console to confirm the uploaded backup file.

## 10. Learn how to manage sensitive information in Jenkins (Keys, Passwords)

This section demonstrates how to securely manage sensitive information like passwords and AWS secret keys within Jenkins using Jenkins Credentials.

Steps include:

*   Accessing the Jenkins dashboard in a web browser.
*   On the left-hand menu, clicking on "Credentials".
*   Clicking on "Jenkins" under "Stores scoped to Jenkins".
*   Clicking on "Global credentials (unrestricted)".
*   Clicking on "Add Credentials".
*   Selecting "Secret text" from the "Kind" dropdown menu.
*   Creating a credential for the MySQL password:
    *   Setting "ID" to something descriptive, for example, `mysql-root-password`.
    *   Setting "Description" (optional).
    *   Setting "Secret" to the MySQL root password, which is `password` in this tutorial.
    *   Clicking "OK".
*   Creating another credential for the AWS Secret Access Key:
    *   Clicking on "Add Credentials" again.
    *   Selecting "Secret text" from the "Kind" dropdown menu.
    *   Setting "ID" to something descriptive, for example, `aws-secret-access-key`.
    *   Setting "Description" (optional).
    *   Setting "Secret" to the AWS Secret Access Key obtained from IAM user creation.
    *   Clicking "OK".
*   Verifying that both credentials (`mysql-root-password` and `aws-secret-access-key`) are listed in the Global credentials. These credentials can now be securely used in Jenkins jobs without exposing the actual secret values in job configurations or scripts.


## 11. Create a Jenkins job to upload your DB to AWS

This section describes the steps to create a Jenkins job that will execute the shell script to backup the MySQL database and upload it to AWS S3.

Steps include:

*   On the Jenkins dashboard, clicking "New Item" to create a new job.
*   Naming the job, for example, `Backup-DB-to-AWS-S3`.
*   Selecting "Freestyle project" and clicking "OK".
*   In the job configuration page, navigating to the "General" section.
*   Checking the "This project is parameterized" option.
*   Adding the following String parameters by clicking "Add Parameter" and selecting "String Parameter" for each:
    *   Name: `MySQL_Host`, Default value: `mysql_db`, Description: `MySQL Hostname`
    *   Name: `Database_Name`, Default value: `test_db`, Description: `Database Name to Backup`
    *   Name: `S3_Bucket_Name`, Default value: `your-unique-bucket-name-for-mysql-backups`, Description: `AWS S3 Bucket Name` (Remember to replace `your-unique-bucket-name-for-mysql-backups` with your actual bucket name)
*   Adding Secret text parameters under "This project is parameterized" section by clicking "Add Parameter" and selecting "Secret text" for each:
    *   Name: `MySQL_Password_Secret`, Secret variable: `MySQL_Password`, Description: `MySQL Root Password Secret` and select the credential you created before `mysql-root-password`.
    *   Name: `AWS_Secret_Key_Secret`, Secret variable: `AWS_Secret_Access_Key`, Description: `AWS Secret Access Key Secret` and select the credential you created before `aws-secret-access-key`.
*   Navigating to the "Build" section.
*   Clicking "Add build step" and selecting "Execute shell script on remote host using SSH".
*   Selecting the configured remote host (`remote-host`).
*   In the "Command" field, entering the command to execute the script, passing the Jenkins parameters to the shell script in the correct order:
    ```bash
    /tmp/backup_script.sh $S3_Bucket_Name $MySQL_Host '$MySQL_Password' $Database_Name '$AWS_Secret_Access_Key'
    ```
    **Important**: Ensure the order of parameters in the script matches the order expected by `/tmp/backup_script.sh`. Note the single quotes around `$MySQL_Password` and `$AWS_Secret_Access_Key` to ensure they are passed as single arguments even if they contain special characters.
*   Clicking "Save" to save the Jenkins job configuration.

## 12. Execute your Job and be happy!

This section guides you through executing the Jenkins job and verifying that the backup is successfully created and uploaded to AWS S3.

Steps include:

*   On the Jenkins job page, clicking "Build with Parameters".
*   Reviewing the default parameter values. You can change them if needed before building.
*   Clicking "Build" to start the Jenkins job.
*   Waiting for the job to complete. A blue icon next to the build number indicates a successful build.
*   Clicking on the build number (e.g., `#1`) and then "Console Output" to view the job logs.
*   Verifying in the console output that:
    *   Sensitive information (MySQL password and AWS secret key) is masked with asterisks, indicating secure credential usage.
    *   The script execution starts and completes without errors.
    *   Messages "MySQL backup created:" and "Backup uploaded to S3:" are present, confirming both steps.
    *   The AWS S3 `cp` command output shows a successful upload.
*   Navigating to the AWS S3 console and opening the S3 bucket that you specified in the job parameters (`your-unique-bucket-name-for-mysql-backups` or `Jenkins-MySQL-backup`).
*   Verifying that a new backup file (e.g., `backup_test_db_YYYYMMDD_HHMMSS.sql`) is present in the bucket. The timestamp in the filename confirms that a new backup was created and uploaded.
*   Running the Jenkins job again by clicking "Build Now" (or "Build with Parameters" to change parameters) to confirm that the job can be executed multiple times successfully and creates new timestamped backups in S3.

## 13. Persist the script on the remote host

This section explains how to ensure the backup script persists in the `remote-host` container even if the container is recreated. This is achieved using Docker volumes.

Steps include:

*   From your host machine (outside the Docker container), copying the `/tmp/backup_script.sh` file from inside the `remote-host` container to the host machine. For example, you can use `docker cp remote-host:/tmp/backup_script.sh .` to copy it to your current directory on the host, and rename it to `aws_s3_backup.sh`.
*   Modifying the `docker-compose.yml` file to add a volume mount for the `remote-host` service. Under the `volumes` section of the `remote-host` service in `docker-compose.yml`, adding the following line:
    ```yaml
    - ./aws_s3_backup.sh:/tmp/backup_script.sh
    ```
    This line mounts the `aws_s3_backup.sh` file from the current directory on your host machine into the `/tmp/backup_script.sh` path inside the `remote-host` container.
*   Using `docker-compose up -d --force-recreate remote-host` to recreate the `remote-host` container to apply the volume changes.
*   Verifying that the script is persistent by:
    *   Accessing the `remote-host` container using `docker exec -it remote-host bash`.
    *   Checking if the `/tmp/backup_script.sh` file exists and has the correct content: `cat /tmp/backup_script.sh`.
    *   Deleting and recreating the `remote-host` container using `docker rm -f remote-host` and `docker-compose up -d remote-host`.
    *   Accessing the recreated container again and verifying that `/tmp/backup_script.sh` is still present.
*   Ensuring the script is executable. If permissions are lost during mounting, you might need to re-execute `chmod +x aws_s3_backup.sh` on your host machine, and then recreate the container. Alternatively, you can add a `RUN chmod +x /tmp/backup_script.sh` command in your `Dockerfile` for `remote-host` to ensure executable permissions are set when the image is built.
*   Running the Jenkins job again to confirm that the persistent script works as expected and the backup process continues to function correctly.

## 14. Reuse your Job to upload different DB's to different buckets

This section demonstrates the flexibility of the parameterized Jenkins job by reusing it to backup a different database (`pass_db`) and upload it to a different S3 bucket (`Jenkins-MySQL-backup2`).

Steps include:

*   Accessing the `remote-host` container using `docker exec -it remote-host bash`.
*   Connecting to the MySQL server from within the `remote-host` container using `mysql -u root -p -h dbhost`.
*   Creating a new database named `pass_db`: `CREATE DATABASE pass_db;`.
*   Creating a new S3 bucket on AWS with a different name, for example, `your-unique-bucket-name-for-mysql-backups2` or `Jenkins-MySQL-backup2`.
*   On the Jenkins job page, clicking "Build with Parameters".
*   Changing the parameter values:
    *   `Database_Name`: changing the value from `test_db` to `pass_db`.
    *   `S3_Bucket_Name`: changing the value from `your-unique-bucket-name-for-mysql-backups` to `your-unique-bucket-name-for-mysql-backups2` (or `Jenkins-MySQL-backup2`).
*   Keeping other parameters (MySQL Host, passwords, AWS Secret Key) the same.
*   Clicking "Build" to start the job with the new parameters.
*   After successful job execution (blue icon), verifying in the console output that the job is now backing up `pass_db` and uploading to the new bucket (`your-unique-bucket-name-for-mysql-backups2` or `Jenkins-MySQL-backup2`).
*   Navigating to the new S3 bucket in the AWS console and confirming that a new backup file (e.g., `backup_pass_db_YYYYMMDD_HHMMSS.sql`) is present in the new bucket.
*   Confirming that the original bucket (`your-unique-bucket-name-for-mysql-backups` or `Jenkins-MySQL-backup`) still contains the backups of `test_db` and remains unchanged, demonstrating that the job can be easily reused for different databases and buckets by simply changing the parameters.
