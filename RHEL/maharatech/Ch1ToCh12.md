# Linux Commands and Concepts with Examples

## File System and Directory Management

### 1. **Listing Files**
- `ls -ltr`: Lists files in the current directory sorted by modification time, in reverse order.
    - Example:
    ```bash
    ls -ltr
    ```
    Output shows files with the latest modification time at the bottom.

### 2. **Create Directories**
- `mkdir -p dir1/dir2/dir3`: Creates directories `dir1`, `dir2`, and `dir3` in a nested structure.
    - Example:
    ```bash
    mkdir -p project/src/components
    ```

## Links in Linux

### 3. **Hard Link**
- `ln <file> <hardlink>`: Creates a hard link, which is another name for a file referring to the actual data.
    - Example:
    ```bash
    ln original_file hard_link_file
    ```
    Now `hard_link_file` points to the same data as `original_file`.

### 4. **Soft Link (Symbolic Link)**
- `ln -s <file> <softlink>`: Creates a soft link, which is a pointer to another file (similar to Windows shortcuts).
    - Example:
    ```bash
    ln -s /path/to/original_file soft_link_file
    ```

### 5. **View Inode Numbers**
- `ls -li`: Lists files along with their inode numbers.
    - Example:
    ```bash
    ls -li
    ```
    Output shows inode numbers in the first column.

## Pattern Matching

### 6. **Wildcards**
- `*`: Matches any string of zero or more characters.
    - Example:
    ```bash
    ls *.txt
    ```
    Lists all files ending with `.txt`.

- `?`: Matches any single character.
    - Example:
    ```bash
    ls file?.txt
    ```
    Lists files like `file1.txt`, `fileA.txt` but not `file12.txt`.

- `[abc...]`: Matches any one character within the brackets.
    - Example:
    ```bash
    ls [abc]*.txt
    ```
    Lists files starting with `a`, `b`, or `c` and ending with `.txt`.

## Basic Regular Expressions

### 7. **Common Regex Operators**
- `.`: Matches any character.
    - Example:
    ```bash
    grep 'a.b' file.txt
    ```
    Finds occurrences of `a`, any character, and `b` in `file.txt`.

- `^`: Matches the start of a string.
    - Example:
    ```bash
    grep '^start' file.txt
    ```
    Finds lines starting with `start` in `file.txt`.

- `$`: Matches the end of a string.
    - Example:
    ```bash
    grep 'end$' file.txt
    ```
    Finds lines ending with `end` in `file.txt`.

## File Operations

### 8. **Cut Command**
- `cut -d <delimiter> -f <fields> <file>`: Extracts specific fields from a file.
    - Example:
    ```bash
    cut -d: -f1,7 /etc/passwd
    ```
    Extracts the 1st and 7th fields from `/etc/passwd`, using `:` as the delimiter.

### 9. **Word Count (wc)**
- `wc <file>`: Counts words, lines, and characters in a file.
    - Example:
    ```bash
    echo "I Love Linux" | wc
    ```
    Output: `1 3 13`, meaning 1 line, 3 words, and 13 characters.

## Vim Basics

### 10. **Basic Navigation**
- `h`, `j`, `k`, `l`: Move left, down, up, and right, respectively.
- `w`: Jump to the beginning of the next word.
- `b`: Jump to the beginning of the previous word.

    - Example:
    Open a file in Vim and use `w` to move forward through words.

### 11. **Editing Commands**
- `i`: Enter insert mode before the cursor.
- `a`: Enter insert mode after the cursor.
- `dd`: Delete the current line.

    - Example:
    In Vim, press `i` to start inserting text.

### 12. **Copy, Paste, and Undo**
- `yy`: Yank (copy) the current line.
- `p`: Paste after the cursor.
- `u`: Undo the last action.
    - Example:
    Yank a line with `yy` and paste it with `p`.

## Environment Variables

### 13. **Viewing and Setting Variables**
- `set`: Lists all shell variables.
    - Example:
    ```bash
    set
    ```

