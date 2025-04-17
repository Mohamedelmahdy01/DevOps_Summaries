# IT Fundamentals

## Compute Devices - Common Components
We use computing devices in our daily life, including:
- Mobile Phones
- Laptops
- iPads
- Tablets
- Desktops

Although these devices have different use cases, they share common components:
- **CPU (Central Processing Unit)**: The brain of the device, responsible for executing instructions.
- **RAM (Random Access Memory)**: Temporary storage for active processes.
- **Storage (HDD or SSD)**: Permanent storage for data.
- **Network Card/Interface (NIC)**: Connects the device to the outside world, either wirelessly or wired.
- **Monitors**: Displays data visually.
- **Graphic Cards (GPU)**: Accelerates video and graphic processing tasks.

---

## Physical Servers
A physical server is essentially a powerful computer with:
- Large memory (RAM)
- One or more CPUs
- One or more disk drives (HDD/SSD) to store the operating system and data
- Network interfaces for connectivity
- Optional GPU(s) for enhanced graphical processing

Servers are designed to support many users and applications, ranging from tens to thousands, due to their high specifications. You can install an operating system and multiple applications to serve different user needs.

---

## Compute Components - Units
The components of a computing device are measured in the following units:
- **CPU speed**: Measured in GHz (Gigahertz)
- **Memory and storage**: Measured in GB (Gigabytes) or TB (Terabytes)
- **Network Interface Card speed**: Measured in Mbps (Megabits per second) or Gbps (Gigabits per second)

---

## Virtualization

### Introduction to Virtualization
Virtualization allows us to split a physical server into multiple virtual servers, enabling multiple operating systems and applications to run on a single physical machine. Each virtual machine (VM) is isolated from the others, and a **hypervisor** manages the virtual hardware resources.

We can also take **snapshots** (backups) of VMs, allowing us to restore their states when needed.

**Example:**
- Physical Server: Runs a single operating system and application
- Virtualization: Multiple VMs running different operating systems and applications

### Virtualization Components
Each VM consists of the following components:
- **Applications**: Programs running on the VM
- **Guest OS**: The operating system installed on the VM
- **Virtual CPU, Memory, Disk, Network Card**: Virtualized versions of physical components
- **Hypervisor**: Software that manages VMs
- **Physical Server**: The hardware that hosts the VMs

---

## Oversubscription
Oversubscription (also known as overbooking) refers to selling a service in quantities that exceed actual resources. This is commonly done in cloud services to optimize resource utilization.

---

## Introduction to (Web) Applications

### Client-Server (Web) Applications
Web applications include websites, e-commerce platforms, and any application accessible via the internet. They follow a **client-server** model:
- The **client** (usually a browser) sends requests.
- The **server** processes these requests and returns responses.

**Example:**
- Web Client: Sends a request to view a website.
- Web Server: Processes the request and sends the website data back.

---

## Introduction to Data Centers

### Where Do We Place Servers That Host Applications?
Traditionally, servers and applications are hosted in purpose-designed IT **data centers**. These may be separate physical locations or **on-premises** facilities, specifically designed to house IT infrastructure.

### Data Center Servers
Servers are placed in racks, which are physically secured and monitored. A typical server in a data center includes:
- Good-sized memory
- CPU(s)
- Disk drives for storing the operating system and data
- Network interfaces for connectivity

**Rack Units (RU)**: Racks are measured in **rack units**, with 1 RU = 4.4 cm in height.

---

## Introduction to Cloud Computing

### On-Premises Data Centers vs. Cloud

- **On-Premises / Data Center**: You own and operate the infrastructure, which is a **CAPEX** (Capital Expenditure) model. You have full control over building and maintaining everything.
- **Cloud**: Cloud computing operates on a shared responsibility model. The infrastructure, security, databases, and applications are pre-built and managed by the cloud provider. This follows an **OPEX** (Operational Expenditure) model, where you pay for what you use.


## Is Data Center Equivalent To A Cloud?
A data center requires a layer of orchestration and automation to become a cloud. While a data center is a critical component of cloud infrastructure, it is not synonymous with the cloud.

**Formula:**
    Data Center(s) + Automation/Orchestration = Cloud
