A **computer network** is a collection of interconnected devices (such as computers, servers, routers, etc.) that can share resources, exchange data, and communicate with each other. These devices are connected using communication protocols over wired or wireless media.

### Why Networks?
Networks allow for the sharing of hardware (like printers, scanners) and data, enabling easier collaboration and efficient use of resources. Key reasons for networks include:
- **Sharing hardware** and **data** to reduce costs.
  
### Network Advantages:
- **Cost-saving**: Reduces the need for redundant hardware.
- **Increased workgroup collaboration**: Enables teams to work together more effectively.
- **Boosts productivity**: Easier access to shared resources enhances efficiency.
- **Data protection**: Centralized management of sensitive data improves security.

### Network Components:
1. **Computer Systems**: Devices like PCs, servers, etc.
2. **Network Media**: Cables or wireless signals that facilitate data transfer.
3. **Network Interface**: Hardware (such as NICs) that allows systems to connect to the network.
4. **Network Protocol**: Rules and conventions (like TCP/IP) that dictate how data is transmitted and received.

### Network Types:
1. **Geographical Area**: Defines the size and scope of the network.
   - **LAN (Local Area Network)**: Covers a small area like a building.
   - **MAN (Metropolitan Area Network)**: Spans a city or campus.
   - **WAN (Wide Area Network)**: Covers large areas, often using satellite or leased lines.

2. **Host Role**: Defines how devices interact.
   - **P2P (Peer-to-Peer)**: All devices share resources equally.
   - **C/S (Client-Server)**: Centralized servers provide resources to clients.

### Network Topology:
- **Physical Topology**: The actual arrangement of cables and devices in a network (e.g., star, bus, ring topologies).
- **Logical Topology**: The way data flows within the network regardless of the physical layout (e.g., how signals travel).

### Common Types of Network Topology:
1. **Bus Topology**: 
   - All devices are connected to a single central cable (the "bus").
   - Easy to set up but can slow down with high traffic.

2. **Ring Topology**: 
   - Devices are connected in a circular fashion, with each device connected to two others.
   - Data travels in one direction, and a failure in one device can disrupt the network.

3. **Mesh Topology**: 
   - Every device is connected to every other device.
   - Provides high redundancy and reliability but is expensive to set up.

4. **Star Topology**: 
   - All devices are connected to a central hub.
   - If the hub fails, the entire network is affected, but individual device failures don't disrupt the network.

---

### Software Terms:
- **Network**: A group of interconnected devices.
- **Subnet**: A smaller network within a larger network, divided by subnet masks.
- **Internet**: The global network of interconnected devices.
- **FW (Firewall)**: A security system that monitors and controls incoming and outgoing network traffic.
- **Intranet**: A private network accessible only to an organization's staff.
- **Extranet**: A private network that allows external partners to access certain parts of an organization's intranet.

---

### Hardware Terms:
- **Workstation**: A powerful computer designed for individual use, often in a business environment.
- **Client**: A device that requests services from a server.
- **Server**: A device that provides resources or services to clients.
  - **Client OS**: Operating system designed for individual users (e.g., Windows, macOS).
  - **Network OS**: Operating system designed to manage network resources (e.g., Linux, Windows Server).
  - **Server Roles**:
    - **File Server**: Manages and stores files.
    - **Print Server**: Manages printers on the network.
    - **Web Server**: Hosts websites (e.g., Apache, Nginx).
    - **Mail Server**: Manages email communication.
    - **Proxy Server**: Acts as an intermediary between users and the internet.
- **Host**: A device on a network that provides services or resources.

---

### IP (Internet Protocol):
- **IPv4**: 
  - Uses a 32-bit address divided into four octets (e.g., `192.168.1.20`).
  - Each octet can range from 0-255.
  - Divided into **Network Address** (identifies the network) and **Host Address** (identifies the device).
  - **Subnet Mask**: Defines how the IP address is split between network and host (e.g., `255.255.255.0`).

- **IPv6**: 
  - Uses a 128-bit address to provide a much larger address space than IPv4.

---

### MAC Address:
- **MAC (Media Access Control)**: A unique identifier assigned to a device's network interface card (NIC).
- Written in hexadecimal format, like `00-1C-2F-06-CD-AE`.
- Divided into:
  - **Organizationally Unique Identifier (OUI)**: Identifies the manufacturer.
  - **Network Interface Controller (NIC) Specific**: Identifies the device.

