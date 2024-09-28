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