---

## Cloud Types: Private, Public & Hybrid Cloud

### Private vs. Public Cloud

| Public Cloud                               | Private Cloud                                 |
|--------------------------------------------|-----------------------------------------------|
| Resources are publicly shared              | Resources are for private use                 |
| Shared / Multi-Tenant infrastructure       | Single customer or specific business units    |
| Internet connectivity primarily used       | Connectivity via private network, fiber, etc. |
| Best for less confidential data            | Best for confidential data, private systems   |

### Hybrid Cloud
A hybrid cloud is a mix of public and on-premises private clouds, orchestrated to run a single task. It is a more complex solution because organizations must manage multiple platforms.

**Use Cases:**
- Cost-effective infrastructure
- Backup and disaster recovery
- Development and testing environments

### Multi-Cloud
Multi-cloud refers to the use of multiple cloud computing and storage services in a single, heterogeneous architecture.

---

### Hybrid Cloud & Multi-Cloud
- **Hybrid Cloud**: Combines public and private clouds to handle tasks across both infrastructures.
- **Multi-Cloud**: Utilizes multiple cloud platforms and services from different providers.

**Hybrid Multi-Cloud**: A deployment model that uses multiple clouds along with automation and orchestration.

---

## Cloud Services: IaaS, PaaS, SaaS, XaaS

Cloud services are offered in different models based on the responsibilities shared between the customer and the cloud provider.

### Cloud-as-a-Service (aaS) Model

| Layer                 | On-Premises        | IaaS            | PaaS            | SaaS            |
|-----------------------|--------------------|-----------------|-----------------|-----------------|
| Applications          | Customer Managed   | Customer Managed| Provider Managed| Provider Managed|
| Data                  | Customer Managed   | Customer Managed| Provider Managed| Provider Managed|
| Runtime               | Customer Managed   | Customer Managed| Provider Managed| Provider Managed|
| Middleware            | Customer Managed   | Customer Managed| Provider Managed| Provider Managed|
| Operating System      | Customer Managed   | Customer Managed| Provider Managed| Provider Managed|
| Virtualization        | Customer Managed   | Provider Managed| Provider Managed| Provider Managed|
| Hardware              | Customer Managed   | Provider Managed| Provider Managed| Provider Managed|
| Storage               | Customer Managed   | Provider Managed| Provider Managed| Provider Managed|
| Network               | Customer Managed   | Provider Managed| Provider Managed| Provider Managed|

---

## DevOps

### Introduction to SDLC (Software Development Life Cycle)
SDLC is a framework that outlines the series of steps used to create software applications. It divides the development process into tasks that can be assigned, completed, and measured.

**Benefits of SDLC:**
- Provides measurable improvements
- Ensures accurate analysis of each step
- Enables faster delivery and higher software quality
- Enhances user experience by meeting or exceeding customer expectations

**Key Phases of SDLC:**


### Agile vs. Waterfall Methodologies
- **Waterfall**: Follows a linear progression from Analyze → Plan → Design → Build → Test → Deploy.
- **Agile**: Focuses on iterative cycles where small, functional parts of the project are designed, built, and tested in shorter timeframes.

| Waterfall                                      | Agile                                         |
|------------------------------------------------|-----------------------------------------------|
| Design -> Code -> Test -> Deploy               | Design -> Code -> Test -> Code -> Test -> Deploy |

---

### DevOps

DevOps is a philosophy and cultural shift where development, QA, and operations teams work together to manage the entire software lifecycle. It emphasizes automation, collaboration, and rapid delivery.

**Key Aspects of DevOps:**
- Improves software development and delivery practices
- Shortens the development lifecycle
- Aligns software releases with business objectives

### DevOps vs. Agile
- **Agile**: Focuses on how software is developed (frequent code/test cycles).
- **DevOps**: Focuses on how software is deployed and continuously delivered through automation.

| Agile                                          | DevOps                                        |
|------------------------------------------------|-----------------------------------------------|
| Design -> Code -> Test -> Code -> Test -> Deploy | Design -> Code -> Test -> Deploy -> Test -> Deploy |



### CI/CD Concepts:

