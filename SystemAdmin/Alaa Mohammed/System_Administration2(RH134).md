# Automating Linux Installations with Kickstart 

## Introduction to Red Hat System Administration II

**Course Code:** RH134  
**Objective:** Prepare for the RHCSA certification by mastering advanced system administration tasks, including fully automated Linux installations using Kickstart.

### Key Topics Covered:
1. **Kickstart Fundamentals**
2. **Creating a Kickstart File**
3. **Deploying with Kickstart**
4. **Advanced Configuration**
5. **Validation & Troubleshooting**
6. **Best Practices and Next Steps**

---

## Kickstart Fundamentals

### What is Kickstart?
Kickstart is a tool that automates Linux installations by using a configuration file (typically named `ks.cfg` or similar) that contains pre-defined answers to installation prompts. This method enables:
- **Full Automation:** No user intervention is required during installation.
- **Semi-Automated Installations:** Combines automation with occasional manual input.
- **Repeatability:** Easily replicate the same system configuration across multiple machines.

### Why Use Kickstart?
- **Efficiency:** Rapidly deploy multiple systems with identical configurations.
- **Consistency:** Standardizes installations across environments.
- **Error Reduction:** Minimizes human error by pre-configuring responses.
- **Scalability:** Ideal for enterprise environments and large-scale deployments.

---

## Creating a Kickstart File

