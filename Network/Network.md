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