1. **Continuous Integration (CI):**
   - Continuous Integration (CI) is a development practice where developers regularly merge their code changes into a shared repository. The integration is then verified by automated builds and tests. This process ensures that issues are caught early in the development lifecycle. 
   - The primary goals of CI are to detect and fix integration problems more rapidly, enhance code quality, and reduce the time needed for testing. 
   - Developers are expected to frequently push their code to a shared repository, ensuring that all changes are tested together for compatibility. Any issues or bugs are detected early, reducing the complexity of fixing them later.

2. **Continuous Delivery (CD):**
   - Continuous Delivery refers to automating the deployment of code to staging or testing environments once it's been built and tested. The key difference from Continuous Integration is that after a successful build and test, the deployment still requires manual approval, usually based on when the team wants to release.
   
3. **Continuous Deployment (CD):**
   - Continuous Deployment takes Continuous Delivery further by fully automating the deployment process. Once the code passes all the tests in the CI stage, it’s deployed to production automatically, with no human intervention. This ensures a quicker delivery of new features or fixes to users.

4. **CI/CD Pipeline:**
   - The typical CI/CD pipeline involves building, testing, and then deploying code. This can be broken down into:
     - Build -> Test -> Staging Deployment -> Production Deployment.
     - Staging can be manual (Continuous Delivery) or automatic (Continuous Deployment).

5. **Common CI/CD Tools:**
   - There are several tools available to implement CI/CD pipelines, including Jenkins, GitHub Actions, GitLab, Argo, and CircleCI.

---

### DevOps and Coding:

1. **Do You Need to Code for DevOps?**
   - Not all DevOps roles require deep programming expertise, but some tasks benefit from coding skills. For example, collaboration with developers often involves understanding code, while automation of tasks (e.g., testing, deployments) requires scripting skills. Additionally, writing scripts to manage cloud resources, monitor systems, and implement custom plugins are all common tasks that require coding.

2. **Tasks That Require Coding Skills in DevOps:**
   - Communicating with development teams.
   - Writing automation scripts for repetitive tasks.
   - Using SDKs or Infrastructure as Code (IaC) to create/manage cloud resources.
   - Writing scripts for monitoring, alerting, and custom tool plugins.

3. **Recommended Programming Languages for DevOps:**
   - Python and Go are common programming languages, with Go gaining popularity in DevOps.
   - Bash and PowerShell are essential for shell scripting in Linux and Windows environments, respectively.
   - Terraform is widely used for Infrastructure as Code (IaC) purposes.

---

### Cloud Native Overview:

1. **Cloud Native:**
   - Cloud-native technologies allow organizations to build and run applications that are scalable across public, private, or hybrid clouds. These applications use modern technologies such as containers, service meshes, microservices, and immutable infrastructure, and they rely on declarative APIs to facilitate automation.
   - The Cloud Native Computing Foundation (CNCF) supports these cloud-native technologies. Cloud native is about **how** applications are built and run rather than **where** they are deployed.

2. **Cloud Native Applications:**
   - Cloud-native applications are independent services packaged as lightweight containers. They are portable and can be scaled up or down based on demand. These applications are often deployed using CI/CD pipelines to ensure rapid delivery and updates.

---

### Infrastructure as Code (IaC):

1. **Infrastructure as Code (IaC):**
   - IaC is the practice of managing and provisioning IT infrastructure using configuration files, rather than manual setup or configuration. This makes managing infrastructure more consistent, scalable, and automated.
   - Tools like Terraform and AWS CloudFormation allow you to define your infrastructure in code. Once defined, the infrastructure can be deployed, updated, or destroyed using these tools.
   - Pulumi is another tool that can work with popular programming languages like Python for IaC.

---

### DevOps vs. DevSecOps:

1. **DevSecOps:**
   - DevSecOps is an evolution of DevOps that integrates security practices into every phase of the software development lifecycle (SDLC). 
   - From the very start of development, DevSecOps ensures security is a priority, rather than an afterthought. By integrating automated security testing and security best practices throughout the CI/CD process, it helps identify and fix vulnerabilities early on.
   - The benefit of DevSecOps is that it allows teams to deliver secure applications quickly and efficiently by combining the agility of DevOps with a security-first mindset.
