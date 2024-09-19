Here’s a rewritten version of your notes with examples and more 
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

### Goal:  
Locate and accurately interpret system logs to troubleshoot system events.

### Objectives:
1. **Describe the basic logging architecture in Red Hat Enterprise Linux**:
   - Understand how the system records events in log files located under `/var/log`.
   - Learn the roles of `systemd-journald` and `rsyslog` in managing logs.

2. **Understand the logrotate utility**:
   - Learn how log files are managed and rotated to prevent them from consuming excessive disk space.

3. **View and manage logs using `journalctl`**:
   - Use `journalctl` to filter and view logs stored by `systemd-journald`.

4. **Configure the time zone and adjust system time**:
   - Learn how to set time zones and adjust system time, important for maintaining accurate log timestamps.

---

### System Logging Overview:
Processes and the operating system kernel record events in logs. These logs are stored as text files, primarily in the `/var/log` directory. System logging is handled by two key services:

#### 1. **systemd-journald:**
   - A component of systemd responsible for recording, storing, and managing logs. 
   - Stores logs in a binary format at `/run/log/journal/`.
   - Supports querying logs using the `journalctl` command for more advanced filtering and management.

#### 2. **rsyslog:**
   - Sorts and writes system logs to files in `/var/log`, which persist across reboots.
   - Handles traditional text-based logging for persistent storage.
  
##### Common Log Files:
- **/var/log/messages:** General system messages.
- **/var/log/secure:** Security and authentication logs.
- **/var/log/maillog:** Mail server-related logs.
- **/var/log/cron:** Logs related to cron jobs.
- **/var/log/boot.log:** Logs related to system startup.

---

### Overview of Syslog Priorities:
Syslog messages have two components: facility and severity.

- **Facility:** The origin of the message, such as kernel, mail, authentication.
- **Severity Levels:** Range from 0 (Emergency) to 7 (Debug), where lower numbers indicate higher severity.

Logs can be analyzed using tools like `journalctl`, `grep`, and `rsyslog`.

In system administration, analyzing and storing logs is a critical task for monitoring and troubleshooting. Here's an overview of syslog priorities and how logs are typically handled:

### Overview of Syslog Priorities

Syslog (System Logging Protocol) is widely used in Unix-like operating systems (like Linux) for collecting and storing log messages from various system components. Each log message has a priority, which is a combination of *facility* and *severity level*.

#### 1. **Facility:**
Facilities represent the part of the system or application that generates the log message. Common facilities include:

- **kern:** Kernel messages
- **user:** User-level messages
- **mail:** Mail system
- **daemon:** System daemons (background processes)
- **auth:** Security/authorization messages
- **syslog:** Syslog itself
- **local0-local7:** Reserved for local use

#### 2. **Severity Levels:**
Severity levels indicate the importance of the log message. The lower the number, the higher the severity:

- **0: Emergency** — System is unusable
- **1: Alert** — Immediate action needed
- **2: Critical** — Critical conditions
- **3: Error** — Error conditions
- **4: Warning** — Warning conditions
- **5: Notice** — Normal but significant conditions
- **6: Informational** — Informational messages
- **7: Debug** — Debug-level messages

#### Syslog Message Structure:
The priority of each message is calculated by combining the facility and severity, where:

```
Priority = (Facility * 8) + Severity
```

### Analyzing Logs:
Logs can be analyzed manually or using tools like:
- **grep:** To search logs for specific patterns or errors.
- **tail -f /var/log/syslog:** For real-time log monitoring.
- **journalctl:** To query and filter system logs (for systems using `systemd`).

### Storing Logs:
Logs are typically stored in files under `/var/log`. Examples include:
- `/var/log/syslog` or `/var/log/messages` for general system logs
- `/var/log/auth.log` for authentication-related logs
- `/var/log/dmesg` for kernel ring buffer messages

You can also configure remote logging, centralizing logs across multiple servers using tools like:
- **rsyslog**: Advanced logging with features like filtering, remote logging, and custom formatting.
- **Logrotate**: For managing the size and rotation of log files.

#### Best Practices:
- Set up log rotation to avoid disk space issues.
- Use central logging solutions for distributed environments.
- Implement monitoring for high-priority logs (errors, critical, alert).

