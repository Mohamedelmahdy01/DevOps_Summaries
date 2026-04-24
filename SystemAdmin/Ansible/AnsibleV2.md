
# Chapter 1: Introduction & Fundamentals

## 1. What is Ansible?

Ansible is an open-source **automation engine** that automates software provisioning, configuration management, and application deployment. Unlike many other tools, it is designed to be minimal in nature and easy to deploy.

### Core Philosophy
* **Simplicity:** Uses human-readable **YAML** (Yet Another Markup Language) for playbooks.
* **Efficiency:** No extra software (agents) to install on target servers — Agentless.
* **Security:** Uses **SSH** (Linux) and **WinRM** (Windows) for secure communication.
* **Idempotency:** Running the same playbook multiple times always produces the same result.

---

## 2. Key Concepts & Features

### A. Agentless Architecture

Most automation tools require you to install "agent" software on every server you want to manage. **Ansible does not.** It connects to managed nodes, pushes small programs called "Ansible Modules," executes them, and then removes them.

> **Benefit:** Lower overhead, no agent maintenance, and instant deployment.

**How it works under the hood:**
```
Control Node                    Managed Node
     |                               |
     |--- SSH Connection ----------->|
     |--- Push Module (Python) ----->|
     |                               |--- Execute Module
     |<-- JSON Result (stdout) ------|
     |--- Remove Module ------------>|
     |--- Close SSH ---------------->|
```

### B. Idempotency — The Most Important Concept

An **idempotent** operation produces the same result no matter how many times you run it.

**Real-world example:**
```yaml
# Running this 1 time or 100 times = exact same result
- name: Ensure Nginx is installed
  package:
    name: nginx
    state: present   # "present" means "make sure it exists"
```

| Run | Nginx Already Installed? | Action Taken | Report |
|-----|--------------------------|--------------|--------|
| 1st | No | Installs Nginx | `changed` |
| 2nd | Yes | Does nothing | `ok` |
| 3rd | Yes | Does nothing | `ok` |

> ⚠️ **Common Pitfall:** The `shell` and `command` modules are **NOT idempotent** by default. `shell: touch /tmp/file` will always report `changed` even if the file already exists. Always prefer specialized modules like `file`, `copy`, etc.

### C. Declarative vs. Imperative

| Approach | Method | Example |
|----------|--------|---------|
| **Imperative** (scripting) | Tell it *how* to do it | `apt-get download nginx && dpkg -i nginx.deb && systemctl start nginx` |
| **Declarative** (Ansible) | Tell it *what* you want | `state: present` |

---

## 3. Ansible Architecture Components

```
┌─────────────────────────────────────────────────────────┐
│                    CONTROL NODE                         │
│   ┌──────────┐  ┌───────────┐  ┌────────────────────┐  │
│   │Inventory │  │ Playbooks │  │  ansible.cfg       │  │
│   │(hosts)   │  │(YAML)     │  │  (configuration)   │  │
│   └──────────┘  └───────────┘  └────────────────────┘  │
└──────────────────────┬──────────────────────────────────┘
                       │ SSH / WinRM
          ┌────────────┼────────────┐
          ▼            ▼            ▼
   ┌────────────┐ ┌──────────┐ ┌──────────┐
   │ Web Server │ │ DB Server│ │ App Srvr │
   │ (Python)   │ │ (Python) │ │ (Python) │
   └────────────┘ └──────────┘ └──────────┘
        MANAGED NODES (Hosts)
```

1. **Control Node:** The machine (Linux/macOS) where Ansible is installed. Windows is NOT supported as a control node.
2. **Managed Nodes (Hosts):** The servers you are managing. They only need **Python 3.x** installed.
3. **Inventory:** A list of managed nodes. Can be a simple file or dynamic (from cloud APIs).
4. **Playbooks:** The "instruction manuals" written in YAML.
5. **Modules:** The actual tools (`yum`, `apt`, `copy`, `service`, etc.) that do the work.
6. **ansible.cfg:** The main configuration file. Ansible looks for it in this order:
   - `ANSIBLE_CONFIG` environment variable
   - `./ansible.cfg` (current directory) ← **Best practice for projects**
   - `~/.ansible.cfg` (home directory)
   - `/etc/ansible/ansible.cfg` (global)

---

## 4. Lab Environment Setup (VirtualBox + CentOS)

