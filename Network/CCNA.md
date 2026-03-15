# Introduction to Cisco CCNA (200-301) Certification

## Overview of Cisco and CCNA

Cisco Systems is a leading global company specializing in networking hardware, particularly routers and switches, which form the backbone of most networks worldwide. The company is based in San Francisco, California.

Cisco offers a range of professional certifications. The entry-level certification is **CCNA (Cisco Certified Network Associate)**, followed by professional-level certifications like **CCNP (Cisco Certified Network Professional)**, and expert-level **CCIE (Cisco Certified Internetwork Expert)**.

## Changes to Cisco Certifications (Effective February 24, 2020)

Prior to February 2020, Cisco had multiple specialized CCNA tracks (e.g., Routing & Switching, Security, Wireless, Voice). Starting February 24, 2020, Cisco consolidated these into a **single unified CCNA certification** with one exam: **200-301 CCNA**.

- All previous specialized CCNA tracks were retired.
- The new CCNA covers foundational networking skills across broader areas.
- At the CCNP level, specialization options remain (e.g., Enterprise, Security), but CCNA is now a prerequisite-free broad foundation.

## Target Audience for CCNA 200-301

This certification is ideal for:
- Beginners entering the networking field.
- Individuals preparing for entry-level network engineer or administrator roles.
- Students in networking-related university programs.
- Professionals seeking internationally recognized validation of networking skills.

No strong prior networking background is required, though basic computer literacy (e.g., using Windows, mouse/keyboard) is recommended. Prior knowledge (e.g., CompTIA Network+) helps but is not mandatory.

## CCNA 200-301 Exam Topics

The exam covers six main domains:

1. **Network Fundamentals** (20%)  
   - Basic networking concepts, OSI/TCP-IP models, network topologies, cabling, IPv4/IPv6 addressing.

2. **Network Access** (20%)  
   - Configuring and verifying VLANs, inter-switch connectivity (e.g., Spanning Tree Protocol - STP), EtherChannel, wireless basics.

3. **IP Connectivity** (25%)  
   - IPv4/IPv6 routing concepts, static routing, dynamic routing protocols (primarily OSPF; limited coverage of others).

4. **IP Services** (10%)  
   - DHCP, NAT, NTP, SNMP, QoS basics.

5. **Security Fundamentals** (15%)  
   - Basic security concepts, access control lists (ACLs), VPN basics, wireless security, port security.

6. **Automation and Programmability** (10%)  
   - Introduction to network automation, REST APIs, JSON, controller-based architectures (e.g., SDN concepts), configuration management tools.

The course emphasizes both **theoretical** and **practical** aspects, with heavy focus on hands-on labs using tools like Cisco Packet Tracer or real equipment.

## Differences Between Old CCNA (200-125) and New CCNA (200-301)

- **Old (200-125)**: More in-depth on traditional topics; longer list of routing protocols (e.g., EIGRP, RIP, BGP basics), Frame Relay, extensive troubleshooting.
- **New (200-301)**: Reduced depth in some legacy areas; removed topics like OSI model deep dive (though still useful practically), many older routing protocols, and WAN technologies like Frame Relay.
- **Additions**: Wireless fundamentals, basic security, automation/programmability (new focus on modern networks).
- Overall, the new exam is broader but slightly less deep in pure routing/switching; it aligns with current industry needs (e.g., SDN, automation).

> Note: Some removed topics (e.g., full EIGRP, certain WAN protocols) remain valuable in real-world environments and may be covered extra in practical training.

## Exam Details (200-301 CCNA)

- **Exam Code**: 200-301
- **Duration**: 120 minutes
- **Number of Questions**: Approximately 100–120 (varies)
- **Question Types**:
  - Mostly multiple-choice (single or multiple answers).
  - Drag-and-drop (matching terms or sequences).
  - 1–2 simulation labs (configure/verify on virtual routers/switches; requires basic commands).
- **Passing Score**: Set by Cisco (not publicly disclosed; typically ~80–85%).
- **Format**: Taken at Pearson VUE testing centers.
- **Preparation Tip**: Practice with exam dumps (question banks with answers) to familiarize with question style, but always combine with solid understanding and labs.

This certification is highly valued for job applications in networking, often required for roles involving Cisco equipment.

For official details, refer to Cisco's website: [CCNA 200-301 Exam Topics](https://www.cisco.com/c/en/us/training-events/training-certifications/exams/current-list/ccna-200-301.html).


# Networking Basics: Introduction to Networks, Types, Topologies, and Devices

## Definition of a Network

A network is a collection of devices (e.g., computers, printers) connected together to communicate and share resources. Connections can be:
- **Wired**: Using cables.
- **Wireless**: Using radio waves or other non-physical means.