- `echo $HOME`: Displays the value of the `HOME` environment variable.
    - Example:
    ```bash
    echo $HOME
    ```

- `export <variable>`: Exports a variable to child processes.
    - Example:
    ```bash
    export MY_VAR="hello"
    ```

### 14. **Working with PATH**
- `PATH`: Defines directories where the shell looks for executable files.
    - Example:
    ```bash
    export PATH=$PATH:/home/mohamed/bin
    ```

## User Management

### 15. **Creating and Modifying Users**
- `useradd <username>`: Adds a new user.
    - Example:
    ```bash
    useradd -m -s /bin/bash user01
    ```

- `usermod <username>`: Modifies an existing user.
    - Example:
    ```bash
    usermod -aG sudo user01
    ```

### 16. **Deleting Users**
- `userdel <username>`: Deletes a user without removing their home directory.
    - Example:
    ```bash
    userdel user01
    ```

## File Permissions and Ownership

### 17. **Changing File Permissions**
- `chmod u+rwx,g=rx,o-wx <file>`: Modifies file permissions using the symbolic method.
    - Example:
       ```bash
    chmod u+rwx,g=rx,o-wx myfile.txt
    ```
    This command gives the file owner (`u`) read, write, and execute permissions, the group (`g`) read and execute permissions, and removes write and execute permissions for others (`o`).

- `chmod 755 <file>`: Modifies file permissions using the numeric method.
    - Example:
    ```bash
    chmod 755 script.sh
    ```
    This sets read, write, and execute permissions for the owner, and read and execute permissions for the group and others.

### 18. **Changing File Ownership**
- `chown <owner>:<group> <file>`: Changes the ownership of a file.
    - Example:
    ```bash
    chown mohamed:developers project.txt
    ```
    This command changes the owner to `mohamed` and the group to `developers` for the file `project.txt`.

## Process Management

### 19. **Viewing Running Processes**
- `ps -aux`: Displays detailed information about all running processes.
    - Example:
    ```bash
    ps -aux | grep python
    ```
    Lists all processes and filters for those related to `python`.

### 20. **Killing a Process**
- `kill <PID>`: Sends a termination signal to a process based on its process ID (PID).
    - Example:
    ```bash
    kill 1234
    ```
    This terminates the process with PID `1234`.

- `kill -9 <PID>`: Forcefully kills a process that isn't responding.
    - Example:
    ```bash
    kill -9 5678
    ```

### 21. **Background and Foreground Jobs**
- `&`: Runs a command in the background.
    - Example:
    ```bash
    python myscript.py &
    ```
    Runs `myscript.py` in the background.

- `fg`: Brings a background job to the foreground.
    - Example:
    ```bash
    fg %1
    ```
    Brings the first background job to the foreground.

### 22. **Checking CPU and Memory Usage**
- `top`: Displays real-time system processes, CPU, and memory usage.
    - Example:
    ```bash
    top
    ```
    Press `q` to quit.

- `htop`: An enhanced version of `top` with a more user-friendly interface.
    - Example:
    ```bash
    htop
    ```

## Disk Usage and Quotas

### 23. **Checking Disk Usage**
- `df -h`: Displays the disk space usage in a human-readable format.
    - Example:
    ```bash
    df -h
    ```
    Shows the available and used space on all mounted filesystems.

### 24. **Checking Directory Size**
- `du -sh <directory>`: Displays the total size of a directory in a human-readable format.
    - Example:
    ```bash
    du -sh /var/log
    ```
    Displays the size of the `/var/log` directory.

## Network Commands

### 25. **Check Network Interface Information**
- `ifconfig`: Displays network interface configurations.
    - Example:
    ```bash
    ifconfig
    ```

- `ip addr`: Shows IP address configuration and more detailed network information.
    - Example:
    ```bash
    ip addr show
    ```

### 26. **Ping a Host**
- `ping <hostname>`: Sends ICMP packets to test connectivity to a host.
    - Example:
    ```bash
    ping google.com
    ```
    Sends a series of pings to `google.com`.

