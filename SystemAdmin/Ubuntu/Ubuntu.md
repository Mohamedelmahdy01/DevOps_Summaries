# UFW (Uncomplicated Firewall) Cheat Sheet

A quick reference guide for managing firewall rules with UFW on Linux.

---

## **Table of Contents**
1. [Installation](#installation)
2. [Basic Commands](#basic-commands)
3. [Allow/Deny Rules](#allowdeny-rules)
4. [Port Management](#port-management)
5. [Advanced Rules](#advanced-rules)
6. [Logging](#logging)
7. [Reset Rules](#reset-rules)
8. [Examples](#examples)

---

## **Installation**
```bash
# Install UFW on Ubuntu/Debian
sudo apt update && sudo apt install ufw

# Enable UFW (start on boot)
sudo ufw enable

# Check UFW status
sudo ufw status verbose
```

---

## **Basic Commands**
| Command | Description |
|---------|-------------|
| `sudo ufw enable` | Enable UFW and start on boot. |
| `sudo ufw disable` | Disable UFW. |
| `sudo ufw reset` | Reset all rules to default. |
| `sudo ufw status` | Show current rules. |
| `sudo ufw reload` | Reload rules without downtime. |

---

## **Allow/Deny Rules**
```bash
# Allow incoming traffic on a specific port:
sudo ufw allow <port>          # E.g., sudo ufw allow 80

# Deny incoming traffic on a port:
sudo ufw deny <port>           # E.g., sudo ufw deny 22

# Allow traffic for a service (by name):
sudo ufw allow <service>       # E.g., sudo ufw allow ssh

# Allow traffic from a specific IP:
sudo ufw allow from <ip>       # E.g., sudo ufw allow from 192.168.1.100

# Deny traffic from a specific IP:
sudo ufw deny from <ip>
```

---

## **Port Management**
```bash
# Allow a port range:
sudo ufw allow <start_port>:<end_port>/<protocol>  # E.g., sudo ufw allow 3000:4000/tcp

# Allow a specific protocol (TCP/UDP):
sudo ufw allow <port>/<protocol>  # E.g., sudo ufw allow 53/udp

# Delete a rule:
sudo ufw delete allow <port>      # Delete by rule number or port
sudo ufw delete deny <port>
```

---

## **Advanced Rules**
```bash
# Rate limiting (prevent brute-force attacks):
sudo ufw limit <port>/<protocol>  # E.g., sudo ufw limit 22/tcp

# Allow traffic to a specific network interface:
sudo ufw allow in on <interface> to any port <port>  # E.g., sudo ufw allow in on eth0 to any port 80

# Block outgoing traffic for a port:
sudo ufw deny out <port>
```

---

## **Logging**
```bash
# Enable logging:
sudo ufw logging on

# Disable logging:
sudo ufw logging off

# View logs (default location):
tail -f /var/log/ufw.log
```

---

## **Reset Rules**
```bash
# Reset all rules and disable UFW:
sudo ufw reset

# After reset, re-enable UFW:
sudo ufw enable
```

---

## **Examples**
### Allow SSH and HTTP/HTTPS:
```bash
sudo ufw allow ssh
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
```

### Block FTP:
```bash
sudo ufw deny 21/tcp
```

### Allow a specific IP to access MySQL:
```bash
sudo ufw allow from 192.168.1.50 to any port 3306
```



📌 **Tip**: Always check rules with `sudo ufw status numbered` before deleting them!
---