### OSI (Open Systems Interconnection) Model:
The OSI model is a conceptual framework that standardizes the functions of a telecommunication or computing system into seven distinct layers. It facilitates communication between systems and is used to guide the development and troubleshooting of network systems.

**Layers from Source to Destination:**
1. **Physical (Layer 1)**: Concerned with the transmission of raw bits over a physical medium (cables, wireless).
2. **Data Link (Layer 2)**: Handles MAC (Media Access Control) addresses and ensures reliable data transfer over the physical medium (Frames).
3. **Network (Layer 3)**: Manages logical IP addresses and routes data from source to destination (Packets).
4. **Transport (Layer 4)**: Segments data, ensures data transfer is reliable, and manages port addresses (Segments).
5. **Session (Layer 5)**: Establishes, maintains, and terminates communication sessions.
6. **Presentation (Layer 6)**: Ensures data is in the correct format (encryption, compression, syntax).
7. **Application (Layer 7)**: Provides network services to end-users and applications (HTTP, FTP, SMTP).

---

### Advantages of the OSI Model:
1. **Simplification**: Breaks down network communication into smaller, manageable layers for easier design and troubleshooting.
2. **Standardization**: Allows for the development of network components by different vendors.
3. **Interoperability**: Ensures different types of hardware and software can communicate.
4. **Troubleshooting**: Helps isolate and resolve networking issues efficiently.

---

### Functions by Layer:
- **Application Layer (7)**: Services like HTTP, FTP, SMTP operate here.
- **Presentation Layer (6)**: Handles data encryption, compression, and translation of formats.
- **Session Layer (5)**: Manages session establishment and termination.
  
**Transport Layer (4)**:
- Segments data for transmission (uses **segments**).
- Ensures data arrives correctly using port addresses.
  
**Network Layer (3)**:
- Handles logical IP addressing and routing (uses **packets**).
- Assigns IP addresses to devices.

**Data Link Layer (2)**:
- Handles MAC addresses and ensures data reaches its destination within the local network (uses **frames**).
- Divided into:
  - **LLC (Logical Link Control)**: Provides error correction and flow control.
  - **MAC (Media Access Control)**: Manages access to the physical medium.

**Physical Layer (1)**:
- Converts data into bits for transmission through physical media like cables or wireless signals.

---

### Layer-wise Addressing:
1. **Transport Layer**: Uses **port addresses** (e.g., 80 for HTTP).
2. **Network Layer**: Uses **logical (IP) addresses** (e.g., `192.168.1.5`).
3. **Data Link Layer**: Uses **physical (MAC) addresses** (e.g., `A1-B2-C3-D4-E5-F6`).

### Port Address:
- **Physical ports**: The actual hardware ports on a device.
- **Logical ports**: Software-defined communication endpoints. There are **65,534 ports** available (0 to 65,533).

---

### Example: Communication Between Web Client and Web Server:
- **Client**: 
  - IP: `192.168.1.5`
  - MAC: `A`
- **Server**:
  - IP: `192.168.1.200`
  - MAC: `B`
  
When a client requests a webpage:
1. Client sends a request using `HTTP://192.168.1.200`.
2. **Source Port**: Any port above 1023 (e.g., 1027).
3. **Destination Port**: 80 (standard HTTP).
4. **Logical (IP) Addresses**: 
   - Source IP: `192.168.1.5`
   - Destination IP: `192.168.1.200`
5. **Physical (MAC) Addresses**: 
   - Source MAC: `A`
   - Destination MAC: `B`.

---

### ARP (Address Resolution Protocol):
- **ARP Cache**: A table that stores IP-to-MAC address mappings.
- When a device needs to communicate with another device, it uses ARP to resolve the destination's MAC address.
- If the destination MAC is unknown, the source sends a broadcast ARP request, where the destination MAC is initially `FF-FF-FF-FF-FF-FF`.

---

### Data Flow from Client to Web Server:
1. **Application Layer (HTTP)**: The client sends an HTTP request.
2. **Presentation Layer**: Data might be compressed or encrypted.
3. **Session Layer**: A session is established between client and server.
4. **Transport Layer**: The HTTP request is segmented, and source/destination port numbers are added (1027 to 80).
5. **Network Layer**: The segment is encapsulated into a packet, and source/destination IP addresses are assigned.
6. **Data Link Layer**: The packet is encapsulated into a frame, with source/destination MAC addresses.
7. **Physical Layer**: The frame is transmitted as bits over the physical medium.

Each layer at the source prepares the data for the corresponding layer at the destination.