### 27. **Traceroute**
- `traceroute <hostname>`: Shows the route packets take to reach a host.
    - Example:
    ```bash
    traceroute google.com
    ```

### 28. **Download Files Using `wget`**
- `wget <URL>`: Downloads a file from the web.
    - Example:
    ```bash
    wget https://example.com/file.zip
    ```

## Searching for Files and Content

### 29. **Find Files**
- `find <path> -name <filename>`: Searches for files by name.
    - Example:
    ```bash
    find /home -name "*.txt"
    ```
    Searches for all `.txt` files under `/home`.

### 30. **Grep: Search Inside Files**
- `grep <pattern> <file>`: Searches for a pattern inside a file.
    - Example:
    ```bash
    grep "error" /var/log/syslog
    ```
    Searches for lines containing "error" in the syslog file.

### 31. **Locate Command**
- `locate <filename>`: Searches for a file using a prebuilt index.
    - Example:
    ```bash
    locate passwd
    ```
    Finds files related to `passwd`.

## System Monitoring

### 32. **View System Uptime**
- `uptime`: Displays how long the system has been running.
    - Example:
    ```bash
    uptime
    ```

### 33. **View Memory Usage**
- `free -h`: Shows memory usage in a human-readable format.
    - Example:
    ```bash
    free -h
    ```
    Displays the total, used, and available memory.

## Archive and Compression

### 34. **Tar Command**
- `tar -cvf archive.tar <files>`: Creates a tar archive.
    - Example:
    ```bash
    tar -cvf backup.tar /home/mohamed/documents
    ```

- `tar -xvf archive.tar`: Extracts a tar archive.
    - Example:
    ```bash
    tar -xvf backup.tar
    ```

### 35. **Compress Files with gzip**
- `gzip <file>`: Compresses a file using gzip.
    - Example:
    ```bash
    gzip largefile.txt
    ```

- `gunzip <file.gz>`: Decompresses a gzipped file.
    - Example:
    ```bash
    gunzip largefile.txt.gz
    ```

## Miscellaneous Commands

### 36. **Viewing Command History**
- `history`: Displays the command history.
    - Example:
    ```bash
    history
    ```

### 37. **Clear Terminal**
- `clear`: Clears the terminal screen.
    - Example:
    ```bash
    clear
    ```

## Scheduling Tasks

### 38. **Cron Jobs**
- `crontab -e`: Edits the current user's cron jobs (used for scheduling commands).
    - Example:
    ```bash
    # Run a script at 5 AM every day
    0 5 * * * /home/mohamed/scripts/backup.sh
    ```

### 39. **View Scheduled Cron Jobs**
- `crontab -l`: Lists the current user's scheduled cron jobs.
    - Example:
    ```bash
    crontab -l
    ```



# Analyzing and Storing Logs

### **Goal:**
- Locate and accurately interpret system logs to troubleshoot system events.

---

### **Objectives:**
1. **Describe the basic logging architecture in Red Hat Enterprise Linux**:
   - Learn how processes and the operating system kernel record events in log files located in `/var/log`.
   
2. **Understand the logrotate utility**:
   - Learn how log files are rotated to manage disk space, with the configuration in `/etc/logrotate.conf`.

3. **View and manage logs using `journalctl`**:
   - Use the `journalctl` command to filter and review logs, including prioritizing entries based on severity.

4. **Configure the time zone and adjust the system time**:
   - Manage system time settings, including time zone configuration using `timedatectl`.

---

### **System Logging Architecture**
- **Processes and Kernel Logging**:
   - Both processes and the Linux kernel log system events for auditing and troubleshooting.
   - Logs are stored in text files under `/var/log`.

- **Logging Services**:
   1. **systemd-journald**:
      - Manages system logs stored in binary format in `/run/log/journal/`.
      - Logs can be queried using `journalctl`.
   2. **rsyslog**:
      - Sorts and writes syslog messages to `/var/log`.
      - This persists logs across reboots.