The number of devices can vary from a few to thousands.

## Purpose of Networks

The primary goal is **resource sharing** (sharing) among connected devices, including:
- **Hardware Devices**: Shared peripherals like printers, scanners, or other equipment to avoid duplication (e.g., one printer serving multiple computers).
- **Applications**: Centralized on a server, allowing multiple devices to access them simultaneously without installing on each device.
- **Files**: Easy exchange of files between users, either via a file server or directly between devices (no server required).
- **Internet Access**: A single internet connection (via a router) shared across all devices, reducing costs compared to individual subscriptions.

## Types of Networks

Networks are classified based on geographic coverage and scale:

- **LAN (Local Area Network)**: Connects devices in a limited area (e.g., room, building, or small site up to 1 km). Focuses on internal sharing (files, devices) without internet access by default. Not defined by device count but by confined space.

- **WAN (Wide Area Network)**: Connects multiple LANs over large distances (e.g., between cities or countries). Typically involves Internet Service Providers (ISPs) for connectivity. The internet itself is the largest WAN example.

- **CAN (Campus Area Network)**: Connects multiple LANs in a limited area (e.g., university campus with buildings like engineering, medicine, and commerce faculties). Covers about 10 km.

- **MAN (Metropolitan Area Network)**: Covers a city or larger urban area (up to 100 km), connecting buildings, ministries, or organizations.

- **SAN (Storage Area Network)**: Specialized for connecting storage devices (e.g., hard drives) to servers for data storage and access. Commonly discussed in Microsoft-related courses (e.g., MCSA).

| Network Type | Coverage Area | Example |
|--------------|---------------|---------|
| LAN         | Up to 1 km   | Single building or room |
| CAN         | Up to 10 km  | University campus |
| MAN         | Up to 100 km | City-wide network |
| WAN         | Inter-city/country | Internet connecting global LANs |
| SAN         | Variable (storage-focused) | Data centers with shared storage |

Focus in CCNA is primarily on LAN and WAN.

## Network Topologies

Topologies describe how devices are interconnected:

- **Bus Topology**: Devices connected via a single backbone cable with terminators at ends. Obsolete due to single point of failure—if one device or cable fails, the entire network fails.

- **Ring Topology**: Devices form a loop, each connected to two others using two network cards per device. Improved over bus but obsolete; failure in one link can disrupt the network.

- **Star Topology**: Devices connect to a central device (e.g., switch or hub). Common today; failure of one device/cable affects only that device, not the network.

- **Mesh Topology**: Devices interconnected for redundancy.
  - **Full Mesh**: Every device connects to all others (high redundancy but costly; requires multiple network cards per device).
  - **Partial (Half) Mesh**: Not all devices connect to every other.
  - Provides redundancy (e.g., if one cable fails, alternatives exist).
  - Not practical for end-user devices due to cost and complexity; typically used between switches or routers.

- **Hybrid Topology**: Combination of topologies (e.g., star for end devices to switches, mesh between switches). Most real-world networks are hybrid for balance of reliability and cost.

## Network Devices

Key devices used in building networks (focus on modern ones; some are obsolete):

- **Hub**: Obsolete central device for connecting devices in star topology. Replaced by switches due to inefficiencies.

- **Switch**: Central device in star topology.
  - **Layer 2 Switch**: Basic switching based on MAC addresses.
  - **Layer 3 (Multi-Layer) Switch**: Advanced, supports routing functions.
  - Differences between Layer 2 and Layer 3 covered in future videos.

- **Router**: Connects multiple networks (e.g., LANs or to the internet). Not needed for a single LAN; essential for inter-network communication.

- **Firewall**: Provides security by controlling access. Protects from external threats and manages internal traffic (e.g., allow/deny internet access, block sites like Facebook for specific users).

- **Bridge**: Obsolete; transitional device between hub and switch eras.

- **Repeater**: Extends cable length beyond 100m limit (e.g., for Ethernet). Obsolete; modern alternatives include additional hubs or switches.

- **Modem**: Connects to the internet via ISP. Distinct from routers .


# Network Interface Cards, MAC Addresses, Hubs vs. Switches

## Network Interface Card (NIC)

Every device connected to a network requires a **Network Interface Card (NIC)**, also known as:
- Network Adapter
- Ethernet Card
- LAN Card

The NIC is responsible for transmitting and receiving data over the network.

- **Appearance**: Internal component in desktops; laptops have built-in NICs (wired and/or wireless).
- **Connection**: RJ-45 port for Ethernet cable.

### NIC Speeds