### Step 1: Generate the Kickstart File via a Web-Based Configurator
Start by using the [Kickstart Configurator](https://access.redhat.com/labs/kickstartconfig/) to create your custom Kickstart file. This tool allows you to:
- Define disk partitioning schemes.
- Configure network settings.
- Select packages and installation options.
- Download the generated file, typically saved as `kickstart.cfg`.

### Step 2: Prepare a Baseline (Optional)
For more complex environments, you might perform a manual installation on a virtual machine to generate an initial Kickstart file, which you can then refine. For example:

```bash
qemu-img create -f qcow2 /var/lib/libvirt/images/rhel9-ks.qcow2 20G
virt-install --name=rhel9-ks --vcpus=2 --memory=4096 \
  --disk path=/var/lib/libvirt/images/rhel9-ks.qcow2 \
  --os-variant=rhel9.0 --location=/iso/RHEL9.iso
```

**Explanation:**
- **qemu-img create:** Creates a 20GB disk image.
- **virt-install:** Initiates a VM installation with defined CPU, memory, and disk parameters.

After the installation, copy the generated Kickstart file for further customization:

```bash
cp /root/anaconda-ks.cfg /var/www/html/ks-rhel9.cfg
chmod 644 /var/www/html/ks-rhel9.cfg
```

---

## Sample Kickstart File Structure

Below is an example of a Kickstart file tailored for RHEL installations:

```kickstart
# Kickstart Configuration for RHEL9 Servers

# Installation Method: Use network installation from a URL
install
url --url="http://192.168.1.100/rhel9/"

# Localization Settings
lang en_US.UTF-8
keyboard us
timezone Asia/Riyadh --utc

# Disk Partitioning
clearpart --all --initlabel
autopart

# Root Password (plaintext for demonstration; use encrypted passwords in production)
rootpw --plaintext P@ssw0rd123

# System Reboot after installation
reboot

%packages
@core
vim-enhanced
nginx

%post
# Update system packages and enable services post-installation
dnf update -y
systemctl enable nginx
firewall-cmd --permanent --add-service=http
firewall-cmd --reload
```

**Explanation:**
- **Installation Directive:** Installs from a network URL.
- **Localization:** Sets language, keyboard, and timezone.
- **Disk Configuration:** Automatically clears partitions and configures disks.
- **Package Selection:** Installs core packages along with additional tools like Nginx.
- **Post-Installation Scripting:** Performs updates and service configuration.

---

## Deploying with Kickstart

Kickstart installations can be deployed in multiple ways. Here, we detail two common methods: HTTP-based deployment and Boot ISO integration.

### Method 1: HTTP-Based Deployment Using Nginx

1. **Set Up a Web Server with Nginx:**

   Install and configure Nginx on your machine to serve the Kickstart file:
   
   ```bash
   # For Debian/Ubuntu:
   sudo apt-get update
   sudo apt-get install nginx

   # For RHEL/CentOS:
   sudo yum install nginx
   ```

2. **Place the Kickstart File in the Document Root:**

   Copy your Kickstart file to Nginx's web directory:
   
   ```bash
   sudo cp ks-rhel9.cfg /var/www/html/
   ```
   
   Verify that the file is accessible by visiting:
   
   ```
   http://192.168.64.128/ks-rhel9.cfg
   ```

3. **Initiate the Installation via Boot Parameters:**

   During system boot, specify the location of the Kickstart file:
   
   ```bash
   linux inst.ks=http://192.168.64.128/ks-rhel9.cfg
   ```

   **Explanation:** This parameter directs the installer to download and use the Kickstart file from your web server.

### Method 2: Boot ISO Integration

1. **Modify the GRUB Configuration on the Boot ISO:**

   Update the boot loader configuration within the ISO image to include a menu entry that points to your Kickstart file:
   
   ```grub
   menuentry 'Automated RHEL Install' {
     linuxefi /images/pxeboot/vmlinuz inst.ks=http://192.168.64.128/ks-rhel9.cfg
     initrdefi /images/pxeboot/initrd.img
   }
   ```

   **Explanation:** This GRUB menu entry will automatically use the specified Kickstart file during boot, streamlining the installation process.

2. **Rebuild the ISO (if necessary):**

   After modifying the GRUB configuration, rebuild the ISO to include the changes. Tools like `mkisofs` or `xorriso` can be used for this purpose.

---

## Advanced Configuration

### Custom Disk Partitioning Strategies

For environments that require custom disk layouts, modify the partitioning section in your Kickstart file:

```kickstart
clearpart --all --drives=sda
part /boot --fstype=ext4 --size=1024
part pv.01 --size=8192 --grow
volgroup vg_root pv.01
logvol / --fstype=xfs --vgname=vg_root --size=4096 --name=lv_root
logvol swap --vgname=vg_root --size=2048 --name=lv_swap
```

**Explanation:**
- **clearpart:** Erases all partitions on the specified drive.
- **Partition Definitions:** Creates a dedicated `/boot` partition and configures LVM for the root and swap areas.

### Network Configuration

For a static network setup, include the following in your Kickstart file:

```kickstart
network --device=eth0 --bootproto=static --ip=192.168.1.50 --netmask=255.255.255.0 --gateway=192.168.1.1 --nameserver=8.8.8.8
```

**Explanation:**
- **Static IP Assignment:** Ensures the machine has a consistent network identity, crucial for server deployments.

---

## Validation & Troubleshooting

### Validate the Kickstart File Syntax

Before deploying, use the `ksvalidator` tool to check the syntax of your Kickstart file:

```bash
ksvalidator ks-rhel9.cfg
```

**Explanation:** This tool helps catch syntax errors and misconfigurations before they cause deployment issues.

### Common Errors & Solutions

| **Error**                           | **Possible Cause**                                      | **Solution**                                                        |
|-------------------------------------|---------------------------------------------------------|---------------------------------------------------------------------|
| `Could not retrieve mirrorlist`     | Incorrect network configuration in %pre section       | Verify network settings and ensure proper internet access.         |
| `Partitioning failed`                | Misconfigured disk sizes or conflicting directives      | Adjust partition sizes or use manual partitioning strategies.       |
| `Package not found`                 | Repository URL issues or missing packages in repos      | Check and update repository URLs; ensure package names are correct.  |

---

## Best Practices

1. **Security Measures:**
   - Use encrypted passwords rather than plaintext.
   - Serve Kickstart files over HTTPS where possible.

2. **Modular Script Design:**
   - Keep `%pre` and `%post` sections modular for easier debugging and maintenance.

3. **Version Control:**
   - Maintain your Kickstart files in a version control system (e.g., Git) to track changes and collaborate effectively.

4. **Thorough Testing:**
   - Always validate configurations in a controlled environment before production deployment.
   - Document changes and deployment strategies for future reference.

---

## Next Steps

1. **Integration with Satellite Server:**
   - Explore using Red Hat Satellite for centralized management and deployment of Kickstart installations.

2. **Cross-Platform Automation:**
   - Consider similar automation tools for other distributions (e.g., preseed for Debian/Ubuntu).

3. **Custom Kickstart Templates:**
   - Develop environment-specific Kickstart templates for different server roles and requirements.

4. **Advanced Scripting:**
   - Enhance your `%post` scripts to include additional system hardening, application deployment, or monitoring configuration tasks.
---

# Virtualization, Automation, and Linux Administration


## 1. Introduction to Virtualization and Hypervisors

- **Virtualization Basics**:  
  Virtualization allows efficient resource utilization by creating multiple isolated virtual machines (VMs) on a single physical server. This reduces hardware waste and improves scalability.

- **Hypervisors**:  
  Hypervisors like **KVM** (Kernel-based Virtual Machine), **VMware**, and **Hyper-V** manage VMs. They enable the creation, configuration, and control of VMs through graphical interfaces or command-line tools.

- **Web Interface for VM Management**:  
  Tools like **Cockpit** or **virt-manager** provide web-based interfaces to:
  - Monitor server resources (CPU, RAM, storage).
  - Add/remove storage volumes and network interfaces.
  - Manage firewall rules and open ports (e.g., HTTP/80, SSH/22).

---

## 2. Creating Virtual Machines with Ansible

- **Manual vs. Automated VM Creation**:  
  - **Manual**: Use hypervisor-specific tools (e.g., `virt-install` for KVM).  
  - **Automated**: Use **Ansible playbooks** to define VM configurations (e.g., disk size, OS ISO, network settings).

- **Example Playbook Structure**:  
  ```yaml
  - name: Create a VM
    community.libvirt.virt:
      name: my_vm
      memory: 2048
      disks:
        - size: 20G
      os_type: linux
      iso_path: /path/to/os.iso
  ```

- **Prerequisites**:  
  - Ensure virtualization is enabled in BIOS/UEFI (Intel VT-x/AMD-V).  
  - Install hypervisor packages (e.g., `qemu-kvm`, `libvirt`).

---

## 3. Shell Scripting Fundamentals

### 3.1 Variables and Environment

- **Variables**:  
  Define variables to store data (e.g., `MY_VAR="value"`). Use `export` to make them environment variables.

- **PATH Variable**:  
  Add custom script directories to `PATH` for global access:
  ```bash
  export PATH=$PATH:/path/to/scripts
  ```

- **Persisting Variables**:  
  Add environment variables to `~/.bashrc` or `/etc/profile` for persistence.

### 3.2 Conditional Statements and Loops

- **If-Else Statements**:  
  ```bash
  if [ "$VAR" -eq 0 ]; then
    echo "Variable is zero."
  else
    echo "Variable is non-zero."
  fi
  ```

- **For Loops**:  
  ```bash
  for i in {1..5}; do
    echo "Iteration $i"
  done
  ```

### 3.3 Return Values and Exit Status

- **Exit Codes**:  
  Commands return exit codes (`0` for success, non-zero for errors). Check with `$?`:
  ```bash
  ls /nonexistent
  echo "Exit code: $?"  # Outputs 2 (file not found)
  ```

- **Using `test` Command**:  
  Validate conditions (e.g., file existence, string comparisons):
  ```bash
  if test -f "/path/to/file"; then
    echo "File exists."
  fi
  ```

---

## 4. Service Management

- **Checking Service Status**:  
  Use `systemctl` to manage services (e.g., Apache, SSH):
  ```bash
  systemctl status sshd
  ```

- **Starting/Stopping Services**:  
  ```bash
  systemctl start sshd
  systemctl stop sshd
  ```

- **Automating Service Checks**:  
  Use scripts to verify service status and restart if down:
  ```bash
  if ! systemctl is-active --quiet sshd; then
    systemctl restart sshd
  fi
  ```

---

## 5. Text Processing with `grep`

- **Basic Search**:  
  Search for patterns in files:
  ```bash
  grep "error" /var/log/syslog
  ```

- **Inverse Search**:  
  Exclude lines containing a pattern:
  ```bash
  grep -v "debug" /var/log/app.log
  ```

- **Regex Support**:  
  Use regular expressions for advanced filtering (e.g., lines starting with `#`):
  ```bash
  grep "^#" /etc/nginx/nginx.conf
  ```

---

## 6. Best Practices for Ansible Playbooks

- **Idempotency**:  
  Ensure playbooks can run multiple times without side effects.

- **Modularity**:  
  Break playbooks into roles (e.g., `web_server`, `database`).

- **Variable Management**:  
  Use `group_vars` and `host_vars` for environment-specific configurations.

---

## 7. Key Commands Summary

| Command            | Description                                  |
|--------------------|----------------------------------------------|
| `virt-install`     | Create KVM VMs from the command line.        |
| `ansible-playbook` | Execute Ansible playbooks.                   |
| `systemctl`        | Manage system services.                      |
| `grep`             | Search text patterns in files.               |
| `export`           | Set environment variables.                   |



---

# File Searching, Task Scheduling, and Service Management

## 1. File Content Searching with `grep`

### Overview
`grep` is a powerful command-line tool used to search for patterns within files. It is widely used for filtering output and finding specific information in logs, configuration files, and code.

### Case Sensitivity
- **Default Behavior:**  
  `grep` performs case-sensitive searches by default.  
  **Example:** Searching for "CAPITAL" will not match "capital".

- **Ignoring Case:**  
  Use the `-i` option to ignore case differences.  
  ```bash
  grep -i "capital" filename
  ```

### Context Lines
- **Display Lines After the Match:**  
  Use the `-A` option to show a specified number of lines after each match.  
  **Example:**
  ```bash
  grep -A3 "search_term" filename
  ```
  This returns the matching line plus the three lines that follow.

- **Display Lines Before the Match:**  
  Use the `-B` option to show lines preceding each match.
  ```bash
  grep -B2 "search_term" filename
  ```

- **Display Lines Before and After the Match:**  
  Use the `-C` option to show context around each match.
  ```bash
  grep -C2 "search_term" filename
  ```

### Multiple Search Terms
- **Combining Search Patterns:**  
  Use the escape sequence `\|` to search for multiple terms within the same command.
  ```bash
  grep "term1\|term2" filename
  ```

---

## 2. Task Scheduling

Linux provides several tools to schedule tasks either as one-time or recurring jobs.

### One-Time Tasks with `at`
- **Purpose:**  
  Schedule a command to run once at a specified time.

- **Example:**
  ```bash
  echo "tar -czf /backup.tar.gz /data" | at 1:30 AM
  ```
  **Additional Commands:**
  - **List Pending Jobs:**  
    ```bash
    atq
    ```
  - **Remove a Scheduled Job:**  
    ```bash
    atrm [job_id]
    ```
  - **Monitor the queue of the deferred jobs in real time :**  
      ```bash
      watch atq
      ```

### Recurring Tasks with Cron

Cron allows you to schedule commands to run at regular intervals. The standard crontab format consists of five fields:


- **Cron Syntax Overview:**
  ```plaintext
  * * * * * command_to_execute
  │ │ │ │ │
  │ │ │ │ └─ Day of week (0-6, Sunday=0)
  │ │ │ └─── Month (1-12)
  │ │ └───── Day of month (1-31)
  │ └─────── Hour (0-23)
  └───────── Minute (0-59)
  ```
- **List the Cron Jobs:**  

  The current crontab will be displayed on standard output :
  ```bash
  crontab -l
  ```
- **list the Cron Jobs for specific user (Requires root permission):**  

  To list cron jobs for the ahmed user, you should use:
  ```bash
  crontab -l -u ahmed 
  ```
- **Editing the Crontab:**  

  Open the crontab file for the current user with:
  ```bash
  crontab -e
  ```
- **remove crontab entries:**  

  used to remove crontab entries :
  ```bash
  crontab -r  
  ```
- **remove the crontab for the user:**  

   intend to remove the crontab for the user named ahmed:
  ```bash
  crontab -r -u ahmed 
  ```

#### Special Characters in Cron

- **`*` (Asterisk):**  
  Represents any value in the field. For example, in the hour field, `*` means every hour.
  
- **`,` (Comma):**  
  Used as a list separator for multiple values. For example, `1,3,5` in the day-of-week field means Monday, Wednesday, and Friday.
  
- **`-` (Hyphen):**  
  Defines a range of values. For instance, `1-5` in the day-of-week field means Monday through Friday.
  
- **`/` (Slash):**  
  Specifies step values. In `*/2`, the `/2` tells cron to step through the values in increments of 2.
  
- **Special Strings (Non-standard):**
  - `@yearly` or `@annually`: Run once a year.
  - `@monthly`: Run once a month.
  - `@weekly`: Run once a week.
  - `@daily`: Run once a day.
  - `@hourly`: Run once an hour.
  - `@reboot`: Run once at system startup.
- **Examples:**
  - **Daily Script at 1:30 PM:**
    ```plaintext
    30 13 * * * /scripts/backup.sh
    ```
  - **Every 5 Minutes:**
    ```plaintext
    */5 * * * * /scripts/monitor.sh
    ```
  - **Every week:**
    ```plaintext
    @weelky echo "hello My frinds" >/tmp/hello
    ```
  - **Every Month:**
    ```plaintext
    @monthely /user/bin/echo "hello My frinds" >/tmp/hello
    ```
- **User-Specific vs. System-Wide Cron:**
  - **User-Specific:** Managed with `crontab -e`.
  - **System-Wide:** Located in `/etc/crontab` or `/etc/cron.d/`.


### Recurring Tasks with Anacron

#### What is Anacron?

Anacron is designed for systems that do not run continuously (e.g., laptops or desktops that are powered off at night). Unlike cron, which requires the system to be running at the scheduled time, Anacron ensures that periodic tasks are executed when the system starts up if they were missed.

#### How Anacron Works

- **Scheduling with Delays:**  
  Anacron uses a delay mechanism (in days) rather than specific times. For example, a daily job may be executed a few minutes after boot if it was not run on schedule.

- **Configuration File:**  
  The main configuration file is `/etc/anacrontab`.

#### Sample `/etc/anacrontab` File

```plaintext
# /etc/anacrontab: configuration file for Anacron

# period delay job-identifier command
1   5   cron.daily    run-parts /etc/cron.daily
7   10  cron.weekly   run-parts /etc/cron.weekly
30  15  cron.monthly  run-parts /etc/cron.monthly
```

**Explanation:**
- **Period:**  
  Specifies the number of days between job executions.
  
- **Delay:**  
  The number of minutes to wait after system startup before executing the job.
  
- **Job Identifier:**  
  A unique name for the job.
  
- **Command:**  
  The command to run (commonly using `run-parts` to execute all scripts in a directory).




- **User-Specific vs. System-Wide Cron:**

  - **User-Specific:** Managed with `anacrontab -e`.
  
  - **System-Wide:** Located in `/etc/anacrontab` or `/etc/cron.d/`.

### Advantages of Anacron

- **Missed Jobs Execution:**  
  Anacron will execute a job if it was missed due to the system being off.
  
- **Simplicity:**  
  Ideal for scheduling periodic maintenance tasks on systems that do not run 24/7.




---

## 3. Systemd Timers

Systemd timers offer enhanced scheduling features over traditional cron, such as executing missed tasks after downtime.

### Purpose and Advantages
- **Missed Jobs:**  
  Systemd timers can catch up on jobs that were missed due to system downtime.
- **Dependency Management:**  
  They can specify dependencies on other systemd units.
- **Centralized Logging:**  
  Timer events and output are managed by `journald`.

### Timer Configuration Example
To run a cleanup script 25 minutes after boot, create a timer file at `/etc/systemd/system/cleanup.timer`:

```ini
[Unit]
Description=Run cleanup 25 minutes after boot

[Timer]
OnBootSec=25min
Unit=cleanup.service

[Install]
WantedBy=timers.target
```

### Enabling and Starting the Timer
Activate the timer with:
```bash
systemctl enable cleanup.timer
systemctl start cleanup.timer
```

---

## 4. Service Management

Systemd is the standard for service management on many Linux distributions.

### Checking Service Status
- **Command:**
  ```bash
  systemctl status servicename
  ```
  This command displays detailed information about the service’s current status.

### Starting and Stopping Services
- **Start a Service:**
  ```bash
  systemctl start servicename
  ```
- **Stop a Service:**
  ```bash
  systemctl stop servicename
  ```

### Service Configuration Files
- **Location:**  
  Service unit files are typically stored in `/etc/systemd/system/`.
- **Modification:**  
  Edit these files to change service behaviors, then reload the systemd daemon:
  ```bash
  systemctl daemon-reload
  ```

---

## 5. Temporary File Management

Managing temporary files is crucial for system maintenance and stability.

### `tmpfiles.d` Configuration
- **Purpose:**  
  Define rules for creating, cleaning, and managing temporary files and directories during boot.
- **Example:** Create a temporary directory that is automatically cleaned after 10 days.
  
  Create a file `/etc/tmpfiles.d/mytemp.conf` with the following content:
  ```plaintext
  D /tmp/mytemp 1777 root root 10d
  ```
  **Explanation:**
  - `D`: Create a directory.
  - `1777`: Directory permissions.
  - `10d`: The directory will be deleted after 10 days.

### Manual Cleanup
- **Command:**
  ```bash
  systemd-tmpfiles --clean
  ```
  This command enforces the cleanup policies defined in `/etc/tmpfiles.d/`.

---

## 6. Key Differences: Cron vs. Systemd Timers

| **Feature**               | **Cron**                          | **Systemd Timers**                 |
|---------------------------|-----------------------------------|------------------------------------|
| **Missed Jobs**           | Not executed if the system is down.| Executes missed jobs after reboot. |
| **Configuration**         | Centralized in crontab files.     | Decentralized into `.timer` files. |
| **Dependencies**          | No dependency handling.           | Can depend on other systemd units. |
| **Logging**               | Logs to syslog.                   | Logs to `journald`.                |

---

## 7. Troubleshooting & Best Practices

### Troubleshooting Logs
- **Cron Logs:**  
  - On many systems, check `/var/log/syslog` or use:
    ```bash
    journalctl -u cron
    ```
- **Systemd Timer Logs:**  
  - Check logs for a specific timer:
    ```bash
    journalctl -u timer_name.timer
    ```

### Testing Your Configurations
- **Schedule Near-Future Jobs:**  
  Test your cron jobs or systemd timers by scheduling them a few minutes ahead to verify that they execute correctly.

### Permissions and Ownership
- Ensure that any scripts executed by cron jobs or timers have the appropriate execute permissions and correct file ownership.

### General Best Practices
- **Version Control:**  
  Keep your configuration files (cron, systemd unit files, tmpfiles) under version control (e.g., using Git) to track changes and enable rollbacks.
- **Documentation:**  
  Document your scheduled tasks, timer configurations, and service modifications for easier maintenance and troubleshooting.
- **Regular Reviews:**  
  Periodically review scheduled tasks and service logs to identify and resolve issues proactively.

---