### Phase 1: The Template VM
1. **Download:** Get a pre-configured CentOS `.vdi` from [osboxes.org](https://www.osboxes.org).
2. **Create:** New VM in VirtualBox → Linux 64-bit → Use existing hard disk (the `.vdi` file).
3. **Network:** Use **Bridged Adapter** to give the VM its own IP on your local network.
4. **Verify:** Boot up, login (`osboxes`/`osboxes.org`), and check IP using `ip addr` or `ifconfig`.

### Phase 2: Cloning the Lab

Instead of creating 3 VMs from scratch, **Clone** the template:
- **Controller Node** (Clone 1) → Install Ansible here.
- **Target Node 1** (Clone 2) → Managed by the controller.
- **Target Node 2** (Clone 3) → Managed by the controller.

> **⚠️ CRITICAL:** When cloning, always check **"Generate new MAC addresses for all network adapters"**. Without this, all VMs will have the same MAC address → same IP → they'll conflict on the network.

### Phase 3: Installing Ansible

On the **Controller Node**:
```bash
# Update and install EPEL (Extra Packages for Enterprise Linux)
sudo yum install epel-release -y

# Install Ansible
sudo yum install ansible -y

# Verify Installation
ansible --version
# Output example:
# ansible [core 2.14.0]
#   python version = 3.9.x
#   jinja version = 3.1.x
```

### Phase 4: Setting Up ansible.cfg for Your Lab

Create a project `ansible.cfg` to avoid typing flags every time:
```ini
[defaults]
inventory      = ./hosts          # Default inventory file
remote_user    = osboxes          # Default SSH user
host_key_checking = False         # OK for lab, NOT for production

[privilege_escalation]
become         = True             # Always use sudo
become_method  = sudo
```

> 💡 **Pro Tip:** Having a per-project `ansible.cfg` means you don't need to type `-i hosts -u osboxes --become` on every command. Just run `ansible-playbook site.yml`.

---

## 5. SSH Connectivity (The Ansible Way)

Ansible uses SSH to talk to nodes. Setting up **Passwordless SSH** is essential.

### Step-by-Step SSH Setup

```bash
# Step 1: Generate SSH Keys on the Controller Node
ssh-keygen -t rsa -b 4096 -f ~/.ssh/ansible_key -N ""
# -N "" means no passphrase (needed for automation)

# Step 2: Copy your public key to each Target Node
ssh-copy-id -i ~/.ssh/ansible_key.pub osboxes@192.168.1.10
ssh-copy-id -i ~/.ssh/ansible_key.pub osboxes@192.168.1.11

# Step 3: Test manual SSH (should connect without password)
ssh -i ~/.ssh/ansible_key osboxes@192.168.1.10
```

### Testing with Ansible Ping

```ini
# hosts file
[targets]
node1 ansible_host=192.168.1.10
node2 ansible_host=192.168.1.11
```

```bash
ansible all -i hosts -m ping --private-key ~/.ssh/ansible_key
```

**Success Response:**
```json
node1 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

**Common Failure: "Permission denied (publickey)"**
```bash
# Fix: Make sure the key was copied correctly
ssh-copy-id -i ~/.ssh/ansible_key.pub osboxes@192.168.1.10

# Or debug with verbose mode
ansible all -i hosts -m ping -vvv
```

---

## 6. Summary Table

| Feature | Description |
|---------|-------------|
| **Language** | YAML (Human Readable) |
| **Protocol** | SSH (port 22) / WinRM (port 5985/5986) |
| **Philosophy** | Agentless & Idempotent |
| **Control Node** | Linux/macOS only |
| **Managed Nodes** | Linux, Windows, Network Devices, Cloud |
| **Setup** | Control Node (Ansible installed) → Managed Nodes (Python only) |

---

# Chapter 2: Inventory Management & Connectivity Deep Dive

The **Inventory** is the brain of Ansible — it defines which servers exist and how to connect to them.

---

## 1. The Inventory: Your Source of Truth

### Inventory Locations
1. **Default Location:** `/etc/ansible/hosts` — Global, but avoid in professional projects.
2. **Project Location:** `./hosts` or `./inventory.ini` in your project folder. ✅ Use this.
3. **Specified at runtime:** `ansible-playbook site.yml -i /path/to/inventory`

---

## 2. Essential Connection Parameters

These parameters go next to each host in the inventory:

| Parameter | Description | Example |
|-----------|-------------|---------|
| `ansible_host` | Actual IP or DNS (when using aliases) | `ansible_host=192.168.1.10` |
| `ansible_user` | SSH login username | `ansible_user=ubuntu` |
| `ansible_port` | SSH port (default: 22) | `ansible_port=2222` |
| `ansible_connection` | Connection type | `ansible_connection=ssh` |
| `ansible_ssh_private_key_file` | Path to SSH private key | `ansible_ssh_private_key_file=~/.ssh/id_rsa` |
| `ansible_ssh_pass` | SSH password (**avoid in production**) | `ansible_ssh_pass=secret` |
| `ansible_python_interpreter` | Python path on remote | `ansible_python_interpreter=/usr/bin/python3` |
| `ansible_become` | Enable privilege escalation | `ansible_become=true` |
| `ansible_become_user` | User to become (default: root) | `ansible_become_user=root` |

> ⚠️ **`ansible_python_interpreter` — When you need it:**
> On newer systems with both Python 2 and Python 3, Ansible might pick the wrong one. You'll see warnings like `[WARNING]: Platform linux on host x is using the discovered Python interpreter at /usr/bin/python`.
> **Fix:** Add `ansible_python_interpreter=/usr/bin/python3` to your inventory or `ansible.cfg`.

---

## 3. Organizing Infrastructure: Groups & Meta-groups

### A. INI Format

```ini
# ── Ungrouped hosts (accessible via 'all' or 'ungrouped') ──
standalone_server ansible_host=10.0.0.1

# ── Web Servers Group ──
[web]
web01 ansible_host=192.168.1.10 ansible_user=ubuntu
web02 ansible_host=192.168.1.11 ansible_user=ubuntu

# ── Database Servers Group ──
[db]
db01  ansible_host=192.168.1.50 ansible_user=db_admin
db02  ansible_host=192.168.1.51 ansible_user=db_admin

# ── Load Balancers Group ──
[lb]
lb01  ansible_host=192.168.1.5

# ── Meta-Group: Production = web + db + lb ──
[production:children]
web
db
lb

# ── Group Variables (apply to all servers in [web]) ──
[web:vars]
ansible_user=ubuntu
http_port=80
```

### B. YAML Format (Modern Approach)

```yaml
# inventory.yml
all:
  children:
    production:
      children:
        web:
          hosts:
            web01:
              ansible_host: 192.168.1.10
              ansible_user: ubuntu
            web02:
              ansible_host: 192.168.1.11
              ansible_user: ubuntu
          vars:
            http_port: 80

        db:
          hosts:
            db01:
              ansible_host: 192.168.1.50
              ansible_user: db_admin

    staging:
      children:
        web:
          hosts:
            web-stg01:
              ansible_host: 10.0.1.10
```

### C. Numbered Hosts (Pattern Shorthand)

```ini
# Instead of listing web01, web02, ..., web20 one by one:
[web]
web[01:20]   # Generates web01, web02, ..., web20

[db]
db-[a:d]     # Generates db-a, db-b, db-c, db-d
```

---

## 4. Testing Connectivity

### Ad-Hoc Ping
```bash
# Test all hosts
ansible all -i inventory.ini -m ping

# Test only web group
ansible web -i inventory.ini -m ping

# Test with a specific user
ansible all -i inventory.ini -m ping -u ubuntu
```

### Connectivity Check Playbook (For Audit Logs)
```yaml
# connectivity_check.yml
---
- name: Infrastructure Connectivity Audit
  hosts: all
  gather_facts: false
  tasks:
    - name: Verify SSH and Python are functional
      ping:
      register: ping_result

    - name: Show result
      debug:
        msg: "Host {{ inventory_hostname }} is reachable — responded: {{ ping_result.ping }}"
```

---

## 5. Security & SSH Key Verification

### The Fingerprint Problem

When you first connect to a new server, SSH prompts:
```
The authenticity of host '192.168.1.10 (192.168.1.10)' can't be established.
ECDSA key fingerprint is SHA256:xxxx...
Are you sure you want to continue connecting (yes/no)?
```

Ansible cannot answer "yes" interactively → **the task fails.**

### Fix 1: Pre-load Keys with ssh-keyscan (Best Practice for Production)
```bash
# Add fingerprints for all your servers to known_hosts
ssh-keyscan -H 192.168.1.10 192.168.1.11 192.168.1.50 >> ~/.ssh/known_hosts

# Or scan an entire subnet
ssh-keyscan -H 192.168.1.{10..20} >> ~/.ssh/known_hosts
```

### Fix 2: Disable Check in ansible.cfg (Lab Only)
```ini
[defaults]
host_key_checking = False
```

> ⚠️ **NEVER disable host key checking in production.** It opens you up to Man-in-the-Middle attacks.

---

## 6. Viewing Your Inventory

```bash
# List all hosts as Ansible sees them (JSON format)
ansible-inventory -i inventory.ini --list

# Display as a tree (easy to read)
ansible-inventory -i inventory.ini --graph

# Output:
# @all:
#   |--@production:
#   |  |--@web:
#   |  |  |--web01
#   |  |  |--web02
#   |  |--@db:
#   |  |  |--db01
```

---

## 7. Inventory Best Practices

1. **Never hardcode passwords** — Use SSH keys or Ansible Vault (covered in Chapter 5).
2. **Use descriptive aliases** — `web-prod-01` is clearer than `10.0.0.5`.
3. **Separate environment inventories** — Have `inventory/production`, `inventory/staging`, `inventory/dev`.
4. **Use `group_vars` and `host_vars`** — Don't stuff all variables into the inventory file (covered in Chapter 5).
5. **Validate with `--graph`** — Always check `ansible-inventory --graph` after editing to catch grouping errors.

---

## Summary

| Concept | Key Takeaway |
|---------|-------------|
| **Inventory** | The single source of truth for your infrastructure |
| **INI format** | Simple, good for small setups |
| **YAML format** | Scalable, better for complex/nested structures |
| **`ping` module** | Tests SSH connectivity + Python availability |
| **`ssh-keyscan`** | The correct way to pre-approve server fingerprints |
| **`ansible-inventory --graph`** | Visualize and debug your inventory structure |

---

# Chapter 3: Ad-Hoc Commands vs. Playbooks

---

## 1. Ad-hoc Commands: Quick One-Off Tasks

Ad-hoc commands are for tasks you don't need to save or repeat. They call a single module from the command line.

### Anatomy
```bash
ansible <target> -m <module> -a "<arguments>" -i <inventory> [options]
```

### Common Examples

```bash
# Ping all hosts
ansible all -m ping -i hosts

# Check disk space on web servers
ansible web -m command -a "df -h" -i hosts

# Check uptime
ansible all -m command -a "uptime" -i hosts

# Install a package (--become = use sudo)
ansible db -m yum -a "name=git state=present" -i hosts --become

# Copy a file to all web servers
ansible web -m copy -a "src=/local/file.conf dest=/etc/app/file.conf" --become

# Restart a service
ansible web -m service -a "name=nginx state=restarted" --become

# Run a shell command (supports pipes)
ansible all -m shell -a "cat /etc/passwd | grep ansible" -i hosts

# Gather facts from a host
ansible web01 -m setup -i hosts

# Check if a file exists
ansible all -m stat -a "path=/etc/nginx/nginx.conf" -i hosts
```

### Useful Flags

| Flag | Meaning |
|------|---------|
| `-i hosts` | Specify inventory file |
| `--become` | Use sudo (privilege escalation) |
| `-u username` | SSH as this user |
| `--private-key ~/.ssh/key` | Use this SSH key |
| `-f 10` | Use 10 parallel forks |
| `-v / -vv / -vvv` | Verbosity (more v = more detail) |
| `--check` | Dry run — show what *would* change |
| `--diff` | Show file diffs when content changes |

---

## 2. Ansible Playbooks: The Master Plan

Playbooks are YAML files that define your desired infrastructure state in a repeatable, version-controlled format.

### Anatomy of a Playbook

```
A Playbook
└── One or more Plays
    ├── hosts: (which servers)
    ├── become: (privilege escalation)
    ├── vars: (variables)
    └── tasks: (ordered list of modules)
        ├── Task 1 (module + args)
        ├── Task 2 (module + args)
        └── Task 3 (module + args)
```

---

## 3. YAML Syntax — Critical Rules

Indentation errors are the #1 cause of Ansible failures. Master these rules:

```yaml
---                          # Document start marker (optional but recommended)
- name: My Play              # Dash = list item = new play
  hosts: web                 # 2-space indentation
  become: true
  vars:
    app_port: 8080           # Variables defined as key: value
    app_name: "my-app"       # Quotes needed when value starts with special char

  tasks:
    - name: Install package  # Each task starts with a dash
      package:               # Module name
        name: nginx          # Module parameters (indented under module)
        state: present

    - name: Start service
      service:
        name: nginx
        state: started
        enabled: true        # true/false (lowercase in YAML)
```

**Common YAML Errors:**
```yaml
# ❌ WRONG — tabs are NOT allowed, only spaces
tasks:
	- name: bad task       # This will fail with "YAML parse error"

# ❌ WRONG — missing quotes when value starts with {
dest: {{ web_root }}/index.html   # Fails

# ✅ CORRECT
dest: "{{ web_root }}/index.html"  # Works
```

---

## 4. Comprehensive Playbook Example

```yaml
---
- name: Full Web Server Setup
  hosts: webservers
  become: true
  vars:
    web_package: httpd
    web_service: httpd
    web_root: /var/www/html

  tasks:
    - name: Ensure Apache is installed
      yum:
        name: "{{ web_package }}"
        state: present

    - name: Ensure firewalld is running
      service:
        name: firewalld
        state: started
        enabled: true

    - name: Open HTTP port in firewall
      firewalld:
        service: http
        permanent: true
        state: enabled
      notify: Reload Firewall     # Trigger a handler

    - name: Deploy website index page
      copy:
        src: ./files/index.html
        dest: "{{ web_root }}/index.html"
        owner: apache
        mode: '0644'

    - name: Ensure Apache is started and enabled
      service:
        name: "{{ web_service }}"
        state: started
        enabled: true

  handlers:
    - name: Reload Firewall
      service:
        name: firewalld
        state: reloaded
```

### Handlers — What Are They?

Handlers are tasks that only run when **notified** by another task. They run **once** at the end of the play, even if notified multiple times.

**Use case:** Restarting a service only when its config file actually changed:
```yaml
tasks:
  - name: Update Nginx config
    template:
      src: nginx.conf.j2
      dest: /etc/nginx/nginx.conf
    notify: Restart Nginx         # Only triggers if file actually changed

handlers:
  - name: Restart Nginx
    service:
      name: nginx
      state: restarted
```

> 💡 **Why handlers?** If you restart Nginx as a regular task, it restarts every time you run the playbook — even when nothing changed. Handlers only restart when truly needed.

---

## 5. Running Playbooks

```bash
# Basic run
ansible-playbook -i inventory.ini site.yml

# Dry run (check mode) — shows what WOULD change
ansible-playbook -i inventory.ini site.yml --check

# Show file diffs
ansible-playbook -i inventory.ini site.yml --check --diff

# Run only specific tasks using tags
ansible-playbook -i inventory.ini site.yml --tags "install,configure"

# Skip specific tags
ansible-playbook -i inventory.ini site.yml --skip-tags "restart"

# Limit to specific hosts
ansible-playbook -i inventory.ini site.yml --limit web01

# Limit to a group
ansible-playbook -i inventory.ini site.yml --limit web

# Start from a specific task
ansible-playbook -i inventory.ini site.yml --start-at-task "Deploy website index page"

# Extra variables (override anything)
ansible-playbook -i inventory.ini site.yml -e "web_package=apache2"
```

---

## 6. Understanding Playbook Output

```
PLAY [Full Web Server Setup] **********************************

TASK [Gathering Facts] ****************************************
ok: [web01]
ok: [web02]

TASK [Ensure Apache is installed] *****************************
changed: [web01]    ← Ansible installed it (wasn't there)
ok: [web02]         ← Already installed, nothing to do

TASK [Deploy website index page] ******************************
changed: [web01]
changed: [web02]

RUNNING HANDLERS **********************************************
(nothing — firewall wasn't changed this run)

PLAY RECAP ****************************************************
web01  : ok=3  changed=2  unreachable=0  failed=0  skipped=0
web02  : ok=3  changed=1  unreachable=0  failed=0  skipped=0
```

| Status | Meaning |
|--------|---------|
| `ok` | Task ran, system was already in desired state |
| `changed` | Task ran and made a change |
| `failed` | Task failed, play stopped for this host |
| `unreachable` | SSH connection failed |
| `skipped` | Task was skipped (usually due to `when` condition) |

---

## 7. Comparison Summary

| Feature | Ad-Hoc Commands | Playbooks |
|---------|-----------------|-----------|
| **Command** | `ansible` | `ansible-playbook` |
| **Complexity** | Single module | Multi-task, multi-play |
| **Saved?** | No (ephemeral) | Yes (`.yml` files in Git) |
| **Style** | Imperative | Declarative |
| **Use Case** | Quick checks, reboots | Deployments, configurations |
| **Idempotency** | Module-dependent | Built-in reporting |
| **Error Handling** | Basic | Full `block/rescue/always` |

---

# Chapter 4: Ansible Modules Deep Dive

Modules are the actual tools that do work on your managed nodes. Think of Ansible as the craftsman and modules as the tools.

---

## 1. How Modules Work Internally

```
Your Playbook (YAML)
      ↓
Ansible reads the task
      ↓
Copies module Python script to /tmp/ on managed node
      ↓
Executes: python3 /tmp/ansible_module.py '{"name": "nginx", "state": "present"}'
      ↓
Module performs the work
      ↓
Module prints JSON to stdout: {"changed": true, "msg": "installed nginx"}
      ↓
Ansible cleans up the temp file
      ↓
Ansible reports result to you
```

Every module **must** output valid JSON with at least `{"changed": true/false}`.

---

## 2. System Modules

### A. The `user` Module

```yaml
# Create a user
- name: Create application user
  user:
    name: appuser
    uid: 1500                    # Set specific UID
    group: appgroup              # Primary group
    groups: docker,wheel         # Additional groups
    append: true                 # Add to groups (don't replace existing)
    shell: /bin/bash
    home: /opt/appuser
    create_home: true
    comment: "Application Service User"
    password: "{{ 'MyPass123' | password_hash('sha512') }}"
    state: present

# Lock a user account (disable login)
- name: Disable old user account
  user:
    name: olduser
    password_lock: true
    state: present

# Remove a user and their home directory
- name: Remove terminated employee
  user:
    name: ex_employee
    state: absent
    remove: true                 # Deletes home directory too
```

### B. The `package` / `yum` / `apt` Module

```yaml
# Generic (works on any distro)
- name: Install nginx
  package:
    name: nginx
    state: present

# yum (RHEL/CentOS) — install specific version
- name: Install specific Python version
  yum:
    name: python3-3.9.7
    state: present

# apt (Debian/Ubuntu) — with update cache
- name: Install packages on Ubuntu
  apt:
    name:
      - nginx
      - curl
      - git
    state: present
    update_cache: true           # Equivalent to apt-get update
    cache_valid_time: 3600       # Don't update cache if less than 1 hour old

# Install latest version
- name: Ensure nginx is up to date
  package:
    name: nginx
    state: latest                # ⚠️ Use carefully in production!

# Remove a package
- name: Remove Apache (replacing with Nginx)
  package:
    name: httpd
    state: absent
```

> ⚠️ **`state: latest` Warning:** Using `latest` in production can cause unexpected upgrades. Prefer `present` + pinned version for stability.

### C. The `service` Module

```yaml
- name: Ensure nginx is running and starts on boot
  service:
    name: nginx
    state: started               # started / stopped / restarted / reloaded
    enabled: true                # Start on boot

# Reload config without full restart (graceful)
- name: Reload nginx after config change
  service:
    name: nginx
    state: reloaded              # Sends SIGHUP — no downtime
```

---

## 3. File Modules

### A. The `copy` Module

```yaml
# Copy a file from control node
- name: Deploy application config
  copy:
    src: files/app.conf          # Relative to playbook directory
    dest: /etc/app/app.conf
    owner: app
    group: app
    mode: '0640'                 # Octal permissions — always use quotes
    backup: true                 # Create backup of existing file

# Copy content directly (no source file needed)
- name: Create a simple config file
  copy:
    content: |
      [settings]
      debug = false
      port = 8080
    dest: /etc/app/settings.ini
    owner: root
    mode: '0644'
```

### B. The `file` Module

```yaml
# Create a directory
- name: Create log directory
  file:
    path: /var/log/myapp
    state: directory
    owner: myapp
    group: myapp
    mode: '0755'
    recurse: true                # Apply permissions to all contents

# Create a symlink
- name: Create symlink
  file:
    src: /opt/app/current
    dest: /usr/local/bin/app
    state: link

# Touch a file (create if missing)
- name: Ensure log file exists
  file:
    path: /var/log/myapp/app.log
    state: touch
    owner: myapp
    mode: '0644'

# Delete a file
- name: Remove temp file
  file:
    path: /tmp/install.sh
    state: absent
```

### C. The `lineinfile` Module

Modifies a **single line** in an existing file. Perfect for configuration tweaks.

```yaml
# Disable root SSH login
- name: Disable root SSH login
  lineinfile:
    path: /etc/ssh/sshd_config
    regexp: '^#?PermitRootLogin'    # regex to find the line
    line: 'PermitRootLogin no'      # replace with this
    state: present
    backup: true                     # backup before modifying
  notify: Restart SSHD

# Add a line if it doesn't exist
- name: Increase file descriptor limits
  lineinfile:
    path: /etc/security/limits.conf
    line: '* soft nofile 65536'
    state: present

# Remove a line
- name: Remove deprecated setting
  lineinfile:
    path: /etc/myapp.conf
    regexp: '^old_setting='
    state: absent
```

### D. The `blockinfile` Module

Add/update/remove a **block of lines** in a file:

```yaml
- name: Add SSH config block for bastion host
  blockinfile:
    path: ~/.ssh/config
    marker: "# {mark} ANSIBLE MANAGED BLOCK — Bastion"
    block: |
      Host bastion
          HostName 10.0.0.1
          User ubuntu
          IdentityFile ~/.ssh/bastion_key
          ForwardAgent yes
    state: present
```

---

## 4. Command & Script Modules

| Module | Shell Features? | Best For |
|--------|----------------|----------|
| `command` | No | Simple commands, most secure |
| `shell` | Yes (pipes, redirects, env vars) | Complex shell logic |
| `script` | N/A | Run a local script remotely |
| `raw` | Yes | Targets without Python |

```yaml
# command — safe, no shell interpretation
- name: Check Java version
  command: java -version
  register: java_version
  changed_when: false            # This is read-only

# shell — supports pipes
- name: Find large log files
  shell: find /var/log -name "*.log" -size +100M | sort -rh
  register: large_logs
  changed_when: false

# script — runs a local .sh file on the remote host
- name: Run custom initialization script
  script: scripts/init.sh
  args:
    creates: /opt/app/.initialized  # Skip if this file exists (idempotency!)

# raw — no Python needed (use for bootstrapping)
- name: Install Python on bare system
  raw: apt-get install -y python3
```

> 💡 **The `creates` argument:** Makes `command` and `script` idempotent. The task skips if the specified file/directory exists. Similarly, `removes` skips if a file *doesn't* exist.

---

## 5. Discovering Modules

```bash
# List all installed modules
ansible-doc -l

# Search for modules related to a topic
ansible-doc -l | grep -i mysql
ansible-doc -l | grep -i aws

# View full documentation for a module
ansible-doc copy

# View documentation with EXAMPLES only
ansible-doc -s copy    # Shows a short synopsis with fields
```

---

## 6. Registering and Using Module Output

```yaml
- name: Check if app binary exists
  stat:
    path: /usr/local/bin/myapp
  register: app_binary          # Store result in this variable

- name: Show file details
  debug:
    msg: "File exists: {{ app_binary.stat.exists }}, size: {{ app_binary.stat.size | default('N/A') }}"

- name: Install app only if missing
  get_url:
    url: https://releases.myapp.com/v2/myapp
    dest: /usr/local/bin/myapp
    mode: '0755'
  when: not app_binary.stat.exists
```

---

## 7. Module Selection Guide

| Task | Best Module |
|------|-------------|
| Install software | `package` (generic), `yum` (RHEL), `apt` (Debian) |
| Start/stop service | `service` |
| Create/modify user | `user` |
| Copy file to remote | `copy` |
| Create file/dir/symlink | `file` |
| Edit one line in config | `lineinfile` |
| Add block to config | `blockinfile` |
| Download from URL | `get_url` |
| Check file/dir exists | `stat` |
| Unzip/extract archive | `unarchive` |
| Run complex shell command | `shell` |
| Make HTTP request | `uri` |
| Run script locally on remote | `script` |

---

## 8. Common Module Pitfalls

**Pitfall 1: Wrong permissions format**
```yaml
# ❌ Wrong — missing quotes
mode: 0644

# ✅ Correct — always quote octal permissions
mode: '0644'
```

**Pitfall 2: `shell` always reports `changed`**
```yaml
# ❌ Always changed
- shell: echo "hello"

# ✅ Fixed with changed_when
- shell: echo "hello"
  changed_when: false
```

**Pitfall 3: `copy` vs `template`**
```yaml
# copy — for STATIC files (no variables)
- copy:
    src: static_config.conf
    dest: /etc/app/config.conf

# template — for DYNAMIC files (has {{ variables }})
- template:
    src: dynamic_config.conf.j2
    dest: /etc/app/config.conf
```

---

# Chapter 5: Variables & Facts

Variables and Facts transform static playbooks into intelligent, adaptive automation.

---

## 1. Variable Naming Rules

```yaml
# ✅ Valid names
http_port: 8080
db_host: "192.168.1.50"
max_connections: 100
app_version: "2.1.4"

# ❌ Invalid names
http-port: 8080        # No hyphens
2nd_server: "x"        # Can't start with a number
ansible_*: "x"         # Reserved by Ansible (starts with ansible_)
```

---

## 2. Where to Define Variables — Full Reference

### A. In the Inventory
```ini
[web]
web01 ansible_host=192.168.1.10 http_port=80 env=prod
web02 ansible_host=192.168.1.11 http_port=8080 env=staging
```

### B. In the Playbook (`vars` block)
```yaml
- name: Setup App
  hosts: web
  vars:
    app_name: myapp
    app_port: 8080
    app_dirs:
      - /opt/myapp
      - /opt/myapp/logs
      - /opt/myapp/config
```

### C. In `vars_files` (External Files)
```yaml
- name: Setup App
  hosts: web
  vars_files:
    - vars/common.yml
    - vars/{{ env }}.yml      # Dynamic file loading based on env!
```

```yaml
# vars/prod.yml
app_port: 80
debug_mode: false
log_level: ERROR

# vars/staging.yml
app_port: 8080
debug_mode: true
log_level: DEBUG
```

### D. `group_vars` and `host_vars` — The Best Practice for Large Projects

```
project/
├── inventory.ini
├── group_vars/
│   ├── all.yml              # Variables for ALL hosts
│   ├── web.yml              # Variables for [web] group only
│   ├── db.yml               # Variables for [db] group only
│   └── production/
│       ├── vars.yml         # Production group vars
│       └── vault.yml        # Encrypted secrets (Ansible Vault)
├── host_vars/
│   ├── web01.yml            # Variables ONLY for web01
│   └── db-primary.yml       # Variables ONLY for db-primary
└── site.yml
```

```yaml
# group_vars/web.yml
nginx_worker_processes: auto
nginx_worker_connections: 1024
ssl_enabled: true
document_root: /var/www/html

# host_vars/web01.yml
server_id: 1
primary_node: true
```

### E. `vars_prompt` — Interactive Variables

```yaml
- name: Deploy App
  hosts: web
  vars_prompt:
    - name: app_version
      prompt: "Which version to deploy?"
      default: "latest"
      private: false           # Show input as user types

    - name: db_password
      prompt: "Database password"
      private: true            # Hidden input (like a password field)
```

---

## 3. Variable Types

```yaml
vars:
  # String
  server_name: "web-prod-01"

  # Number
  http_port: 80

  # Boolean
  ssl_enabled: true

  # List
  packages:
    - nginx
    - git
    - curl

  # Dictionary (key-value map)
  db_config:
    host: 192.168.1.50
    port: 3306
    name: production_db
    user: app_user
```

### Accessing Nested Variables

```yaml
# Dot notation
"{{ db_config.host }}"
"{{ db_config.port }}"

# Bracket notation (safer — avoids conflicts with Python attributes)
"{{ db_config['host'] }}"
"{{ db_config['port'] }}"

# List access by index
"{{ packages[0] }}"          # "nginx"

# Loop over a list
- name: Install all packages
  package:
    name: "{{ item }}"
    state: present
  loop: "{{ packages }}"
```

---

## 4. Ansible Facts — Auto-Discovered Variables

Before executing any task, Ansible runs the **"Gathering Facts"** step (uses the `setup` module). This collects hundreds of variables about the target system.

```bash
# See ALL facts for a host
ansible web01 -m setup

# Filter for specific facts
ansible web01 -m setup -a "filter=ansible_distribution*"
ansible web01 -m setup -a "filter=ansible_memory*"
```

### Most Useful Facts

```yaml
# OS Information
ansible_distribution          # "CentOS", "Ubuntu", "Debian"
ansible_distribution_version  # "8.5", "22.04"
ansible_os_family             # "RedHat", "Debian"
ansible_distribution_major_version  # "8", "22"

# Hardware
ansible_memtotal_mb           # Total RAM in MB
ansible_processor_vcpus       # Number of vCPUs
ansible_architecture          # "x86_64"

# Network
ansible_default_ipv4.address  # Primary IP address
ansible_default_ipv4.interface # Primary interface name (eth0, ens3...)
ansible_hostname              # Short hostname
ansible_fqdn                  # Fully qualified domain name

# Filesystem
ansible_mounts                # List of mounted filesystems
```

### Real-World Facts Usage

```yaml
- name: Install web server (OS-aware)
  package:
    name: "{{ 'apache2' if ansible_os_family == 'Debian' else 'httpd' }}"
    state: present

- name: Set swappiness based on RAM
  sysctl:
    name: vm.swappiness
    value: "{{ '10' if ansible_memtotal_mb > 4096 else '60' }}"

- name: Skip if not enough disk space
  debug:
    msg: "Insufficient disk space!"
  when: ansible_mounts | selectattr('mount', 'equalto', '/') | map(attribute='size_available') | first < 1073741824
```

### Disabling or Caching Facts

```yaml
# Disable facts gathering (speeds up playbook when you don't need them)
- name: Quick Task
  hosts: all
  gather_facts: false
  tasks:
    - ping:
```

```ini
# Cache facts to disk (in ansible.cfg) — avoids re-gathering every run
[defaults]
fact_caching = jsonfile
fact_caching_connection = /tmp/ansible_facts_cache
fact_caching_timeout = 3600    # Cache valid for 1 hour
```

---

## 5. Jinja2 Templating

Ansible uses the Jinja2 engine to process `{{ variable }}` expressions everywhere — in tasks, templates, conditions, and more.

### Basic Syntax

```yaml
# Print a variable
"{{ app_port }}"

# Math operations
"{{ app_port + 1 }}"
"{{ (ansible_memtotal_mb / 1024) | round(1) }}"

# String concatenation
"{{ app_name + '-' + env }}"
# Or with format filter:
"{{ '%s-%s' | format(app_name, env) }}"

# Conditional expression (ternary)
"{{ 'production' if env == 'prod' else 'development' }}"
```

### Essential Filters

```yaml
# String manipulation
{{ hostname | upper }}              # "WEB-01"
{{ hostname | lower }}              # "web-01"
{{ hostname | capitalize }}         # "Web-01"
{{ hostname | replace('-', '_') }}  # "web_01"
{{ "  hello  " | trim }}            # "hello"

# List/Dict filters
{{ packages | length }}             # Count items
{{ packages | first }}              # First item
{{ packages | last }}               # Last item
{{ packages | join(', ') }}         # "nginx, git, curl"
{{ packages | sort }}               # Sorted list
{{ packages | unique }}             # Remove duplicates
{{ mydict | dict2items }}           # Convert dict to list of {key, value}

# Number filters
{{ 1024 | human_readable }}         # "1.00 KB"
{{ large_number | int }}            # Convert to integer

# Default values (critical for safety)
{{ db_port | default(3306) }}       # Use 3306 if db_port not defined
{{ config | default({}) }}          # Default to empty dict

# Security
{{ password | password_hash('sha512') }}   # Hash a password
{{ secret | b64encode }}                   # Base64 encode
{{ encoded | b64decode }}                  # Base64 decode

# Testing
{{ variable is defined }}
{{ variable is not defined }}
{{ value | bool }}                  # Convert to boolean
```

### Filters for File Paths

```yaml
{{ '/etc/nginx/nginx.conf' | basename }}   # "nginx.conf"
{{ '/etc/nginx/nginx.conf' | dirname }}    # "/etc/nginx"
{{ 'nginx.conf.j2' | splitext | first }}  # "nginx.conf"
```

---

## 6. Custom Facts

You can define your own facts on managed nodes. Ansible will gather them automatically.

```bash
# On the managed node, create /etc/ansible/facts.d/app.fact
# This can be a .ini or .json file
```

```ini
# /etc/ansible/facts.d/app.fact
[app]
version = 2.1.4
environment = production
last_deploy = 2024-01-15
```

Access them in playbooks as:
```yaml
"{{ ansible_local.app.app.version }}"      # "2.1.4"
"{{ ansible_local.app.app.environment }}"  # "production"
```

---

## 7. Ansible Vault — Protecting Secrets

**Never store passwords, API keys, or tokens in plaintext.** Vault encrypts sensitive files.

### Common Vault Commands

```bash
# Create a new encrypted file
ansible-vault create secrets.yml

# Encrypt an existing file
ansible-vault encrypt vars/passwords.yml

# View encrypted file (shows decrypted content)
ansible-vault view secrets.yml

# Edit encrypted file
ansible-vault edit secrets.yml

# Change encryption password
ansible-vault rekey secrets.yml

# Decrypt a file (removes encryption)
ansible-vault decrypt secrets.yml

# Encrypt a single value (for embedding in unencrypted files)
ansible-vault encrypt_string 'my_secret_password' --name 'db_password'
```

### Encrypting a Single String (Inline Vault)

```bash
ansible-vault encrypt_string 'SuperSecret123!' --name 'db_password'
```

Output:
```yaml
db_password: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          38653564313965633537303933323234363831646434...
```

You can paste this directly into any vars file alongside non-secret variables.

### Running Vault-Encrypted Playbooks

```bash
# Prompt for password interactively
ansible-playbook site.yml --ask-vault-pass

# Use a password file (for automation/CI)
echo "my_vault_password" > ~/.vault_pass
chmod 600 ~/.vault_pass
ansible-playbook site.yml --vault-password-file ~/.vault_pass

# In ansible.cfg (set once, forget)
[defaults]
vault_password_file = ~/.vault_pass
```

### Real-World Vault Workflow

```
project/
├── group_vars/
│   └── all/
│       ├── vars.yml          # Regular variables (in Git)
│       └── vault.yml         # Encrypted secrets (in Git, but encrypted)
```

```yaml
# group_vars/all/vars.yml (plaintext — committed to Git)
db_host: 192.168.1.50
db_name: production_db
db_user: app_user
db_password: "{{ vault_db_password }}"   # References vault variable

# group_vars/all/vault.yml (encrypted — committed to Git, but safe)
vault_db_password: SuperSecret123!
vault_api_key: abc123xyz789
```

> 💡 **Best Practice:** Prefix vault variables with `vault_` so you can easily tell which values are sensitive.

---

## 8. Variable Precedence (Full Hierarchy)

When the same variable is defined in multiple places, Ansible uses this hierarchy. **Higher number = higher priority (wins).**

| Priority | Location |
|----------|----------|
| 1 (Lowest) | Role defaults (`defaults/main.yml`) |
| 2 | Inventory group vars |
| 3 | Inventory host vars |
| 4 | `group_vars/all` |
| 5 | `group_vars/<group>` |
| 6 | `host_vars/<host>` |
| 7 | Facts (`ansible_*`) |
| 8 | Playbook `vars` |
| 9 | Task `vars` |
| 10 | `set_fact` / `register` |
| 11 | Role vars (`vars/main.yml`) |
| 12 | Block vars |
| **16 (Highest)** | **Command-line `-e` (extra vars)** |

```bash
# This overrides EVERYTHING — useful for emergency hotfixes
ansible-playbook site.yml -e "app_port=9090 debug_mode=true"

# Override with a file
ansible-playbook site.yml -e @override_vars.yml
```

---

# Chapter 6: Flow Control

---

## 1. Conditionals with `when`

The `when` clause accepts Jinja2 expressions that evaluate to `true` or `false`.

```yaml
# Simple comparison
when: ansible_os_family == "RedHat"

# String contains
when: "'ERROR' in app_result.stdout"

# Variable is defined
when: db_password is defined

# Variable is not defined
when: config_file is not defined

# File exists (using registered stat result)
when: config_stat.stat.exists

# Number comparison
when: ansible_memtotal_mb >= 4096

# Boolean variable
when: ssl_enabled                     # True if ssl_enabled is truthy
when: not maintenance_mode

# Checking if variable is in a list
when: ansible_distribution in ['Ubuntu', 'Debian']
```

### AND Conditions (List Format — Recommended)

```yaml
- name: Install heavy package only on powerful machines
  package:
    name: elasticsearch
    state: present
  when:
    - ansible_memtotal_mb >= 4096
    - ansible_processor_vcpus >= 2
    - ansible_os_family == "RedHat"
```

### OR Conditions

```yaml
when: ansible_distribution == "Ubuntu" or ansible_distribution == "Debian"

# Cleaner version using 'in':
when: ansible_distribution in ['Ubuntu', 'Debian', 'Mint']
```

### Complex Real-World Conditional

```yaml
- name: Enable SELinux only on prod RedHat systems
  selinux:
    policy: targeted
    state: enforcing
  when:
    - ansible_os_family == "RedHat"
    - env == "production"
    - ansible_selinux.status != "disabled"
```

---

## 2. The `register` Keyword — Capturing Task Results

`register` stores a task's output as a variable for later use.

```yaml
- name: Check if service config exists
  stat:
    path: /etc/myapp/config.ini
  register: app_config

- name: Create default config if missing
  copy:
    content: "[defaults]\nport=8080\n"
    dest: /etc/myapp/config.ini
  when: not app_config.stat.exists

- name: Get current app version
  command: /usr/local/bin/myapp --version
  register: version_output
  changed_when: false

- name: Display version
  debug:
    msg: "Running version: {{ version_output.stdout }}"

- name: Upgrade only if version is old
  command: /opt/scripts/upgrade.sh
  when: "'v1.' in version_output.stdout"
```

### Registered Variable Structure

Every registered result has:
```yaml
result.stdout          # Standard output (string)
result.stderr          # Standard error (string)
result.stdout_lines    # stdout split into a list by newlines
result.stderr_lines    # stderr split into a list
result.rc              # Return code (0 = success)
result.changed         # Whether the task changed something
result.failed          # Whether the task failed
result.skipped         # Whether the task was skipped
```

---

## 3. Loops

### A. Basic `loop`

```yaml
# Loop over a simple list
- name: Create multiple directories
  file:
    path: "{{ item }}"
    state: directory
    mode: '0755'
  loop:
    - /opt/app/logs
    - /opt/app/config
    - /opt/app/data
    - /opt/app/tmp

# Loop over a variable (list defined in vars)
- name: Install required packages
  package:
    name: "{{ item }}"
    state: present
  loop: "{{ required_packages }}"
```

### B. Loop Over Dictionaries (Objects)

```yaml
- name: Create users with specific shells
  user:
    name: "{{ item.name }}"
    shell: "{{ item.shell }}"
    groups: "{{ item.groups }}"
  loop:
    - { name: alice, shell: /bin/bash, groups: "developers,wheel" }
    - { name: bob,   shell: /bin/bash, groups: "developers" }
    - { name: ci_bot, shell: /sbin/nologin, groups: "ci" }

# Equivalent with full YAML syntax (easier to read)
  loop:
    - name: alice
      shell: /bin/bash
      groups: "developers,wheel"
    - name: bob
      shell: /bin/bash
      groups: developers
```

### C. Loop with `when` (Conditional Loop)

```yaml
- name: Install packages only on Debian systems
  apt:
    name: "{{ item }}"
    state: present
  loop:
    - nginx
    - php-fpm
    - mysql-client
  when: ansible_os_family == "Debian"
```

### D. Nested Loops (`with_nested` / `loop` + `product`)

```yaml
# Create vhosts for multiple domains × multiple environments
- name: Create nginx vhost directories
  file:
    path: "/var/www/{{ item.0 }}/{{ item.1 }}"
    state: directory
  loop: "{{ ['app1.com', 'app2.com'] | product(['html', 'logs', 'ssl']) | list }}"
```

### E. Loop Over `dict2items`

```yaml
vars:
  firewall_ports:
    http: 80
    https: 443
    app: 8080

tasks:
  - name: Open firewall ports
    firewalld:
      port: "{{ item.value }}/tcp"
      permanent: true
      state: enabled
    loop: "{{ firewall_ports | dict2items }}"
    # item.key = "http", "https", "app"
    # item.value = 80, 443, 8080
```

### F. `loop_control` — Clean Output

```yaml
- name: Process user accounts
  user:
    name: "{{ item.username }}"
    state: "{{ item.state }}"
  loop: "{{ user_accounts }}"   # This might have 50 users with lots of data
  loop_control:
    label: "{{ item.username }}"   # Only print username in output, not entire dict
    pause: 2                        # Wait 2 seconds between iterations
    index_var: idx                  # Track loop index in 'idx' variable

- name: Process item {{ idx + 1 }} of {{ user_accounts | length }}
  debug:
    msg: "Processing user {{ idx + 1 }}: {{ item.username }}"
  loop: "{{ user_accounts }}"
  loop_control:
    index_var: idx
    label: "{{ item.username }}"
```

---

## 4. Tags — Selective Execution

Tags let you run or skip specific parts of a playbook.

```yaml
tasks:
  - name: Install packages
    package:
      name: nginx
      state: present
    tags:
      - install
      - packages

  - name: Configure nginx
    template:
      src: nginx.conf.j2
      dest: /etc/nginx/nginx.conf
    tags:
      - configure
      - nginx

  - name: Start nginx
    service:
      name: nginx
      state: started
    tags:
      - start
      - services
      - never     # 'never' tag = only runs when explicitly requested
```

```bash
# Run only tasks tagged 'install'
ansible-playbook site.yml --tags install

# Run 'install' and 'configure' tasks
ansible-playbook site.yml --tags "install,configure"

# Skip tasks tagged 'services'
ansible-playbook site.yml --skip-tags services

# Run tasks tagged 'never' (emergency restart)
ansible-playbook site.yml --tags never
```

---

# Chapter 7: Error Handling & Resilience

---

## 1. The Default Behavior

By default when a task fails on a host, Ansible:
1. Marks that host as `failed`
2. Stops executing tasks on that host
3. Continues with other hosts in the inventory
4. At the end, reports a non-zero exit code

---

## 2. `ignore_errors` — Non-Critical Tasks

```yaml
- name: Try to clear cache (non-critical)
  command: /usr/bin/clear_cache.sh
  ignore_errors: true

- name: Check application health
  uri:
    url: http://localhost:8080/health
  ignore_errors: true
  register: health_check

- name: Log if health check failed
  debug:
    msg: "⚠️ Health check failed, but continuing..."
  when: health_check.failed
```

> ⚠️ **When NOT to use `ignore_errors`:** Don't ignore errors on security tasks, file permissions setup, or anything that later tasks depend on.

---

## 3. `failed_when` — Custom Failure Logic

```yaml
# Fail if output contains a specific error string
- name: Run application tests
  command: /opt/app/run_tests.sh
  register: test_results
  failed_when:
    - test_results.rc != 0
    - "'CRITICAL' in test_results.stdout"

# Fail if too many errors (not just any errors)
- name: Check error count
  shell: grep -c "ERROR" /var/log/app.log
  register: error_count
  failed_when: error_count.stdout | int > 50
  changed_when: false

# Fail if disk usage is too high
- name: Check disk usage
  shell: df / | awk 'NR==2 {print $5}' | tr -d '%'
  register: disk_usage
  failed_when: disk_usage.stdout | int > 90
  changed_when: false
```

---

## 4. `changed_when` — Fixing False Change Reports

```yaml
# Read-only commands should never report 'changed'
- name: Get service status
  command: systemctl status nginx
  register: nginx_status
  changed_when: false      # This task never modifies anything

# Mark as changed only when actual change occurred
- name: Run database migration
  command: /opt/app/migrate.sh
  register: migration
  changed_when: "'Applied' in migration.stdout"   # Only changed if migration ran
```

---

## 5. Block / Rescue / Always — Try-Except-Finally

This is the most professional error handling pattern.

```yaml
- name: Database Deployment
  hosts: db
  tasks:

    - name: Take backup before deployment
      block:

        - name: Create backup directory
          file:
            path: /backups/{{ ansible_date_time.date }}
            state: directory

        - name: Dump database
          mysql_db:
            name: production_db
            state: dump
            target: "/backups/{{ ansible_date_time.date }}/prod.sql"

        - name: Deploy new schema
          mysql_db:
            name: production_db
            state: import
            target: /opt/app/schema_v2.sql

        - name: Run data migration script
          command: /opt/app/migrate_data.sh
          register: migration
          failed_when: migration.rc != 0

      rescue:
        # These tasks run ONLY if something in 'block' failed
        - name: Alert the team
          mail:
            to: team@company.com
            subject: "🚨 DB Migration FAILED on {{ inventory_hostname }}"
            body: "Migration failed. Manual intervention required."

        - name: Restore from backup
          mysql_db:
            name: production_db
            state: import
            target: "/backups/{{ ansible_date_time.date }}/prod.sql"

        - name: Mark migration as failed
          fail:
            msg: "Migration failed and was rolled back. Check logs."

      always:
        # These tasks ALWAYS run — success or failure
        - name: Remove temporary files
          file:
            path: /tmp/migration_temp
            state: absent

        - name: Log result to audit file
          lineinfile:
            path: /var/log/ansible_audit.log
            line: "{{ ansible_date_time.iso8601 }} — Migration {{ 'succeeded' if not ansible_failed_task is defined else 'FAILED' }}"
```

---

## 6. Retry with `until`

```yaml
# Wait for a service to be ready (with retries)
- name: Wait for API to be available
  uri:
    url: http://localhost:8080/api/health
    status_code: 200
  register: api_health
  until: api_health.status == 200
  retries: 10        # Try up to 10 times
  delay: 15          # Wait 15 seconds between each try
  # Total max wait = 10 × 15 = 150 seconds

# Wait for a file to appear
- name: Wait for install to finish
  wait_for:
    path: /opt/app/.install_complete
    state: present
    timeout: 300      # Wait up to 5 minutes

# Wait for a port to open
- name: Wait for MySQL to start
  wait_for:
    host: 127.0.0.1
    port: 3306
    delay: 5
    timeout: 60
```

---

## 7. `any_errors_fatal` — Stop Everything on Any Failure

```yaml
- name: Critical Deployment
  hosts: all
  any_errors_fatal: true    # If ANY host fails, stop ALL hosts immediately
  tasks:
    - name: Critical database migration
      command: /opt/migrate.sh
```

This is useful when tasks have dependencies — if one host fails, continuing on others would cause inconsistency.

---

## 8. Resilience Toolbox Summary

| Tool | Problem It Solves |
|------|------------------|
| `ignore_errors` | Non-critical task failures |
| `failed_when` | Command returns wrong exit code, custom failure criteria |
| `changed_when` | Read-only commands falsely reporting `changed` |
| `block/rescue` | Complex error recovery (like try-except) |
| `block/always` | Cleanup that must run regardless (like finally) |
| `until/retries` | Flaky networks, slow services starting up |
| `any_errors_fatal` | All-or-nothing deployments |
| `force_handlers` | Ensure services restart even if play fails midway |

---

# Chapter 8: Templating with Jinja2

---

## 1. What is Jinja2 Templating?

The `template` module processes `.j2` files — it replaces all `{{ variables }}` and `{% logic %}` blocks with actual values, then copies the result to the managed node.

```
Control Node                     Managed Node
nginx.conf.j2 (template)   →    nginx.conf (final config)
  worker_processes {{ vcpus }}      worker_processes 4
  listen {{ http_port }};           listen 80;
```

---

## 2. Template vs. Copy Module

```yaml
# copy = static file, no processing
- copy:
    src: robots.txt
    dest: /var/www/html/robots.txt

# template = dynamic file, variables are replaced
- template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
    owner: root
    group: root
    mode: '0644'
    validate: /usr/sbin/nginx -t -c %s    # Validate BEFORE overwriting!
    backup: true                            # Keep backup of old file
```

---

## 3. Variables in Templates

```jinja
{# motd.j2 — Message of the Day #}
{# Note: {# ... #} are Jinja2 comments — not rendered in final file #}

==============================================
  Welcome to {{ ansible_hostname | upper }}
==============================================
OS:        {{ ansible_distribution }} {{ ansible_distribution_version }}
IP:        {{ ansible_default_ipv4.address }}
CPU Cores: {{ ansible_processor_vcpus }}
RAM:       {{ (ansible_memtotal_mb / 1024) | round(1) }} GB
Env:       {{ environment | default('unknown') | upper }}

⚠️  {{ ansible_managed }}
     Any manual changes to this file will be overwritten!
==============================================
```

---

## 4. Conditionals in Templates

```jinja
{# app_config.j2 #}
[server]
host = {{ ansible_default_ipv4.address }}
port = {{ app_port }}

{% if environment == "production" %}
[logging]
level = ERROR
file = /var/log/{{ app_name }}/app.log
max_size = 100MB
retention_days = 90

[security]
ssl_enabled = true
ssl_cert = /etc/ssl/certs/{{ app_name }}.crt
ssl_key = /etc/ssl/private/{{ app_name }}.key

{% elif environment == "staging" %}
[logging]
level = WARNING
file = /var/log/{{ app_name }}/app.log
max_size = 50MB
retention_days = 30

{% else %}
[logging]
level = DEBUG
file = /tmp/{{ app_name }}_debug.log
max_size = 10MB

[debug]
enable_profiling = true
verbose_sql = true

{% endif %}
```

---

## 5. Loops in Templates

### Example: Nginx Upstream Config

```jinja
{# nginx_upstream.j2 #}
upstream {{ app_name }}_backend {
    # Load balancing method
    least_conn;

{% for server in groups['web'] %}
    server {{ hostvars[server]['ansible_default_ipv4']['address'] }}:{{ app_port }} weight=1;
{% endfor %}

    keepalive 32;
}

server {
    listen 80;
    server_name {{ server_name }};

    location / {
        proxy_pass http://{{ app_name }}_backend;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

### Example: `/etc/hosts` File

```jinja
{# hosts_file.j2 #}
127.0.0.1   localhost
::1         localhost

# Managed servers
{% for host in groups['all'] %}
{{ hostvars[host]['ansible_default_ipv4']['address'] }}  {{ hostvars[host]['ansible_hostname'] }}
{% endfor %}
```

### Example: SSH `authorized_keys`

```jinja
{# authorized_keys.j2 #}
{% for key in ssh_authorized_keys %}
{{ key }}
{% endfor %}
```

---

## 6. Advanced Jinja2 Techniques

### Whitespace Control

```jinja
{# Without control — adds blank lines #}
{% for item in list %}
{{ item }}
{% endfor %}

{# With whitespace control (dash removes newlines) #}
{%- for item in list -%}
{{ item }}
{%- endfor -%}
```

### Checking if Variable is Defined

```jinja
{% if custom_port is defined %}
port={{ custom_port }}
{% else %}
port=8080
{% endif %}

{# One-liner version #}
port={{ custom_port | default(8080) }}
```

### Loop Variables

Inside a Jinja2 `for` loop, you have access to special variables:

```jinja
{% for server in backend_servers %}
    server {{ server }};    {# loop.index = 1,2,3... #}
                            {# loop.index0 = 0,1,2... (zero-based) #}
                            {# loop.first = true on first iteration #}
                            {# loop.last = true on last iteration #}
                            {# loop.length = total count #}
{% if not loop.last %},{% endif %}
{% endfor %}
```

---

## 7. Filters Reference

```jinja
{# String filters #}
{{ name | upper }}              → "JOHN"
{{ name | lower }}              → "john"
{{ name | title }}              → "John Doe"
{{ name | trim }}               → removes whitespace
{{ name | replace('a', 'b') }}  → replaces characters

{# Number filters #}
{{ 3.14159 | round(2) }}        → 3.14
{{ "42" | int }}                → 42
{{ "3.14" | float }}            → 3.14

{# List filters #}
{{ list | length }}             → count
{{ list | join(', ') }}         → "a, b, c"
{{ list | sort }}               → sorted list
{{ list | reverse | list }}     → reversed
{{ list | unique }}             → deduplicated
{{ list | select('match', '^web') | list }}  → filter by regex
{{ list | map('upper') | list }}             → apply filter to each item

{# Dict filters #}
{{ mydict | dict2items }}       → [{key: k, value: v}, ...]
{{ items | items2dict }}        → {k: v, ...}
{{ mydict | combine(other) }}   → merge two dicts

{# Path filters #}
{{ path | basename }}           → filename only
{{ path | dirname }}            → directory only
{{ path | realpath }}           → absolute path

{# Type checking #}
{{ var | type_debug }}          → type name
{{ var is string }}             → true/false
{{ var is number }}             → true/false
{{ var is iterable }}           → true/false
```

---

# Chapter 9: Ansible Roles

---

## 1. Why Roles?

As projects grow, a single `site.yml` becomes unmanageable. Roles solve this by providing a **standardized file structure** for organizing related automation.

**Without roles (messy):**
```
project/
├── site.yml          # 500+ line monster file
├── vars.yml
└── handlers.yml
```

**With roles (organized):**
```
project/
├── site.yml          # Clean, 20-line orchestrator
└── roles/
    ├── common/       # Basic system setup
    ├── nginx/        # Web server
    ├── mysql/        # Database
    └── app/          # Application deployment
```

---

## 2. The Standard Role Structure

```
roles/nginx/
├── tasks/
│   ├── main.yml          # Entry point — imported automatically
│   ├── install.yml       # Installation tasks
│   └── configure.yml     # Configuration tasks
├── handlers/
│   └── main.yml          # Service restart handlers
├── defaults/
│   └── main.yml          # Default variables (low priority, user can override)
├── vars/
│   └── main.yml          # Internal variables (high priority, user should NOT change)
├── files/
│   ├── nginx.conf        # Static files (used by copy module)
│   └── ssl_params.conf
├── templates/
│   ├── vhost.conf.j2     # Dynamic templates (used by template module)
│   └── nginx.conf.j2
├── meta/
│   └── main.yml          # Dependencies, author info, Galaxy metadata
└── README.md             # Usage documentation
```

---

## 3. Building a Real Role — nginx Example

```bash
# Initialize role structure
ansible-galaxy init roles/nginx
```

```yaml
# roles/nginx/defaults/main.yml
nginx_port: 80
nginx_worker_processes: auto
nginx_worker_connections: 1024
nginx_user: nginx
nginx_log_dir: /var/log/nginx
nginx_vhosts: []           # Empty by default — user provides vhosts
```

```yaml
# roles/nginx/vars/main.yml
# These are OS-specific internals — users shouldn't change these
_nginx_packages:
  RedHat: nginx
  Debian: nginx

_nginx_config_dir:
  RedHat: /etc/nginx
  Debian: /etc/nginx

nginx_package: "{{ _nginx_packages[ansible_os_family] }}"
nginx_config_dir: "{{ _nginx_config_dir[ansible_os_family] }}"
```

```yaml
# roles/nginx/tasks/main.yml
---
- name: Import OS-specific variables
  include_vars: "{{ ansible_os_family }}.yml"
  failed_when: false

- import_tasks: install.yml
  tags: [nginx, install]

- import_tasks: configure.yml
  tags: [nginx, configure]

- import_tasks: vhosts.yml
  tags: [nginx, vhosts]
  when: nginx_vhosts | length > 0
```

```yaml
# roles/nginx/tasks/install.yml
---
- name: Install nginx
  package:
    name: "{{ nginx_package }}"
    state: present

- name: Create nginx log directory
  file:
    path: "{{ nginx_log_dir }}"
    state: directory
    owner: "{{ nginx_user }}"
    mode: '0755'
```

```yaml
# roles/nginx/tasks/configure.yml
---
- name: Deploy nginx main config
  template:
    src: nginx.conf.j2
    dest: "{{ nginx_config_dir }}/nginx.conf"
    owner: root
    mode: '0644'
    validate: /usr/sbin/nginx -t -c %s
  notify: Restart nginx
```

```yaml
# roles/nginx/handlers/main.yml
---
- name: Restart nginx
  service:
    name: nginx
    state: restarted

- name: Reload nginx
  service:
    name: nginx
    state: reloaded
```

```yaml
# roles/nginx/meta/main.yml
galaxy_info:
  author: "your_name"
  description: "Nginx web server role"
  license: MIT
  min_ansible_version: "2.9"
  platforms:
    - name: EL        # Enterprise Linux (RHEL/CentOS)
      versions: [7, 8, 9]
    - name: Ubuntu
      versions: [20, 22]

dependencies:
  - role: common      # Always run common role first
```

---

## 4. Using Roles in Playbooks

```yaml
# site.yml
---
- name: Configure all servers
  hosts: all
  roles:
    - common              # Shorthand syntax

- name: Configure web servers
  hosts: web
  roles:
    - role: nginx         # Full syntax
      vars:
        nginx_port: 80    # Override role defaults for this play
        nginx_vhosts:
          - name: myapp
            server_name: myapp.example.com
            document_root: /var/www/myapp

- name: Configure database servers
  hosts: db
  roles:
    - role: mysql
      vars:
        mysql_root_password: "{{ vault_mysql_root_password }}"
        mysql_databases:
          - name: production_db
            encoding: utf8mb4

- name: Deploy application
  hosts: web
  roles:
    - role: app
      tags: deploy          # Tags apply to entire role
```

---

## 5. `include_role` vs `import_role`

```yaml
# import_role — static (processed at playbook parse time)
# Tags and conditionals on the import apply to all tasks inside
- import_role:
    name: nginx
  tags: web_setup

# include_role — dynamic (processed at execution time)
# Can use variables for role name — good for conditional role execution
- include_role:
    name: "{{ 'nginx' if web_server == 'nginx' else 'apache' }}"

- include_role:
    name: security_hardening
  when: env == "production"
```

---

## 6. Ansible Galaxy — Community Roles

```bash
# Search for roles
ansible-galaxy search nginx

# Install a highly-rated role
ansible-galaxy install geerlingguy.nginx

# Install specific version
ansible-galaxy install geerlingguy.mysql,3.3.0

# Install from requirements file (best practice for teams)
ansible-galaxy install -r requirements.yml
```

```yaml
# requirements.yml — pin versions for reproducibility
---
roles:
  - name: geerlingguy.nginx
    version: 3.2.0
  - name: geerlingguy.mysql
    version: 4.3.2
  - name: my_company.internal_role   # From private Galaxy
    src: https://git.mycompany.com/ansible/internal_role
    version: main

collections:
  - name: community.mysql
    version: ">=3.0.0"
  - name: amazon.aws
    version: "5.0.0"
```

```bash
# Install everything in requirements.yml
ansible-galaxy install -r requirements.yml --roles-path ./roles
```

---

# Chapter 10: Advanced Execution (Strategy & Async)

---

## 1. Execution Strategies

### `linear` (Default)

All hosts must finish Task N before any host starts Task N+1.

```
Task 1: [web01 ✓] [web02 ✓] [web03 ✓]  → All done
Task 2: [web01 ✓] [web02 ✓] [web03 ✓]  → All done
Task 3: ...
```

**Problem:** If web03 is slow, web01 and web02 wait idle.

### `free`

Each host runs at its own pace, independent of others.

```
web01: Task1 → Task2 → Task3 → Task4 → Done ✓
web02: Task1 → Task2 → Task3 (slow...) → Task4 → Done ✓
web03: Task1 → Task2 → Task3 → Task4 → Done ✓
```

```yaml
- name: Mass package updates
  hosts: all
  strategy: free
  tasks:
    - package:
        name: "*"
        state: latest
```

### `host_pinned` Strategy (Advanced)

A compromise: each worker thread stays on one host until that host's play is complete, then picks up the next host. Reduces context switching.

---

## 2. Rolling Updates with `serial`

The `serial` keyword is one of Ansible's most powerful production features.

```yaml
- name: Rolling Web Server Update
  hosts: web
  serial: 2          # Process 2 servers at a time (no service interruption)
  max_fail_percentage: 30    # Abort if >30% of hosts fail
  tasks:
    - name: Remove from load balancer
      uri:
        url: "http://lb.internal/api/remove/{{ inventory_hostname }}"
        method: POST

    - name: Update application
      git:
        repo: https://github.com/myorg/myapp.git
        dest: /opt/app
        version: "{{ deploy_version }}"

    - name: Restart application
      service:
        name: myapp
        state: restarted

    - name: Health check
      uri:
        url: "http://{{ inventory_hostname }}:8080/health"
        status_code: 200
      retries: 5
      delay: 10

    - name: Re-add to load balancer
      uri:
        url: "http://lb.internal/api/add/{{ inventory_hostname }}"
        method: POST
```

### Percentage-Based Serial

```yaml
serial:
  - 1              # Start with 1 server (canary)
  - 20%            # Then 20% of remaining
  - 50%            # Then 50%
  - 100%           # Then everything else
```

---

## 3. Async & Poll — Long-Running Tasks

```yaml
# Start a long task in background and check later
- name: Start long database backup
  command: /opt/scripts/backup_all.sh
  async: 7200      # Allow 2 hours max
  poll: 0          # Fire and forget — don't wait
  register: backup_job

- name: Do other things while backup runs
  debug:
    msg: "Backup started with job ID: {{ backup_job.ansible_job_id }}"

# ... other tasks ...

# Come back and check the backup status
- name: Check backup status
  async_status:
    jid: "{{ backup_job.ansible_job_id }}"
  register: job_result
  until: job_result.finished
  retries: 60
  delay: 120       # Check every 2 minutes
```

### Poll-Based Long Tasks (Simpler)

```yaml
# If you want to wait but not block the SSH connection
- name: Run system updates
  yum:
    name: "*"
    state: latest
  async: 3600       # Allow 1 hour
  poll: 30          # Check every 30 seconds
```

---

## 4. Forks & Throttle

```bash
# Global parallel connections
ansible-playbook site.yml -f 20   # 20 simultaneous hosts

# In ansible.cfg
[defaults]
forks = 20
```

```yaml
# Per-task throttle (rate limiting)
- name: Deploy to servers (max 5 at a time to protect DB)
  copy:
    src: app.war
    dest: /opt/tomcat/webapps/
  throttle: 5    # Even if forks=50, only 5 hosts run this task simultaneously
```

---

## 5. Delegation — Run Tasks Elsewhere

```yaml
# Run a task on a DIFFERENT host (not the current target)
- name: Add server to monitoring
  uri:
    url: "https://monitoring.internal/api/hosts"
    method: POST
    body: '{"host": "{{ inventory_hostname }}", "ip": "{{ ansible_default_ipv4.address }}"}'
  delegate_to: monitoring_server    # Run this on monitoring server, not web servers
  run_once: true                    # But only run it once total

# Classic use case: take server out of load balancer FROM the load balancer
- name: Remove from load balancer rotation
  command: "haproxy_disable_server.sh {{ inventory_hostname }}"
  delegate_to: "{{ groups['lb'][0] }}"  # Run on the first load balancer
```

---

# Chapter 11: Dynamic Inventory & Lookups

---

## 1. Dynamic Inventory — Cloud Environments

### AWS EC2 Plugin Setup

```bash
# Install required boto3 library
pip3 install boto3

# Set AWS credentials
export AWS_ACCESS_KEY_ID="your_key"
export AWS_SECRET_ACCESS_KEY="your_secret"
export AWS_DEFAULT_REGION="us-east-1"
```

```yaml
# aws_inventory.aws_ec2.yml
plugin: aws_ec2
regions:
  - us-east-1
  - us-west-2

filters:
  instance-state-name: running   # Only running instances
  "tag:Managed": ansible         # Only instances tagged Managed=ansible

keyed_groups:
  - key: tags.Role               # Group by Role tag
    prefix: role
    separator: "_"
  - key: tags.Environment
    prefix: env
  - key: placement.region
    prefix: region
  - key: instance_type
    prefix: type

hostnames:
  - tag:Name                     # Use Name tag as hostname
  - private-ip-address           # Fallback to private IP

compose:
  ansible_host: private_ip_address   # Connect via private IP
  ansible_user: "'ubuntu' if 'Ubuntu' in tags.OS else 'ec2-user'"
```

```bash
# Test your dynamic inventory
ansible-inventory -i aws_inventory.aws_ec2.yml --graph
ansible-inventory -i aws_inventory.aws_ec2.yml --list

# Use it
ansible-playbook -i aws_inventory.aws_ec2.yml deploy.yml
```

---

## 2. Inventory Caching (Performance)

```ini
# ansible.cfg
[inventory]
cache = true
cache_plugin = jsonfile
cache_connection = /tmp/ansible_inv_cache
cache_timeout = 300             # 5 minutes
```

```bash
# Force refresh (bypass cache)
ansible-inventory -i aws_inventory.aws_ec2.yml --list --flush-cache
```

---

## 3. Lookups — External Data Sources

Lookups run on the **Control Node** and fetch data at task execution time.

```yaml
# Read a local file
vars:
  ssh_public_key: "{{ lookup('file', '~/.ssh/id_rsa.pub') }}"
  license_key: "{{ lookup('file', '/etc/license.key') | trim }}"

# Get environment variable
vars:
  db_password: "{{ lookup('env', 'DB_PASSWORD') }}"
  build_number: "{{ lookup('env', 'CI_BUILD_NUMBER') | default('unknown') }}"

# Generate a random password and save it
vars:
  new_password: "{{ lookup('password', '/tmp/newpass.txt length=20 chars=ascii_letters,digits') }}"
  # First run: generates and saves password
  # Subsequent runs: reads the saved password (idempotent!)

# Fetch from a URL (for config from an API)
vars:
  remote_config: "{{ lookup('url', 'https://config.internal/api/app-settings') }}"

# Run a local command
vars:
  git_commit: "{{ lookup('pipe', 'git rev-parse --short HEAD') }}"
  timestamp: "{{ lookup('pipe', 'date +%Y%m%d%H%M%S') }}"

# Read CSV file
vars:
  user_data: "{{ lookup('csvfile', 'alice file=users.csv delimiter=, col=1') }}"
```

---

## 4. Secret Management with Lookups

```yaml
# HashiCorp Vault integration
- name: Configure database
  mysql_user:
    name: app_user
    password: "{{ lookup('hashi_vault', 'secret=secret/prod/db:password') }}"
    host: "{{ lookup('hashi_vault', 'secret=secret/prod/db:host') }}"

# AWS Secrets Manager
- name: Get RDS password from AWS
  set_fact:
    rds_password: "{{ lookup('amazon.aws.aws_secret', 'prod/rds/password') }}"

# Azure Key Vault
- name: Get secret from Azure
  set_fact:
    api_key: "{{ lookup('azure.azcollection.azure_keyvault_secret', 'my-secret', vault_url='https://myvault.vault.azure.net') }}"
```

---

## 5. `query()` vs `lookup()`

```yaml
# lookup() returns a comma-separated string for multiple results
"{{ lookup('fileglob', '/etc/*.conf') }}"  # "/etc/ssh.conf,/etc/nginx.conf"

# query() always returns a list (preferred for loops)
- name: Process all config files
  debug:
    msg: "Found: {{ item }}"
  loop: "{{ query('fileglob', '/etc/*.conf') }}"
```

---

# Chapter 12: Developing Custom Modules

---

## 1. When to Write a Custom Module

Write a custom module when:
- No existing module handles your use case
- You need idempotency that `shell`/`command` can't provide
- You're wrapping a proprietary API or CLI tool
- You want clean, structured output for `register`

---

## 2. The Full Module Template

```python
#!/usr/bin/python
# -*- coding: utf-8 -*-

DOCUMENTATION = r'''
---
module: manage_app_config
short_description: Manage MyApp configuration entries
description:
  - Creates, updates, or removes configuration entries in MyApp's config API.
options:
  key:
    description: Configuration key name
    required: true
    type: str
  value:
    description: Configuration value
    required: false
    type: str
  state:
    description: Whether the config should exist
    required: false
    default: present
    choices: ['present', 'absent']
author:
  - Your Name (@github_handle)
'''

EXAMPLES = r'''
- name: Set database host
  manage_app_config:
    key: database_host
    value: "192.168.1.50"
    state: present

- name: Remove deprecated setting
  manage_app_config:
    key: old_setting
    state: absent
'''

RETURN = r'''
config_value:
  description: The configuration value after the operation
  type: str
  returned: when state=present
  sample: "192.168.1.50"
previous_value:
  description: The previous value before any changes
  type: str
  returned: always
'''

# --- Module Logic ---
from ansible.module_utils.basic import AnsibleModule
import subprocess
import json


def get_current_value(key):
    """Get the current config value. Returns None if not set."""
    try:
        result = subprocess.run(
            ['/usr/bin/myapp', 'config', 'get', key],
            capture_output=True, text=True
        )
        if result.returncode == 0:
            return result.stdout.strip()
        return None
    except FileNotFoundError:
        return None


def set_value(key, value):
    """Set a config value. Returns (success, error_message)."""
    result = subprocess.run(
        ['/usr/bin/myapp', 'config', 'set', key, value],
        capture_output=True, text=True
    )
    return result.returncode == 0, result.stderr


def remove_value(key):
    """Remove a config entry."""
    result = subprocess.run(
        ['/usr/bin/myapp', 'config', 'remove', key],
        capture_output=True, text=True
    )
    return result.returncode == 0, result.stderr


def run_module():
    # Define accepted parameters
    module_args = dict(
        key=dict(type='str', required=True),
        value=dict(type='str', required=False, default=None),
        state=dict(type='str', default='present', choices=['present', 'absent'])
    )

    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True     # Support --check (dry run)
    )

    # Extract parameters
    key = module.params['key']
    value = module.params['value']
    state = module.params['state']

    # Validate: value required when state=present
    if state == 'present' and value is None:
        module.fail_json(msg="'value' is required when state=present")

    # Get current state
    current_value = get_current_value(key)

    result = dict(
        changed=False,
        previous_value=current_value,
    )

    # Determine if we need to make changes
    if state == 'present':
        if current_value == value:
            # Already correct — nothing to do (idempotent!)
            result['config_value'] = value
            module.exit_json(**result)
        else:
            # Need to update
            if module.check_mode:
                # Dry run — report what WOULD happen
                result['changed'] = True
                result['config_value'] = value
                module.exit_json(**result)

            success, error = set_value(key, value)
            if not success:
                module.fail_json(msg=f"Failed to set {key}: {error}")

            result['changed'] = True
            result['config_value'] = value

    elif state == 'absent':
        if current_value is None:
            # Already absent — nothing to do
            module.exit_json(**result)
        else:
            if module.check_mode:
                result['changed'] = True
                module.exit_json(**result)

            success, error = remove_value(key)
            if not success:
                module.fail_json(msg=f"Failed to remove {key}: {error}")

            result['changed'] = True

    module.exit_json(**result)


if __name__ == '__main__':
    run_module()
```

---

## 3. Where to Store Custom Modules

```
project/
├── library/
│   ├── manage_app_config.py   # Available to all playbooks here
│   └── check_license.py
├── roles/
│   └── myapp/
│       └── library/
│           └── myapp_helper.py  # Only available within this role
└── site.yml
```

```ini
# ansible.cfg — global path for custom modules
[defaults]
library = ./library:/opt/company/ansible_modules
```

---

## 4. Testing Custom Modules

```bash
# Test directly from command line
echo '{"ANSIBLE_MODULE_ARGS": {"key": "db_host", "value": "192.168.1.50", "state": "present"}}' \
  | python3 library/manage_app_config.py

# Test with Ansible (most realistic)
ansible localhost -m manage_app_config -a "key=db_host value=192.168.1.50"

# Use ansible-test for full testing (in a collection)
ansible-test units --python 3.9
ansible-test sanity
```

---

## 5. Module Development Checklist

- [ ] Define all arguments in `argument_spec` with types and defaults
- [ ] Add `supports_check_mode=True` and handle `module.check_mode`
- [ ] Check current state BEFORE making changes (idempotency)
- [ ] Only set `changed=True` if you actually made a change
- [ ] Use `module.fail_json(msg="clear error")` for all failure paths
- [ ] Add `DOCUMENTATION`, `EXAMPLES`, and `RETURN` blocks
- [ ] Test idempotency: run twice, second run should show `changed=false`
- [ ] Test check mode: run with `--check`, nothing should actually change

---

## Appendix: Quick Reference

### Most Used Ad-Hoc Commands

```bash
ansible all -m ping
ansible all -m setup -a "filter=ansible_distribution*"
ansible web -m shell -a "df -h" --become
ansible db -m service -a "name=mysql state=restarted" --become
ansible all -m command -a "uptime"
ansible-inventory --graph
ansible-inventory --list
```

### Most Used `ansible-playbook` Flags

```bash
ansible-playbook site.yml --check --diff    # Dry run with diffs
ansible-playbook site.yml --tags install    # Run tagged tasks
ansible-playbook site.yml --limit web01     # Limit to one host
ansible-playbook site.yml -e "env=prod"     # Extra vars
ansible-playbook site.yml --start-at-task "Configure nginx"
ansible-playbook site.yml -v / -vv / -vvv  # Verbosity
```

### `ansible.cfg` Template

```ini
[defaults]
inventory           = ./inventory
remote_user         = ansible
private_key_file    = ~/.ssh/ansible_key
host_key_checking   = False           # Lab only
forks               = 10
timeout             = 30
stdout_callback     = yaml            # Prettier output
callbacks_enabled   = profile_tasks   # Show task execution times
fact_caching        = jsonfile
fact_caching_connection = /tmp/facts_cache
fact_caching_timeout = 3600

[privilege_escalation]
become              = True
become_method       = sudo
become_user         = root

[ssh_connection]
pipelining          = True            # Speeds up execution
ssh_args            = -o ControlMaster=auto -o ControlPersist=60s
```

### Variable Precedence (Quick Ref)

```
Command-line -e          ← HIGHEST PRIORITY (always wins)
Task vars
set_fact / register
Role vars/main.yml
Playbook vars
host_vars/<host>
group_vars/<group>
group_vars/all
Inventory host vars
Inventory group vars
Role defaults/main.yml   ← LOWEST PRIORITY (easiest to override)
```