- **Common Log Files**:
   - `/var/log/messages`: General system messages.
   - `/var/log/secure`: Security/authentication-related logs.
   - `/var/log/maillog`: Logs related to the mail server.
   - `/var/log/cron`: Logs related to scheduled job executions.
   - `/var/log/boot.log`: System startup logs.

---

### **Syslog Priorities Overview**
Syslog messages use **facility** and **priority** to determine how messages are handled. Messages have severity levels:

1. **0: Emergency** — System is unusable.
2. **1: Alert** — Immediate action needed.
3. **2: Critical** — Critical conditions.
4. **3: Error** — Error conditions.
5. **4: Warning** — Warning conditions.
6. **5: Notice** — Normal but significant conditions.
7. **6: Informational** — Informational messages.
8. **7: Debug** — Debug-level messages.

These priorities are managed by rules in `/etc/rsyslog.conf`, and the `rsyslog` service is restarted to apply changes:
```bash
systemctl restart rsyslog.service
```

---

### **Log Rotation**
- **logrotate** is a tool used to rotate log files, preventing them from consuming too much space in `/var/log`.
   - The main configuration file is `/etc/logrotate.conf`.
   - Restart logrotate with:
   ```bash
   systemctl restart logrotate.service
   ```

---

### **Sending Syslog Messages Manually (Using `logger`)**
- The `logger` command can send syslog messages to `rsyslog`. By default, it logs messages as **user.notice**.
   ```bash
   logger "Custom syslog message"
   ```
   You can specify a different priority with the `-p` option:
   ```bash
   logger -p auth.err "Authentication error occurred"
   ```

---

### **Reviewing System Journal Entries (Using `journalctl`)**
- The `journalctl` command highlights important log messages:
   - **Bold**: Messages at **notice** or **warning** priority.
   - **Red**: Messages at **error** priority or higher.

   **Common `journalctl` commands**:
   - `journalctl -n`: Show the last 10 log entries.
   - `journalctl -f`: Continuously follow log output.
   - `journalctl -p <priority>`: Show logs at the specified priority or higher.
   - `journalctl -b`: Display logs from the current boot.
   - `journalctl --since yesterday`: Show logs starting from yesterday.
   - `journalctl _PID=1`: Display logs for a specific user by their UID (e.g., UID=1).

#### **Make `journalctl` Logs Permanent**:
1. Create the directory `/var/log/journal`:
   ```bash
   mkdir /var/log/journal
   chown -R root:system-journal /var/log/journal
   chmod g+s /var/log/journal
   ```
2. Edit `/etc/systemd/journal.conf`:
   - Uncomment `Storage` and set it to `persistent`:
   ```bash
   Storage=persistent
   ```
3. Restart `systemd-journald` to apply the changes:
   ```bash
   systemctl restart systemd-jjournald
   ```

---

### **Maintaining Accurate Time (Using `timedatectl`)**
- **timedatectl** shows an overview of current time settings, including time zone and NTP sync status.

   **Useful Commands**:
   - `timedatectl`: Displays time settings overview.
   - `timedatectl list-timezones`: Lists available time zones.
   - `timedatectl set-timezone Africa/Cairo`: Sets the time zone.
   - `timedatectl set-time <YYYY-MM-DD HH:MM:SS>`: Manually set the system time.
   - `tzselect`: Guides you to determine the appropriate time zone.


---

# Networking Configuration on Red Hat Enterprise Linux


## **Goal:**
Configure network interfaces and settings on Red Hat Enterprise Linux servers.

---

## **Objectives:**
1. **Configure and modify network settings from the CLI**.
2. **Manage network settings and devices using `nmcli`**.
3. **Troubleshoot connectivity issues using CLI commands**.
4. **Change server hostnames and DNS configurations from the CLI**.

---

## **Gathering Network Interface Information**

