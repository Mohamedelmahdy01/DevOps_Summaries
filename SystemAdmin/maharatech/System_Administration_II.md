

# Improving Command-Line Productivity 

improving command-line productivity in Red Hat Enterprise Linux (RHEL) by providing a comprehensive, practical, and beginner-friendly approach to Bash shell scripting. It focuses on automating tasks, using loops and conditionals, and processing text with `grep` and regular expressions, tailored for your CentOS 9 VMs (`slave1`, `slave2`, `slave3` at `192.168.64.131–133`). The guide includes advanced scripting techniques, troubleshooting tips, and integration with your Ansible setup for MySQL management, ensuring relevance for system administration tasks.

## 1. Introduction to Shell Scripting

Bash shell scripting in RHEL and CentOS enables system administrators to automate repetitive tasks, streamline workflows, and enhance command-line efficiency. Scripts are text files containing sequences of commands, executed by the Bash interpreter, saving time compared to manual command entry. This guide is particularly relevant for your environment, where scripts can automate MySQL backups on `slave3` or log analysis across VMs.

### Why Shell Scripting?
- **Automation**: Scripts execute multiple commands in sequence, reducing manual effort (e.g., backing up `/var/lib/mysql`).
- **System Integration**: Used in RHEL boot processes (e.g., `/etc/rc.d`) and system administration tasks.
- **Simplicity**: Bash syntax mirrors command-line utilities, making it accessible for beginners.
- **Flexibility**: Ideal for file manipulation, log processing, and system monitoring.

### When to Avoid Shell Scripts
Shell scripts are less suitable for:
- Resource-intensive tasks (e.g., sorting large datasets).
- Complex mathematical operations.
- Multi-dimensional arrays or GUI applications.
- Direct hardware access or legacy code integration.

For these, consider Python, Perl, or C/C++.

## 2. Writing Effective Bash Scripts

### Shebang (`#!`)
The shebang specifies the script’s interpreter. For Bash, use:
```bash
#!/bin/bash
```
Without a shebang, the system defaults to the user’s shell (usually Bash).

### Making Scripts Executable
Make a script executable:
```bash
chmod +x script.sh
./script.sh
```
Alternatively, run with:
```bash
bash script.sh
```

### Best Practices
- **Comments**: Use `#` to explain code:
  ```bash
  # Backup MySQL data on slave3
  ```
- **Exit on errors**: Use `set -e` to stop on command failures:
  ```bash
  set -e
  ```
- **Check variables**: Use `set -u` to exit on undeclared variables:
  ```bash
  set -u
  ```
- **Quote variables**: Use double quotes to handle spaces:
  ```bash
  echo "$VAR"
  ```
- **Use functions**: Organize code for reusability:
  ```bash
  backup_mysql() {
      tar -czf mysql_backup.tar.gz /var/lib/mysql
  }
  ```
- **Debugging**: Use `bash -x script.sh` to trace execution.
- **Descriptive names**: Use clear names like `mysql_backup.sh`.

## 3. Basic Scripting Constructs

### Output and Variables
- **Print output**: Use `echo`:
  ```bash
  echo "Starting MySQL backup"
  ```
- **Capture command output**: Use `$(command)` or backticks:
  ```bash
  HOST=$(hostname -s)
  echo "Hostname: $HOST"
  ```