Common speeds (measured in **bits per second**, not bytes):
- 10 Mbps → **Ethernet**
- 100 Mbps → **Fast Ethernet**
- 1000 Mbps (1 Gbps) → **Gigabit Ethernet**

Higher speeds (e.g., 10 Gbps+) exist in modern enterprise environments.

## MAC Address (Media Access Control Address)

- **Definition**: A unique hardware identifier burned into every NIC by the manufacturer.
- **Uniqueness**: Globally unique; no two NICs worldwide should have the same MAC address.
- **Format**: 48 bits, represented as 12 hexadecimal digits (0-9, A-F).
  - Example: `00-1A-2B-3C-4D-5E`
  - Written in pairs separated by colons or hyphens.

### Structure of MAC Address

- **First 6 digits (24 bits)**: **Organizationally Unique Identifier (OUI)**  
  Assigned by the **IEEE** (Institute of Electrical and Electronics Engineers) to the NIC manufacturer (e.g., HP, Cisco, Intel).
- **Last 6 digits (24 bits)**: **Serial number** assigned internally by the manufacturer.

This system ensures global uniqueness: Different manufacturers get different OUIs, and each assigns unique serials.

> MAC addresses identify devices at **Layer 2** (Data Link Layer) of the OSI model (covered later).

## Switches

Modern central device for connecting devices in a star topology.

- **Types**:
  - **Layer 2 Switch**: Standard switch; operates at Data Link Layer (most common).
  - **Layer 3 Switch (Multi-Layer Switch)**: Combines switching and routing functions (performs both Layer 2 switching and Layer 3 routing in one device).

- **Port Count**: Typically 4, 8, 16, 24, 48 ports or more.
- **Icons in Simulation Tools** (e.g., Cisco Packet Tracer):
  - Layer 2: Standard switch icon.
  - Layer 3: Switch with router-like features.

## Hubs (Obsolete)

- Older central device; replaced entirely by switches.
- Limited ports; no longer manufactured or sold new.
- Icon: Often shown with bidirectional arrows.

## Transmission Types (Signal Modes)

| Type              | Description                                      | Example                          | Network Relevance |
|-------------------|--------------------------------------------------|----------------------------------|-------------------|
| **Simplex**       | Data flows in one direction only                 | Radio/TV broadcast               | Rare in networks  |
| **Half-Duplex**   | Send or receive, but not both simultaneously     | Walkie-talkie ("over")           | Used by hubs      |
| **Full-Duplex**   | Send and receive simultaneously                  | Telephone conversation           | Used by switches  |

- **Hub Limitation**: Operates only in half-duplex → devices must take turns sending data → causes delays with multiple devices.
- **Switch Advantage**: Supports full-duplex → simultaneous send/receive → faster, more efficient.

## Data Transmission Methods (Casting Types)

| Type          | Description                                      | Destination                     | Example |
|---------------|--------------------------------------------------|---------------------------------|---------|
| **Unicast**   | One-to-one communication                         | Single specific device          | PC sending file to another PC |
| **Broadcast** | One-to-all communication                         | All devices on the network      | Announcement: "Store closing in 10 minutes" |
| **Multicast** | One-to-many (specific group)                     | Selected group of devices       | Announcement: "Discount on children's clothing" (targets a group) |

## Hub vs. Switch Comparison

| Feature                  | Hub                                      | Switch                                      |
|--------------------------|------------------------------------------|---------------------------------------------|
| **OSI Layer**            | Layer 1 (Physical)                       | Layer 2 (Data Link); Layer 3 for multi-layer |
| **Duplex Mode**          | Half-duplex only                         | Full-duplex                                 |
| **Casting**              | Broadcast only (sends data to all ports) | Unicast, Multicast, Broadcast (intelligent forwarding) |
| **Intelligence**         | "Dumb" device – floods all traffic       | "Smart" device – learns MAC addresses and forwards selectively |
| **Performance**          | High traffic/collisions → slow network   | Low traffic → efficient, fast               |
| **Status**               | Obsolete                                 | Current standard                            |

### Why Hubs Became Obsolete

- **Broadcast Behavior**: When a device sends data, the hub forwards it to **every port**, regardless of destination → unnecessary traffic → network congestion.
- **Half-Duplex**: Devices cannot send/receive simultaneously → bottlenecks.
- **Result**: Poor performance with many devices → replaced by intelligent switches.

### How Switches Are Smarter

- Switches learn MAC addresses of connected devices (via MAC address table – covered in detail next).
- When a frame arrives:
  - First time: May flood (like hub).
  - Subsequently: Forwards only to the correct port (unicast) → reduces traffic dramatically.

This intelligence makes switches the foundation of modern LANs.

Upcoming topics: How switches build MAC address tables, deeper Layer 2/3 differences, and practical configurations.