### Identifying Network Interfaces:
- **`ip link`**: Lists all network interfaces on the system.
- **`ip addr show`**: Displays detailed IP address information for all interfaces.
- **`ping`**: Tests network connectivity by sending ICMP ECHO requests.
  - **`ping -c [count]`**: Sends a specified number of ECHO requests.

### Viewing IP Routes:
- **`ip route`**: Displays the system's default IP route.

### Checking Connectivity Between Hosts:
- **`traceroute` or `tracepath`**: Traces the route traffic takes through multiple routers to a remote host.

---

## **Troubleshooting Ports and Services**

### Using `ss` for Socket Statistics:
- **`ss`**: Displays detailed socket statistics.
  - **`ss -n`**: Shows numerical addresses instead of resolving to names.
  - **`ss -t`**: Displays TCP sockets.
  - **`ss -u`**: Displays UDP sockets.
  - **`ss -l`**: Lists listening sockets only.
  - **`ss -a`**: Shows all sockets (both listening and established).
  - **`ss -p`**: Displays processes using the sockets.

---

## **Configuring Network from the Command Line**

### For RHEL 8:
- Configuration file: `/etc/sysconfig/network-scripts/ifcfg-<interface_name>`.
- Example contents:
  ```
  DEVICE=<network_interface_name>
  TYPE=Ethernet
  NM_CONTROLLED=yes
  ONBOOT=yes
  BOOTPROTO=none
  IPADDR=192.168.121.188
  NETMASK=255.255.255.0
  GATEWAY=192.168.121.1
  DNS1=8.8.8.8
  DNS2=4.2.2.2
  ```

### For RHEL 9:
- Configuration uses **key files** in `/etc/NetworkManager/system-connections/`.
- **Network-scripts** package is no longer available in RHEL 9.

---

## **Managing Network with `nmcli`**

### Viewing Network Information:
- **`nmcli dev status`**: Displays the status of all network devices.
- **`nmcli con show`**: Lists all network connections.
  - **`nmcli con show --active`**: Shows only active connections.

### Adding a Network Connection:
- **Static connection**:
  ```bash
  nmcli connection add con-name <Static-connection> type ethernet ifname <interface> ipv4.addresses 192.168.1.55/24 gw4 192.168.1.1 connection.autoconnect yes ipv4.method manual
  ```
- **Dynamic connection**:
  ```bash
  nmcli connection add con-name Dynamic-<interface> ifname <interface> autoconnect yes ipv4.method auto
  ```

### Activating/Deactivating a Connection:
- **Activate**: `nmcli connection up <con-name>`
- **Deactivate**: `nmcli connection down <con-name>`

### Modifying Network Connection Settings:
- **Modify a connection**:
  ```bash
  nmcli con mod <con-name> ipv4.addresses "192.0.2.2/24 192.0.2.254"
  ```
  This sets the IPv4 address to `192.0.2.2/24` and default gateway to `192.0.2.254`.

### Reloading Network Configuration:
- **Reload**: `nmcli con reload`
- If reload fails:
  ```bash
  nmcli con down <con-name>
  nmcli con up <con-name>
  ```

### Using Text User Interface (TUI) for Network Configuration:
- **`nmtui`**: A text-based user interface for managing network settings.

---

## **Configure Host Names and Name Resolution**

### Modifying Hostnames:
- **Hostname file**: `/etc/hostname`.
- **View hostname**: `hostname`.
- **Change hostname**:
  ```bash
  hostnamectl set-hostname <newhostname>
  ```

### Configuring DNS Resolution:
- The DNS resolver converts hostnames to IP addresses based on configurations in:
  - **`/etc/nsswitch.conf`**: Determines order of name resolution.
  - **`/etc/hosts`**: First file checked for resolving hostnames.
  - **`/etc/resolv.conf`**: Used to configure DNS query settings.

- **Adding a DNS server with `nmcli`**:
  ```bash
  nmcli con mod <con-name> ipv4.dns 8.8.8.8
  nmcli con down <con-name>
  nmcli con up <con-name>
  ```

---