### Quoting Special Characters
- **Backslash (`\`)**: Escapes one character:
  ```bash
  echo \$HOST  # Outputs: $HOST
  ```
- **Single quotes (`'`)**: Treats content literally:
  ```bash
  echo '$HOST'  # Outputs: $HOST
  ```
- **Double quotes (`"`)**: Expands variables:
  ```bash
  echo "$HOST"  # Outputs: server01
  ```

### File and Directory Handling
Quote names with spaces:
```bash
touch "mysql log.txt"
cd "mysql logs"
```

### Special Characters
| **Character** | **Description** |
|---------------|-----------------|
| `.`           | Hidden files, current directory (`.`), or parent directory (`..`) |
| `*`           | Wildcard for filename expansion |
| `$`           | Variable reference or regex end-of-line |

### Brace Expansion
Generate sequences:
```bash
touch {log1,log2,log3}.txt
echo {1..5}  # Outputs: 1 2 3 4 5
```

### Redirection and Pipes
- **Redirect output**: `>` overwrites, `>>` appends:
  ```bash
  ls > files.txt
  ```
- **Pipe output**: `|` sends output to another command:
  ```bash
  ls | grep ".log"
  ```

## 4. Loops for Efficient Command Execution

Loops iterate over lists or conditions, automating repetitive tasks.

### `for` Loop
Iterate over a list:
```bash
for file in *.log; do
    echo "Processing $file"
done
```
Example: Rename MySQL logs on `slave3`:
```bash
for file in /var/log/mysql*.log; do
    mv "$file" "backup_$file"
    echo "Renamed $file"
done
```

### `while` Loop
Run while a condition is true:
```bash
i=1
while [ $i -le 5 ]; do
    echo "Count: $i"
    ((i++))
done
```

### `until` Loop
Run until a condition is true:
```bash
i=1
until [ $i -gt 5 ]; do
    echo "Count: $i"
    ((i++))
done
```

## 5. Conditional Statements

Conditionals control script flow based on conditions.

### `if/then` Construct
Check command exit status:
```bash
if [ -d /var/lib/mysql ]; then
    echo "MySQL directory exists"
else
    echo "MySQL directory missing"
fi
```

### `if/elif/else` Construct
Handle multiple conditions:
```bash
x=5
if [ $x -gt 10 ]; then
    echo "x is large"
elif [ $x -gt 5 ]; then
    echo "x is medium"
else
    echo "x is small"
fi
```

### Testing with `[[...]]`
Use `[[...]]` for string and file tests:
```bash
[[ -f /var/log/mysqld.log ]] && echo "MySQL log exists"
```

## 6. Regular Expressions and `grep`

Regular expressions (regex) match patterns in text, crucial for log analysis.

### Regex Symbols
| **Symbol** | **Description** |
|------------|-----------------|
| `.`        | Any single character |
| `^`        | Start of line |
| `$`        | End of line |
| `*`        | Zero or more of previous |
| `[]`       | Any one of enclosed characters |
| `|`        | OR operator |
| `\`        | Escape special characters |

### Using `grep`
Search logs on `slave3`:
- **Find errors**: `grep "ERROR" /var/log/mysqld.log`
- **Match start of line**: `grep "^ERROR" /var/log/mysqld.log`
- **Match digits**: `grep "[0-9]" /var/log/mysqld.log`

## 7. Practical Example: MySQL Backup Script

This script automates MySQL backups on `slave3` and transfers them to `slave1`:
```bash
#!/bin/bash
set -e
set -u

BACKUP_DIR="/tmp/backups"
REMOTE_HOST="osboxes@192.168.64.131"
REMOTE_PATH="/home/osboxes/backups"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Archive MySQL data
for dir in /var/lib/mysql /var/log; do
    if [ -d "$dir" ]; then
        tar -czf "$BACKUP_DIR/$(basename "$dir")_$(date +%F).tar.gz" "$dir"
        if [ $? -eq 0 ]; then
            echo "Archived $dir successfully"
        else
            echo "Failed to archive $dir"
            exit 1
        fi
    else
        echo "$dir does not exist"
    fi
done

# Transfer backups
for file in "$BACKUP_DIR"/*.tar.gz; do
    scp "$file" "$REMOTE_HOST:$REMOTE_PATH"
    if [ $? -eq 0 ]; then
        echo "Transferred $file to $REMOTE_HOST"
    else
        echo "Failed to transfer $file"
        exit 1
    fi
done
```

## 8. Troubleshooting Common Issues

| **Issue** | **Cause** | **Solution** |
|-----------|-----------|--------------|
| `Permission denied` | Script not executable | `chmod +x script.sh` |
| `Command not found` | Missing shebang | Add `#!/bin/bash` |
| `Variable unset` | Undeclared variable | Use `set -u` or check variables |
| `grep no matches` | Incorrect regex | Test regex with `echo "test" | grep "pattern"` |

## 9. Integration with Ansible
Scripts can complement your Ansible playbooks:
```yaml
- name: Run MySQL backup script
  hosts: db
  tasks:
    - name: Copy backup script
      copy:
        src: mysql_backup.sh
        dest: /home/osboxes/mysql_backup.sh
        mode: '0755'
    - name: Execute backup script
      command: /home/osboxes/mysql_backup.sh
```

## 10. Summary
This guide covers Bash scripting for automating tasks, using loops and conditionals, and processing text with `grep`. It’s tailored for your CentOS 9 environment, enhancing productivity for MySQL management and log analysis.



### Key Citations
- [Red Hat Enterprise Linux 9 Documentation](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9)
- [GeeksforGeeks: Bash Scripting](https://www.geeksforgeeks.org/bash-scripting/)


# CH02: Scheduling Future Tasks

## Scheduling One-Time Tasks with the "at" Command

### Goal
- Schedule tasks to automatically execute in the future.

### Objectives
- Set up a command that runs once at a specific point in the future.
- Schedule commands to run on a repeating schedule using a user's crontab file.
- Schedule commands to run on a repeating schedule using the system crontab file and directories.
- Enable and disable `systemd` timers, and configure a timer that manages temporary files.

---

### Scheduling One-Time Tasks with the `at` Command

- Use the `at TIMESPEC` command to schedule a new job. The `at` command reads the commands to execute from the stdin channel.
- When manually entering commands, finish your input by pressing `Ctrl+D`.
- For more complex commands, it's easier to use input redirection from a script file. For example:
  ```bash
  at now + 5min < myscript
  ```
  This method avoids typing all the commands manually in the terminal.

### TIMESPEC Argument in the `at` Command
- The `TIMESPEC` argument accepts powerful combinations to describe exactly when a job should run.
- Typically, it starts with a time (e.g., `02:00pm`, `15:59`, or even `teatime`), followed by an optional date or number of days in the future.

#### Examples of TIMESPEC Combinations:
- `now + 5min`
- `teatime tomorrow` (teatime is 16:00)
- `noon + 4 days`
- `5pm August 3 2021`

### Inspecting and Managing Deferred User Jobs
- To view pending jobs for the current user, use the `atq` command (or `at -i`).
  ```bash
  atq
  ```
  This lists the user's pending jobs. If the user is a superuser, it lists everybody's jobs.
  
  Format of output:
  ```
  Job number, date, hour, queue, username.
  ```

  Example:
  ```
  28 Mon Feb 2 05:13:00 2015 a user
  29 Mon Feb 3 16:00:00 2014 h user
  ```

#### Managing Jobs
- To delete a scheduled job, use the `atrm` command followed by the job number:
  ```bash
  atrm <job number>
  ```

---

## Creating and Managing "at" Jobs

### Basic Steps to Schedule an "at" Task
1. Use the `systemctl` command to check if the `atd` service is running:
   ```bash
   systemctl status atd
   ```
2. To create an "at" task, specify the time and command:
   ```bash
   at noon
   at> echo "Hello" >> /tmp/hello.txt
   Ctrl+D to save and exit
   ```
3. You can use a variety of time formats such as:
   - `now`
   - `1hour`
   - `6AM`
   - `tomorrow`
   - `4PM + 3days`
   - `10AM Jul 31`
   - `teatime`

### Viewing and Managing Jobs
- View scheduled jobs:
  ```bash
  atq
  ```
- Display job script:
  ```bash
  at -c <jobid>
  ```

### Important Files for "at" Jobs
- `/etc/at.allow`: Users listed here can use `at` commands.
- `/etc/at.deny`: Users listed here are denied from using `at`.
- `/var/spool/at/`: Contains the job scripts.

**Notes**:
- If both `at.allow` and `at.deny` files do not exist, all users are denied access to `at`.
- By default, the installation creates `at.deny`, allowing all users to use `at`.

---

## Recurring Jobs with Crontab

### Overview
- Recurring jobs execute tasks on a repeating schedule.
- The `crond` daemon (provided by the `cronie` package) manages recurring jobs. The `crond` daemon reads configuration files that define when and what tasks to run.
  
### Crontab Syntax
- Fields in the crontab file appear in the following order:
  - Minutes (0-59)
  - Hours (0-23)
  - Day of month (1-31)
  - Month (1-12 or Jan, Feb, etc.)
  - Day of week (0-6 or Sun, Mon, etc.)

### Basic Crontab Commands
- Create or edit a crontab for the current user:
  ```bash
  crontab -e
  ```
- List crontabs for the current user:
  ```bash
  crontab -l
  ```
- Remove all jobs for the current user:
  ```bash
  crontab -r
  ```

#### Example Crontab Job
- Run a backup script every Monday at 8:00 PM:
  ```bash
  0 20 * * 1 /root/Desktop/backup.sh
  ```

### Crontab File Locations
- `/etc/cron.d`: Place cron jobs here.
- `/etc/cron.deny`: Users listed here are denied from creating cron jobs.
- `/etc/cron.allow`: Users listed here are allowed to create cron jobs.
- `/var/spool/cron/`: Contains all user crontabs.
- `/etc/crontab`: Contains the system-wide crontab configuration.

---

## Managing Services with Systemd Timers

### Managing Temporary Files
- Some applications use `/tmp` for temporary data. Systemd manages temporary files with the `systemd-tmpfiles` tool.
- The command:
  ```bash
  systemd-tmpfiles --create --remove
  ```
  reads configuration files from:
  - `/usr/lib/tmpfiles.d/*.conf`
  - `/run/tmpfiles.d/*.conf`
  - `/etc/tmpfiles.d/*.conf`

#### Listing Systemd Timers
```bash
systemctl list-units --type=timer
```

#### Changing Timer Configuration
1. Copy the timer file:
   ```bash
   cp /usr/lib/systemd/system/sysstat-collect.timer /etc/systemd/system/sysstat-collect.timer
   ```
2. Edit the timer file:
   ```bash
   vi /etc/systemd/system/sysstat-collect.timer
   ```

3. After changes, reload the `systemd` configuration:
   ```bash
   systemctl daemon-reload
   ```

---

## Summary

- Deferred jobs are tasks scheduled to run once in the future.
- Recurring jobs are tasks that repeat on a regular schedule.
- `systemd` timers can execute both deferred and recurring jobs.

---

# CH03: Tuning System Performance

## Goal:
- Improve system performance by setting tuning parameters and adjusting the scheduling priority of processes.

## Objectives:
- Optimize system performance by selecting a tuning profile managed by the `tuned` daemon.
- Prioritize or de-prioritize specific processes using the `nice` and `renice` commands.

---

## Tuning the System

System administrators can optimize system performance by adjusting various device settings based on workload requirements. The `tuned` daemon applies tuning adjustments either statically or dynamically using tuning profiles designed for specific performance needs.

### Configuring Static Tuning:
- Static tuning involves predefined kernel parameters in profiles that are applied at runtime. 
- The parameters are set based on performance expectations and remain constant regardless of workload changes.

### Configuring Dynamic Tuning:
- Dynamic tuning, managed by the `tuned` daemon, continuously monitors system activity and adjusts settings dynamically based on real-time behavior. It starts with predefined settings in the chosen profile and adjusts them as necessary.

---

## Installing and Enabling Tuned

To install and enable the `tuned` package manually:
```bash
yum install tuned
systemctl enable --now tuned
```

---

## Selecting a Tuning Profile

The `tuned` application offers profiles divided into the following categories:
- **Power-saving profiles**: To save power.
- **Performance-boosting profiles**: To maximize performance. These include profiles focused on:
  - Low latency for storage and network
  - High throughput for storage and network
  - Virtual machine performance
  - Virtualization host performance

---

## Tuning Profiles Distributed with RHEL 9

| **Tuned Profile**           | **Purpose**                                                                 |
|-----------------------------|-----------------------------------------------------------------------------|
| `balanced`                  | Compromise between power saving and performance.                            |
| `desktop`                   | Faster response for interactive applications (derived from balanced).       |
| `throughput-performance`     | Maximum throughput for storage and network.                                |
| `latency-performance`        | Low latency for servers, sacrificing power consumption.                    |
| `network-latency`            | Adds low-latency tuning parameters to the latency-performance profile.      |
| `network-throughput`         | Focus on maximum network throughput, based on the throughput-performance profile. |
| `powersave`                  | Maximizes power savings.                                                   |
| `virtual-guest`              | Optimizes performance for virtual machines.                                |
| `virtual-host`               | Optimizes performance for virtualization hosts.                            |

---

## Managing Profiles with `tuned-adm`

The `tuned-adm` command is used to manage the `tuned` daemon. It can:
- Query current settings
- List available profiles
- Recommend a profile based on system characteristics
- Switch between profiles
- Deactivate tuning

### Examples:
1. **Check Active Profile**:
    ```bash
    tuned-adm active
    ```
    Example output:
    ```bash
    Current active profile: virtual-guest
    ```

2. **List Available Profiles**:
    ```bash
    tuned-adm list
    ```
    Example output:
    ```bash
    Available profiles:
    - balanced
    - desktop
    - latency-performance
    ```

3. **Switch Profiles**:
    ```bash
    tuned-adm profile throughput-performance
    tuned-adm active
    ```
    Example output:
    ```bash
    Current active profile: throughput-performance
    ```

4. **Get Profile Recommendation**:
    ```bash
    tuned-adm recommend
    ```
    Example output:
    ```bash
    virtual-guest
    ```

5. **Deactivate Tuning**:
    ```bash
    tuned-adm off
    tuned-adm active
    ```
    Example output:
    ```bash
    No current active profile.
    ```

---

## Creating Custom Tuning Profiles

Custom tuning profiles can be created to tailor performance for specific workloads.

### Example: Create a Web Server Profile
```bash
mkdir /usr/lib/tuned/web-server
cd /usr/lib/tuned/web-server
touch tuned.conf
vim tuned.conf
```

Contents of `tuned.conf`:
```
[main]
summary=Optimize for web server
include=throughput-performance

[script]
script=custom-script.sh
```

Create the custom script:
```bash
touch custom-script.sh
chmod +x custom-script.sh
vim custom-script.sh
```

Contents of `custom-script.sh`:
```bash
#!/bin/bash
echo "Custom tuned profile for web-server" >> /var/log/custom_script.log
```

Activate the profile:
```bash
tuned-adm list
tuned-adm profile web-server
tuned-adm active
```

Deactivate the profile:
```bash
tuned-adm off
systemctl disable --now tuned
```

---

## Linux Process Scheduling and Multitasking

Linux handles process multitasking using a **time-slicing** technique. The **process scheduler** within the Linux kernel is responsible for switching between processes.

- Processes have 40 different levels of **niceness**, ranging from `-20` (highest priority) to `19` (lowest priority).
- Default nice level is `0`, inherited from the parent process.
- **Root users** can set negative nice levels, while **non-root users** can only set positive nice levels for processes they own.

### View Process Niceness:
```bash
ps axo user,pid,nice,command
ps axo --sort=nice
```

---

## Setting Process Priority Using `nice` and `renice`

1. **Start a Process with a Specific Niceness Level**:
   ```bash
   nice -n 10 vim text &
   ```

2. **Change the Niceness of a Running Process**:
   ```bash
   renice 19 9182  # Changes the nice value of process 9182 to 19
   ```

3. **Use `top` to Renice**:
   - Open `top`
   - Press `r` to renice a process.

---

## Summary

- **`tuned`** is a daemon used to optimize system performance using predefined or custom tuning profiles.
- **Linux process niceness** allows users to control the priority of processes to balance system resources.

---

<<<<<<< HEAD
 # CH04: Controlling Access to Files with ACLs
=======
# CH04: Controlling Access to Files with ACLs
>>>>>>> 0cc62acef8126efc964bc44b2282d7b8e2b0f07b

## Goal
- Interpret and set Access Control Lists (ACLs) on files to handle situations requiring complex user and group access permissions.

## Objectives
- Describe use cases for ACLs, identify files that have ACLs set, and interpret the effect of those ACLs.
- Set and remove ACLs on files and define default ACLs automatically set by a directory on newly created files.

---

## Access Control List (ACL)

Access Control Lists (ACLs) provide an additional flexible permission mechanism for the file system on a Linux system. They enhance traditional UNIX file permissions for files and folders. With ACLs, you can give permissions for any user or group with fine-grained access rights.

ACLs can be configured per user, per group, or via the effective rights mask. These permissions can then be applied to an individual user or group, similar to the `rwx` (Read, Write, Execute) permissions found in regular file or folder permissions.

### Check Kernel for ACL Support

To check if the file system and kernel support ACLs, use the following command:
```bash
grep -i acl /boot/config*
```
You should see output like this:
```bash
CONFIG_XFS_POSIX_ACL=y
CONFIG_BTRFS_FS_POSIX_ACL=y
```
If you see `N` instead of `Y`, the kernel does not support ACLs, and it may need to be recompiled.

---

## Viewing and Interpreting ACL Permissions

The `ls -l` command only outputs minimal ACL setting details:
```bash
ls -l reports.txt
```
Example output:
```bash
-rwxrw----+ 1 user operators 130 Mar 19 23:56 reports.txt
```
The plus sign (`+`) at the end of the permission string indicates that an extended ACL structure exists on this file.

To display ACL settings on a file, use the `getfacl` command:
```bash
getfacl reports.txt
```
Example output:
```bash
# file: reports.txt
# owner: user
# group: operators
user::rwx
user:consultant3:---
user:1005:rwx         #effective:rw-
group::rwx            #effective:rw-
group:consultant1:r--
group:2210:rwx        #effective:rw-
mask::rw-
other::---
```

### Key Points:

1. **User Entries:**
   - `user::rwx`: The file owner (`user`) has `rwx` permissions.
   - `user:consultant3:---`: The user `consultant3` has no permissions.
   - `user:1005:rwx`: The user with UID `1005` has `rwx`, but the mask limits it to `rw-`.

2. **Group Entries:**
   - `group::rwx`: The group owner (`operators`) has `rwx`, but the mask limits it to `rw-`.
   - `group:consultant1:r--`: The group `consultant1` has `r` permissions only.
   - `group:2210:rwx`: The group with GID `2210` has `rwx`, but the mask limits it to `rw-`.

3. **Mask Entry:**
   - `mask::rw-`: The mask defines the maximum permissions possible for named users, the group owner, and named groups. The mask does not restrict the file owner's permissions.

4. **Other Entry:**
   - `other::---`: All other users and groups have no permissions.

---

## ACL Permission Precedence

- **ACL Mask:**
  - The ACL mask defines the maximum permissions that can be granted to named users, the group owner, and named groups. It does not affect the file owner's or the "other" entry's permissions. The mask can be set explicitly with `setfacl` or will be automatically added if not set.

- **Permission Precedence:**
  When determining file access:
  1. If the process is run by the file owner, the owner's ACL permissions apply.
  2. If the process is run by a user listed in a named user ACL entry, the named user ACL permissions apply (limited by the mask).
  3. If the process is run by a group that matches the group owner or a named group, the group ACL permissions apply (limited by the mask).
  4. If none of the above match, the "other" ACL permissions apply.

---

## Setting ACLs

Use the `setfacl` command to set or modify ACLs on any file or directory.

Examples:
```bash
setfacl -m u:karim:rw file.txt    # Set read and write for user karim
setfacl -m g:sales:rw dir1        # Set read and write for group sales
setfacl -R -m g:sales:rw dir1     # Apply recursively to dir1
setfacl -m u::rwx,g:consultants:rx,o::- file.txt    # Multiple entries in one command
```

You can use the output of `getfacl` as input for `setfacl` to copy ACL settings from one file to another:
```bash
getfacl file-A | setfacl --set-file=- file-B
```

---

## Backup and Restore ACLs

1. **Backup ACLs:**
   ```bash
   getfacl reports.txt > acl_backup.txt
   ```

2. **Restore ACLs:**
   ```bash
   setfacl --set-file=acl_backup.txt reports.txt
   ```

3. **Backup and Restore in One Command:**
   ```bash
   getfacl reports.txt | setfacl --set-file=- file2.txt
   ```

---

## Removing ACLs

To remove ACL permissions for a user or group, use the `-x` option. To remove all ACLs and reset to default permissions, use the `-b` option.

Examples:
```bash
setfacl -x u:karim file.txt       # Remove ACL for user karim
setfacl -b file.txt               # Roll back to default ACL
```

---

## Setting Default ACLs and Recursive Application

1. **Set default ACLs:**
   ```bash
   setfacl -m d:u:mohamed:rw- dir1    # Set default permissions for all files created inside dir1
   ```

2. **Apply ACLs recursively:**
   ```bash
   setfacl -R -m u:mohamed:rw dir2    # Apply permissions recursively to dir2
   ```

---

## Summary

- ACLs provide fine-grained access control to files and directories beyond traditional UNIX permissions.
- The `getfacl` command displays ACL settings.
- The `setfacl` command sets, modifies, and removes ACLs on files and directories.


# CH05: Managing SELinux Security

## Goal
Protect and manage the security of a server by using SELinux.

## Objectives
- Describe how SELinux protects resources and how to select the enforcement mode
- Configure a file's SELinux context to control how processes interact with that file
- Configure SELinux booleans to allow runtime policy changes for varying access needs
- Investigate SELinux log messages and troubleshoot SELinux AVC denials

![Managing_SELinux_security](./Image2/Managing_SELinux_security.png)

## Why Use Security Enhanced Linux?

### Background
Security Enhanced Linux (SELinux) is an additional layer of system security with the primary goal of protecting user data from compromised system services.

### Key Differences from Traditional Security Model
- Traditional Model: Discretionary Access Control (user/group/other permissions)
- SELinux Model: Mandatory Access Control (object-based, more sophisticated rules)

### Security Risks Without SELinux
- Opening firewall ports for web servers can create exploitation opportunities
- Compromised web server processes gain full permissions of the web server user/group
- Potential unauthorized access to:
  - Document root (/var/www/html)
  - Temporary directories (/tmp, /var/tmp)
  - World-writable files and directories

## SELinux Contexts

### What is a Context?
- A special security label determining process access to files, directories, and ports
- Default policy: No interaction allowed without explicit rule
- Contexts include: user, role, type, and sensitivity
- Targeted policy (default in Red Hat Enterprise Linux) uses type context

### Context Naming Conventions
- Type context names usually end with `_t`
- Example context: `unconfined_u:object_r:httpd_sys_content_t:s0`
  - SELinux User
  - Role
  - Type
  - Level

### Example Contexts
- Web Server Process: `httpd_t`
- Web Server Files: `httpd_sys_content_t`
- Temporary Files: `tmp_t`
- Web Server Ports: `http_port_t`
- MariaDB Server: `mysqld_t`
- MariaDB Files: `mysqld_db_t`

### Useful Commands for Context Management
- Commands with `-Z` option for context display/setting:
  - `ps axZ`
  - `ps -ZC httpd`
  - `ls -Z /home`
  - `ls -Z /var/www`

## SELinux Modes

### 1. Enforcing Mode
- SELinux enforces policies
- Denies access to actions violating policies

### 2. Permissive Mode
- Logs policy violations
- Does not enforce policies
- Useful for testing and troubleshooting

### 3. Disabled Mode
- SELinux completely turned off
- No system security impact

### Mode Management Commands
- Check current mode: `getenforce`
- Check status: `sestatus`
- Change mode: `setenforce [enforcing | permissive]`
- Configuration file: `/etc/selinux/config`

## Initial SELinux Context

### Context Inheritance
- New files typically inherit context from parent directory
- Inheritance can be disrupted by:
  1. Creating file in one location, moving to another
  2. Copying files with preserved context

## Changing SELinux Context

### Recommended Methods
1. **semanage fcontext**: Declare default file labeling
2. **restorecon**: Apply context from parent
3. **chcon**: Temporary context changes (not recommended for permanent modifications)

### Context Change Commands
- `ls -lZ`: List files with contexts
- `chcon -t <context_type> <filename>`: Change context type
- `restorecon -v <filename>`: Restore default context

## Example Workflow
```bash
# Install Apache
dnf install httpd

# Enable web server
systemctl enable --now httpd

# Create file in web root
cd /var/www/html
touch index.html

# View contexts
ls -lZ index.html
ls -ldZ /var/www/html

# Move/Copy files (note context behavior)
mv file1 /var/www/html/ # maintain original content label
cp file2 /var/www/html/
cp -a file3 /var/www/html/ # maintain original content label


chcon -t httpd_sys_content_1file1

restorecon -v file3

ls -lz

#dir example

mkdir /virtual

ls -ldz /virtual
chcon -t httpd_sys_content_t:s0

restorecon -v /virtual # resture default context form data base
```


## SELinux: Managing Default File Context Rules, Ports, and Booleans

### Defining SELinux Default File Context Rules

#### Useful Commands for Managing File Contexts
| Command | Description |
|---------|-------------|
| `-a, --add` | Add a record of the specified object type |
| `-l, --list` | List records of the specified object type |
| `-d, --delete` | Delete a record of the specified object type |

#### Example: Ensuring Correct File Contexts for a Directory
```bash
semanage fcontext -l
restorecon -Rv /var/www/
```

#### Practical Example: Configuring SELinux for `/virtual`
```bash
semanage fcontext -a -t httpd_sys_content_t '/virtual(/.*)?'
semanage fcontext -l | grep -w /virtual
restorecon -Rv /virtual
```

#### Example: Configuring Apache to Use `/virtual`
```bash
mkdir /virtual
cd /virtual

semanage fcontext -a -t httpd_sys_content_t '/virtual(/.*)?'
semanage fcontext -l | grep -w /virtual
restorecon -Rv /virtual

vi /etc/httpd/conf/httpd.conf
# Modify:
# DocumentRoot "/var/www/html" --> DocumentRoot "/virtual"
# <Directory "/var/www/html"> --> <Directory "/virtual">

systemctl restart httpd

vi index.html  # Add content for the webpage
```

#### Deleting Context and Rolling Back Apache Configuration
```bash
semanage fcontext -d -t httpd_sys_content_t '/virtual(/.*)?'
semanage fcontext -l | grep -w /virtual
restorecon -Rv /virtual

vi /etc/httpd/conf/httpd.conf
# Rollback:
# DocumentRoot "/virtual" --> DocumentRoot "/var/www/html"
# <Directory "/virtual"> --> <Directory "/var/www/html">
```

---

### Changing the Default Port for `sshd`

#### Configuring SELinux for SSH Port Changes
1. Modify `/etc/ssh/sshd_config`:
    ```bash
    vi /etc/ssh/sshd_config
    # Change port:
    # Port 22 --> Port 9999
    ```

2. Restart `sshd`:
    ```bash
    systemctl restart sshd
    ```
   If it fails, check logs:
   ```bash
   journalctl -xeu sshd.service
   less -f /var/log/audit/audit.log
   ```

3. Update SELinux for the new port:
    ```bash
    semanage port -a -t ssh_port_t -p tcp 9999
    ```

4. Verify and troubleshoot:
    ```bash
    semanage port -l | grep ssh
    ```

5. Delete unused ports:
    ```bash
    semanage port -d -t ssh_port_t -p tcp 9999
    ```

---

### SELinux Booleans


#### Overview
- SELinux Booleans are switches that modify policy behavior.
- Use `getsebool` and `setsebool` commands to manage booleans.
- `setsebool -P` makes changes persistent across reboots.

![SELinux_Booleans](Image2/SELinux_Booleans.png)

#### Example: Managing Web Server Boolean
```bash
getsebool httpd_can_network_connect_db  # Check the state
setsebool httpd_can_network_connect_db on  # Enable the boolean
semanage boolean -l | grep httpd_can_network_connect_db  # Verify status
```

---

### Troubleshooting SELinux Issues

#### Installing `setroubleshoot-server` for Logs
```bash
rpm -qa | grep setroubleshoot-server  # Verify installation
yum install setroubleshoot-server    # Install if not present
```

#### Generating Reports
- Use `sealert` for detailed incident reports:
    ```bash
    sealert -a /var/log/audit/audit.log  # Analyze all incidents
    sealert -l <UUID>                   # Report for a specific UUID
    ```

#### Practical Example: Resolving Access Issues
```bash
touch myweb
ls -lZ myweb

mv myweb /var/www/html/
ls -lZ /var/www/html/

curl http://localhost/myweb  # If it fails:
tail /var/log/audit/audit.log
tail /var/log/messages

restorecon -v /var/www/html/myweb  # Fix the file context
```

---

## **Cockpit: A Web Interface for Linux Administration and SELinux Management**

**Cockpit** is a powerful web-based interface for managing Linux systems. It enables administrators to monitor resources, manage services, and troubleshoot SELinux and other system-related issues efficiently through a user-friendly interface.

---

### **Key Features of Cockpit**
1. **Real-Time System Monitoring**:
   - CPU, memory, disk, and network usage are displayed in real-time.
   - Interactive graphs for performance tracking.
2. **Service and Process Management**:
   - Start, stop, restart, enable, or disable services directly from the interface.
   - Manage running processes with tools to inspect or terminate them.
3. **SELinux Troubleshooting**:
   - View and analyze SELinux violations.
   - Modify file contexts, ports, and booleans with guided suggestions.
4. **Log Viewer**:
   - Access system logs for audit and error tracking.
   - Filter logs for SELinux-related errors or other specific events.
5. **User Management**:
   - Add, remove, or modify system users and permissions.
6. **Terminal Access**:
   - Integrated terminal for command-line operations within the browser.

---

### **Installation and Setup**

#### Install Cockpit:
1. Use the package manager to install:
   ```bash
   sudo yum install cockpit
   ```
2. Start and enable the Cockpit service:
   ```bash
   sudo systemctl start cockpit
   sudo systemctl enable cockpit
   ```
3. Open the firewall for Cockpit's web interface:
   ```bash
   sudo firewall-cmd --add-service=cockpit --permanent
   sudo firewall-cmd --reload
   ```

#### Access the Cockpit Web Interface:
1. Open a browser and navigate to:
   ```
   https://<your-server-ip>:9090
   ```
2. Log in with your system administrator credentials.

---

### **Using Cockpit for SELinux Management**

#### 1. **SELinux Troubleshooter**
   - Navigate to the **SELinux** module to review any reported policy violations.
   - The interface lists:
     - Denied actions.
     - Violated SELinux rules.
     - Suggested fixes with explanations.
   - Apply recommended fixes directly from Cockpit or copy the commands for CLI use.

#### 2. **File Context Management**
   - View and modify SELinux file contexts.
   - Add new context rules for files and directories, ensuring compatibility with SELinux policies.
   - Apply the changes using:
     ```bash
     restorecon -Rv <directory>
     ```

#### 3. **Port Management**
   - Display SELinux rules for active ports.
   - Add or delete allowed ports for services like HTTP (`http_port_t`) or SSH (`ssh_port_t`).
   - Example:
     ```bash
     semanage port -a -t http_port_t -p tcp 8080
     ```

#### 4. **Boolean Management**
   - View and toggle SELinux booleans to adjust service permissions dynamically.
   - Make changes persistent with the click of a button or the following command:
     ```bash
     setsebool -P <boolean_name> <on|off>
     ```

---

### **Example: Troubleshooting SELinux Issues with Cockpit**

1. **Analyzing SELinux Denials**:
   - Access the **Logs** section in Cockpit.
   - Look for AVC denial messages or use the search feature to filter SELinux-related events.
   - Copy the UUID of a specific denial.

2. **Viewing Recommendations**:
   - Open the **SELinux Troubleshooter**.
   - Enter the UUID to analyze the issue and see recommended fixes.
   - Example fixes might include modifying file contexts or adjusting SELinux booleans.

3. **Applying Fixes**:
   - Apply fixes directly through Cockpit or execute the commands manually:
     ```bash
     restorecon -v <file_or_directory>
     setsebool -P <boolean_name> <on|off>
     ```

---

### **Benefits of Using Cockpit for SELinux Management**

- **Ease of Use**: A graphical interface reduces the complexity of CLI commands.
- **Centralized Management**: Manage multiple aspects of the system from a single dashboard.
- **Time Efficiency**: Built-in recommendations and troubleshooting tips save time during debugging.
- **Accessibility**: Available via web browser without requiring additional software on the client side.

Cockpit is particularly useful for administrators managing SELinux policies and troubleshooting issues, offering an intuitive alternative to traditional command-line methods.