# How Switches Work: MAC Address Table, ARP, Unicast Forwarding, and Domains

## Switch Intelligence: MAC Address Table

Switches are "smart" devices that learn and store MAC addresses to forward frames efficiently.

- **MAC Address Table** (also called CAM Table – Content Addressable Memory):
  - A dynamic table inside the switch.
  - Columns: **MAC Address** and **Port Number**.
  - Initially empty when the switch is powered on.

- **Learning Process**:
  - When a frame arrives on a port, the switch records the **source MAC address** of the frame and associates it with the incoming port.
  - Example: Frame from MAC `AA:AA` arrives on Port 1 → Switch adds entry: `AA:AA → Port 1`.

- **Forwarding Decision**:
  - Switch examines the **destination MAC address** in the frame.
  - Looks it up in the MAC address table:
    - **Match found**: Forwards frame only to the matching port (**Unicast**).
    - **No match**: Floods frame to all ports except the incoming one (**Flooding** – similar to broadcast but not to source port).
  - Does **not** flood to the source port (avoids loops/unnecessary traffic).

- **First Communication Example**:
  - Host H1 (MAC: AA) on Port 1 wants to send to Host H2 (MAC: BB) on Port 2.
  - First frame: Destination MAC BB unknown → Switch floods to all ports.
  - H2 replies → Switch learns BB on Port 2.
  - Subsequent frames from H1 to H2: Direct unicast to Port 2 only.

This reduces unnecessary traffic compared to hubs (which always flood).

## ARP (Address Resolution Protocol)

Essential for mapping IP addresses to MAC addresses in local networks.

- **Problem**: Devices know target **IP address** but need **destination MAC** for Layer 2 frames.
- **Solution**: ARP resolves IP → MAC.
  - Sending device broadcasts an **ARP Request**: "Who has IP 192.168.1.5? Tell me your MAC."
  - Switch floods ARP request (broadcast) to all ports.
  - Target device replies with **ARP Reply** (unicast): "IP 192.168.1.5 is at MAC BB:BB."
  - Sender caches the mapping (ARP table).

- **Key Point**: ARP is used when destination MAC is unknown; enables unicast after resolution.
- **Security Note**: ARP is trust-based → vulnerable to ARP spoofing/poisoning (covered in security topics).

## Broadcast and Collision Domains

### Broadcast Domain
- Area where a broadcast frame reaches all devices.
- **Hub**: Entire hub = 1 broadcast domain (always broadcasts).
- **Bridge/Switch**: Entire switch (all ports) = 1 broadcast domain by default.
- **Router**: Stops broadcasts → Each router interface creates a separate broadcast domain.
  - Rule: Routers do **not** forward broadcasts.

| Device       | Broadcast Domains Created |
|--------------|----------------------------|
| Hub          | 1 (whole device)          |
| Switch/Bridge| 1 (all ports connected)   |
| Router       | 1 per interface           |

Large broadcast domains cause high traffic (broadcast storms if excessive).

### Collision Domain
- Area where collisions can occur (in half-duplex environments).
- Modern full-duplex switches eliminate collisions between devices.
- **Approximate Rule** (historical/legacy context):
  - Each port on a switch/bridge/router is a separate collision domain.
  - Hub: Entire hub = 1 collision domain.

| Device       | Collision Domains |
|--------------|--------------------|
| Hub          | 1                 |
| Switch/Bridge| 1 per port        |
| Router       | 1 per interface   |

In modern networks (full-duplex), collisions are rare/non-existent.

## Reducing Broadcast Impact: VLANs (Preview)

- Default: All switch ports in one broadcast domain → Broadcasts flood everywhere → High traffic in large networks.
- **Problem Example**: 100+ devices on one switch → One broadcast affects all.
- **Solution**: **VLANs (Virtual LANs)** – Logical segmentation.
  - Divide switch ports into separate VLANs → Each VLAN = separate broadcast domain.
  - Broadcast in VLAN 10 stays in VLAN 10; does not affect VLAN 20.
  - Reduces broadcast propagation → Improves performance/security.

VLANs are a core CCNA topic (detailed in upcoming switching sections).

## Exam Tips

- Common question: First communication between hosts → Switch floods (unknown unicast).
- Subsequent communication → Unicast.
- If source port already known but destination unknown → Flood **except** source port (not full broadcast).
- "Broadcast except source port" often phrased as "flood" or "unknown unicast flooding".
- Routers segment both broadcast and collision domains.

This foundational understanding of Layer 2 switching (MAC learning, ARP, domains) is critical for CCNA success and real-world troubleshooting. Upcoming will cover routers, VLAN configuration, and labs.

