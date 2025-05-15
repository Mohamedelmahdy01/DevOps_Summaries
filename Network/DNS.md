# DNS: Linux & DevOps Guide

## Table of Contents
1. [What is DNS? (The Big Picture)](#what-is-dns-the-big-picture)
2. [DNS from a Linux User's Point of View](#dns-from-a-linux-users-point-of-view)
   - [Understanding Key Concepts](#understanding-key-concepts)
   - [Essential Linux Commands](#essential-linux-commands)
   - [Configuration Files](#configuration-files)
   - [Managing DNS with `nmcli`](#managing-dns-with-nmcli)
3. [DNS from a DevOps Perspective](#dns-from-a-devops-perspective)
   - [DNS in Modern Infrastructure](#dns-in-modern-infrastructure)
   - [Key DevOps Practices](#key-devops-practices)
   - [Essential DevOps Tools](#essential-devops-tools)
4. [Troubleshooting Common DNS Issues](#troubleshooting-common-dns-issues)
5. [Key Takeaways](#key-takeaways)

---

## 1. What is DNS? (The Big Picture)

### Why do we need DNS?

Imagine trying to access websites by typing in long strings of numbers (IP addresses) instead of easy-to-remember names like `google.com`. It would be incredibly difficult! That's where the Domain Name System (DNS) comes in. It acts like the internet's phone book, translating those names into the IP addresses that computers use to communicate.

### How does DNS work? (Simplified)

1. You type `www.example.com` into your browser.
2. Your computer asks a DNS resolver (usually your ISP or a public DNS server like Google's `8.8.8.8`) for the IP address associated with `www.example.com`.
3. The resolver may already have the IP address cached (remembered from a previous query). If not, it goes on a journey:
   - It first asks a root DNS server: "Who knows about `.com`?"
   - It's directed to the `.com` TLD (Top Level Domain) server. This server says, "Ask the authoritative DNS server for `example.com`."
   - Finally, the authoritative server for `example.com` provides the IP address to the resolver.
4. The resolver gives the IP address back to your computer.
5. Your computer connects to the web server at that IP address and loads the website.

This process happens in milliseconds, making it almost invisible to the user.

---

## 2. DNS from a Linux User's Point of View

### Understanding Key Concepts

- **Forward Lookup**: Translating a domain name to an IP address (e.g., `example.com` → `93.184.216.34`).
- **Reverse Lookup**: Translating an IP address back to a domain name (e.g., `93.184.216.34` → `example.com`). Useful for identifying servers by their IP.
- **DNS Records**:
  - **A Record**: Maps a domain to an IPv4 address (e.g., `www.example.com` → `192.168.1.10`).
  - **CNAME Record**: Creates an alias, pointing one name to another (e.g., `blog.example.com` → `www.example.com`).
  - **MX Record**: Specifies the mail servers for a domain (e.g., `example.com` → `mail.example.com`).

### Essential Linux Commands

| Command         | Purpose                          | Example                          |
|-----------------|----------------------------------|----------------------------------|
| `dig`           | Detailed DNS queries (A, MX, NS) | `dig +short example.com`         |
| `nslookup`      | Simple or interactive lookups    | `nslookup -type=MX example.com`  |
| `host`          | Simplified lookups               | `host 8.8.8.8` (reverse DNS)     |
| `resolvectl`    | Query `systemd-resolved`         | `resolvectl status`              |
| `ping`          | Test DNS + connectivity          | `ping example.com`               |

#### Examples:
- **Basic A record lookup**:
  ```bash
  dig example.com
  ```
- **Querying a specific DNS server**:
  ```bash
  dig @8.8.8.8 example.com
  ```
- **Reverse lookup**:
  ```bash
  host 8.8.8.8
  ```
- **Systemd-resolved query**:
  ```bash
  resolvectl query example.com
  ```

### Configuration Files

1. **`/etc/hosts`**  
   - **Purpose**: Local overrides (bypasses DNS).
   - **Example**:  
     ```conf
     192.168.1.10 myserver.local
     ```

2. **`/etc/resolv.conf`**  
   - **Purpose**: Defines DNS servers and search domains.
   - **Example**:  
     ```conf
     nameserver 8.8.8.8   # Google DNS
     search example.com
     ```

3. **`/etc/nsswitch.conf`**  
   - **Purpose**: Controls resolution order (files vs. DNS).
   - **Key Line**:  
     ```conf
     hosts: files dns  # Check `/etc/hosts` first, then DNS
     ```

### Managing DNS with `nmcli`

The `nmcli` command is a powerful tool for managing network connections, including DNS configurations. Here's how to use it:

1. **Add a new connection with a specific DNS server**:
   ```bash
   nmcli connection add type ethernet con-name home ifname eth0 ipv4.dns 8.8.8.8
   ```

2. **Modify an existing connection to add another DNS server**:
   ```bash
   nmcli connection modify home +ipv4.dns 8.8.4.4
   ```

3. **Activate the connection to apply changes**:
   ```bash
   nmcli connection up home
   ```

4. **Verify the DNS settings**:
   ```bash
   nmcli connection show home | grep ipv4.dns
   ```

These commands allow you to quickly configure and update DNS servers for your network connections without directly editing configuration files.

---

## 3. DNS from a DevOps Perspective

### DNS in Modern Infrastructure

- **Dynamic Environments**: Modern cloud environments use dynamic IPs that change rapidly (containers, VMs).
- **Service Discovery**: Applications need to find each other to communicate in microservices environments.

### Key DevOps Practices

- **DNS Automation (IaC)**:
  ```hcl
  # Terraform + AWS Route 53 Example
  resource "aws_route53_record" "web" {
    zone_id = "Z2ABCDEFG"
    name    = "app.example.com"
    type    = "A"
    ttl     = 300
    records = ["10.0.0.1"]
  }
  ```
- **Service Discovery**:
  - Tools: **Kubernetes CoreDNS**, **Consul**, **AWS Cloud Map**.
  - Automatically registers services in dynamic environments.

### Essential DevOps Tools

| Tool               | Use Case                              |
|--------------------|---------------------------------------|
| **Terraform**      | Provision DNS records via IaC.        |
| **ExternalDNS**    | Sync Kubernetes services with DNS.    |
| **CoreDNS**        | Flexible DNS server for Kubernetes.   |
| **AWS Route 53**   | Managed DNS + traffic policies.       |
| **Prometheus**     | Monitor DNS latency/errors.           |

---

## 4. Troubleshooting Common DNS Issues

### Problem Scenarios and Solutions

| Issue                      | Cause                          | Fix                                   |
|----------------------------|--------------------------------|---------------------------------------|
| Local override ignored     | `dns` before `files` in `nsswitch.conf` | Edit `nsswitch.conf` to prioritize `files`. |
| Slow DNS resolution        | Unresponsive DNS servers       | Replace with reliable servers (e.g., `1.1.1.1`). |
| Stale DNS cache            | Cached records with expired TTL| Flush cache: `sudo systemctl restart systemd-resolved`. |

### DevOps-Specific Checks
- **TTL Mismanagement**: Lower TTL before deployments for faster rollbacks.
- **DNSSEC Misconfigurations**: Validate zone signing (e.g., AWS Route 53 DNSSEC).
- **Certificate Validation Failures**: Ensure DNS records match Let’s Encrypt challenges.

---

## 5. Key Takeaways

1. **Linux**:  
   - Use `dig`/`nslookup` for debugging.  
   - Prioritize resolution order via `/etc/nsswitch.conf`.  
2. **DevOps**:  
   - Treat DNS as code (version control, CI/CD).  
   - Use DNS for traffic management (failover, load balancing).  
3. **Universal**:  
   - Monitor DNS health (latency, errors).  
   - Secure DNS with DNSSEC and private zones.

