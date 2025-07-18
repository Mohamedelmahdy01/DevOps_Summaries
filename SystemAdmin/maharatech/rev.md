# Linux Commands and Concepts

## File Operations

### Listing Files
- **ls -ltr** : List files with detailed info (long format) sorted by modification time, reversed.

### Creating Directories
- **mkdir -p dir1/dir2/dir3** : Create nested directories.

## Links

### Hard Link
- A hard link is another name for a file (refers to actual data).
- **ln <File> <HardLinkName>** : Create a hard link.

### Soft Link
- A soft link is a reference or pointer (like shortcuts in Windows).
- **ln -s <File> <SoftLinkName>** : Create a soft link.
- **ls -li** : Show inode number along with the list of files.

## Pattern Matching

### Symbols:
- **\*** : Matches any string of zero or more characters.
- **?** : Matches any single character.
- **[abc...]** : Matches any one character in the enclosed class.
- **[!abc...]** or **[^abc...]** : Matches any one character not in the enclosed class.

### Character Classes:
- **[[:alpha:]]** : Any alphabetic character.
- **[[:lower:]]** : Any lowercase character.
- **[[:upper:]]** : Any uppercase character.
- **[[:alnum:]]** : Any alphabetic character or digit.
- **[[:punct:]]** : Any printable character not a space or alphanumeric.
- **[[:digit:]]** : Any digit (0-9).
- **[[:space:]]** : Any single whitespace character (tabs, newlines, etc.).

## Basic Regular Expressions

- **.** : Matches any character.
- **^** : Matches the start of a string.
- **$** : Matches the end of a string.
- **\*** : Matches zero or more occurrences of the previous character.
- **\** : Escapes special characters.
- **()** : Groups regular expressions.
- **?** : Matches exactly one character.

## `cut` Command

- The `cut` command is used for cutting out sections from each line of a file and writing the result to standard output.
- **cut -d ":" -f 1,7 /etc/passwd** : Cut fields 1 and 7 using ":" as a delimiter.

## `wc` Command

- **echo "I Love Linux" | wc** : Counts words, lines, and characters in the input.

## Environment Variables

### Shell Variables:
- **set** : Lists all shell variables.

### Common Variables:
- **echo $HISTSIZE** : Shows the history size.
- **echo $HOME** : Shows the home directory.

### Modifying `PATH`:
- **PATH=PATH:/home/mohamed** : Append `/home/mohamed` to the `PATH`.

### Exporting Variables:
- **export <variables>** : Exports variables to child processes.

### Listing Environment Variables:
- **env** : List all environment variables.

## Managing Users and Groups

### Superuser and User IDs:
- **Superuser (UID: 0)**
- **System users (UID: 1–200 statically, 201–999 dynamically)**
- **Regular users (UID: 1000+)**

### User Commands:
- **whoami** : Show current username.
  
#### Switching Users:
- **su** : Switch to another user without changing the working directory.
- **su -** : Switch to another user and change the working directory.

### `sudo` Command:
- Allows a permitted user to execute a command as the superuser.
- **vim /etc/sudoers** : Edit the sudo configuration file using `visudo`.

#### Example `sudoers` Entries:
- **user01 ALL=(ALL) ALL** : Grant full sudo access to user01.
- **%group01 ALL=(ALL) ALL** : Grant full sudo access to group01.

### Adding and Modifying Users:
- **useradd <username>** : Add a new user.
- **useradd -md /home/user_1 -c "Planning user" -s /bin/sh -g mohamed -G wheel -u 5000 user01** : Add a user with options.
- **usermod <username>** : Modify an existing user.
  - **usermod -aG <group> <username>** : Add the user to a secondary group.
  - **usermod -L <username>** : Lock the user.
  - **usermod -U <username>** : Unlock the user.
- **userdel <username>** : Delete a user.
- **userdel -r <username>** : Delete a user and their home directory.

### Group Commands:
- **groupadd <groupname>** : Add a new group.
- **groupmod -n <newgroup> <oldgroup>** : Rename a group.
- **groupdel <groupname>** : Delete a group.

## Managing User Passwords

### `/etc/shadow` File Format:
- **(1)** Username
- **(2)** Encrypted password
- **(3)** Last password change (days since 1/1/1970)
- **(4)** Minimum number of days between password changes
- **(5)** Maximum number of days before password expires
- **(6)** Password warning period (days)
- **(7)** Inactivity period (days after password expires before account is locked)
- **(8)** Account expiration date (days since 1/1/1970)
- **(9)** Reserved for future use.

### Configuring Password Aging:
- **chage -m 0 -M 90 -W 7 -I 14 user03** : Set password aging parameters.
  - **-m** : Minimum days between password changes.
  - **-M** : Maximum days before password expires.
  - **-W** : Warning period (days before password expires).
  - **-I** : Inactive days after password expires before account is locked.

# Controlling Access to Files

## File Types
- **d** : Directory
- **-** : File
- **c** : Character device file
- **b** : Block device file
- **l** : Link file
- **p** : Pipe file

### File Permission Example
`-rwxr-x--- 1 root root 0 oct 31 11:06 test`

## Change Permissions of Files and Directories (Symbolic Method)

### Symbols:
- **u** : User
- **g** : Group
- **o** : Others
- **a** : All (User, Group, and Others)
- **r** : Read
- **w** : Write
- **x** : Execute

#### Usage:
- `chmod o-w <filename>` : Remove write permission for others.
- `chmod a+rwx test` : Add read, write, and execute permission for all.
- `chmod u+rwx, g=rx, o-wx test` : Set permissions for `test` file.

## Change Permissions of Files and Directories (Numeric Method)

### Numeric Permissions:
| Value | Binary | Meaning       |
|-------|--------|---------------|
| 7     | 111    | rwx (read, write, execute) |
| 6     | 110    | rw- (read, write)          |
| 5     | 101    | r-x (read, execute)        |
| 4     | 100    | r-- (read only)            |
| 3     | 011    | -wx (write, execute)       |
| 2     | 010    | -w- (write only)           |
| 1     | 001    | --x (execute only)         |

#### Usage:
- `chmod 777 test` : Give full permissions to user, group, and others.

## Change Ownership
- `chown mohamed file1` : Change ownership to `mohamed`.
- `chown mohamed:mohamed file1` : Change both owner and group.
- `chown :mohamed file1` : Change group ownership only.
- `chgrp mohamed file1` : Change group ownership.

#### Recursive Ownership Change:
- `chown -R root:root file1` : Change owner and group ownership for directory and its files.

## Special Permissions
- **Setuid**: `chmod u+s file1` or `chmod 4xxx file1`
- **Setgid**: `chmod g+s dir1` or `chmod 2xxx dir1`
- **Sticky bit**: `chmod o+t dir1` or `chmod 1xxx dir1`

## Searching Files
- `which <file>` : Search for a file in the system's PATH.
- `locate <file>` : Search for a file in the database.
- `updatedb` : Update the file location database.

## Default File Permissions (umask)
- `umask` : Display the current umask value.
  - Root user default: `0022`
  - Regular user default: `0002`
  
| Decimal | Binary   | Reverse | Symbolic (Directory) | Symbolic (File) |
|---------|----------|---------|----------------------|-----------------|
| 0 2 2   | 000 010  | 111 101 | rwx r-x r-x           | rw- r-- r--      |
| 0 0 2   | 000 000  | 111 111 | rwx rwx r-x           | rw- rw- r--      |

- `umask 007` : Set the umask to block permissions for others.

#### Notes:
- `.bashrc` : Works every time a new bash shell is opened.
- `.bash_profile` : Works once when you log in.

---

# Monitoring and Managing Linux Processes

## Process Information
- **PID** : Process ID
- **PPID** : Parent Process ID

#### Commands:
- `whoami` : Display the effective user.
- `ps aux` : Display all processes.
- `ps lax` : Long listing with technical details.
- `top` : Dynamic view of the system’s processes (similar to Task Manager in Windows).
- `pstree` : Display all processes as a tree.
  - `pstree -p` : Display processes with PID.
  - `pstree -p mohamed` : Display processes of a specific user.

## Managing Background Processes
- `<command> &` : Run a command in the background.
- `jobs` : List processes running in the background.
- `fg %<job number>` : Return a process to the foreground.

## Killing Processes
- `kill <PID>` : Kill a process by its ID.
- `kill -l` : List all kill signals.
- `kill -15 <PID>` : Default kill signal.
- `kill -9 <PID>` : Aggressive termination of a process.

## Process Scheduling and Priorities
- **Nice value** : Priority of the process (from -20 to 19).
  
#### Commands:
- `ps lax | less` : List processes with nice values.
- `nice -n 10 vim text &` : Start a process with a nice value of 10.
- `renice <nice value> <PID>` : Change the priority of a running process.
- `renice 19 $(pgrep sleep)` : Set the nice value of all sleep processes to 19.
  
---

# Controlling Services and Daemons

## Systemd Commands
- `systemctl list-units --type=service` : List all active services.
- `systemctl list-units --type= --all` : List all services (active and inactive).
- `systemctl --failed --type=service` : List failed services.
- `systemctl status <service>` : View the status of a specific service.
  - Example: `systemctl status sshd.service`
- `systemctl start/stop/restart <service>` : Start, stop, or restart a service.
- `systemctl reload <service>` : Reload the configuration file for a service.
- `systemctl enable/disable <service>` : Enable or disable a service at boot.
- `systemctl mask/unmask <service>` : Mask or unmask a service to prevent/allow starting.

---

# SSH Configuration and Security

## SSH Commands
- `ssh <username>@<remotehost>` : Create a remote interactive shell.
- `ssh <student>@<serverb> <hostname>` : Run a command on a remote server without accessing the shell.
- `ssh <username>@<remotehost> 'date; ls -lh'` : Execute multiple commands remotely without opening a shell.

## SSH Authentication Types
1. **Password authentication**
2. **Key-based authentication**

## Key-based Authentication
- `ssh-keygen` : Create a private key and matching public key for authentication.
  - Private key: `~/.ssh/id_rsa`
  - Public key: `~/.ssh/id_rsa.pub`
- `ssh-copy-id -i ~/.ssh/id_rsa.pub mohamed@192.168.1.10` : Copy the public key to the remote host.
- **Permissions**:
  - Private key permissions: `600`
  - Public key permissions: `644`

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

### CH1 - Improving Command-line Productivity

#### What, Why, and When to Use Shell Scripts?

**Goal:**
- Run commands more efficiently using advanced Bash shell features, shell scripts, and various utilities from Red Hat Enterprise Linux.

**Objectives:**
- Automate command sequences with shell scripts.
- Run commands over lists or items efficiently using `for` loops and conditionals.
- Use `grep` and regular expressions to find matching text patterns in logs or command output.

#### What is a Shell Script?
- A script is a list of system commands stored in an executable file.
- Saves time by avoiding retyping sequences of commands.

#### Why Shell Scripting?
- Essential for Linux system administration (e.g., setting up services at boot with `/etc/rc.d` scripts).
- Simple and straightforward syntax.
- Scripts can be built in sections, with only a few operators to learn.

#### When Not to Use Shell Scripts?
Avoid shell scripts for:
- Resource-intensive tasks (e.g., sorting, recursion).
- Complex mathematical operations (use C++/FORTRAN).
- Multi-dimensional arrays.
- Graphics/GUIs.
- Direct system hardware access.
- Using external libraries (consider Perl, Python, Ruby, or C/C++).

#### Tips for Writing Effective Bash Scripts:
- Use comments.
- Ensure scripts exit when they fail.
- Exit when using undeclared variables.
- Use double quotes when referencing variables.
- Use functions and perform debugging.
- Make variable and function names descriptive.

---

### What is a Sha-Bang (`#!`)?
- The sha-bang (`#!`) at the top of a script tells the system which interpreter to use.
- Example: `#!/bin/bash` specifies the Bash interpreter.
- The path after `#!` must be correct, or the script will fail.

### Invoking the Script:
- Use `sh scriptname` or `bash scriptname` to run a script.
- Alternatively, use `chmod +x scriptname` to make it executable, then run it with `./scriptname`.

---

### Providing Output from a Shell Script
- Use `which <command>` to find the location of a command.
  - Example: `which bash` returns `/usr/bin/bash`.

#### Writing a Simple "Hello, World!" Script:
1. Create the file:
   - `touch hello.sh`
   - `vim hello.sh`
   ```bash
   #!/bin/bash
   echo "Hello, World!"
   ```
   - Save and exit (`:wq`).

2. Make it executable:
   - `chmod +x hello.sh`

3. Run the script:
   - `./hello.sh`

---

### Writing an Effective Backup Script:
1. Create the file:
   - `touch backup.sh`
   - `vim backup.sh`
   ```bash
   #!/bin/bash
   tar -cf etc_backup.tar /etc
   scp etc_backup.tar root@192.168.1.2:/backup
   rm -rf etc_backup.tar
   ```
   - Save and exit (`:wq`).

2. Make it executable and run:
   - `chmod +x backup.sh`
   - `./backup.sh`

---

### Quoting Special Characters in Bash

Use `\`, `'`, or `"` to remove special meanings from characters:
- `\` escapes special meaning for the next character.
  - Example: `echo \# not a comment` will output `# not a comment`.
- Single quotes (`'`) prevent variable substitution.
- Double quotes (`"`) allow variable substitution.

---

### Special Characters and Operators in Bash:
- `.` (dot): Represents the current directory or matches any single character in regex.
- `$`: Refers to variables or marks the end of a line in regex.
- `*`: Wildcard for filename expansion or multiple characters in regex.
- `?`: Wildcard for single-character filename expansion or one character in regex.
- `()` and `{}`: Used for command grouping and brace expansion.
- `>` and `>>`: Redirect output (overwrite or append).
- `|` (pipe): Pass output from one command as input to another.

---

### Loops in Bash

#### `for` Loop:
- Iterates over a list of items.
```bash
for item in list
do
  command
done
```
Example:
```bash
for number in 1 2 3 4 5
do
  echo -n "$number"
done
# Outputs: 12345
```

#### `while` Loop:
- Runs as long as the condition is true.
```bash
i=1
while [ $i -le 10 ]
do
  echo $i
  i=$((i+1))
done
```

#### `until` Loop:
- Runs until the condition becomes true.
```bash
i=1
until [ $i -gt 10 ]
do
  echo $i
  i=$((i+1))
done
```


### Exit and Exit Status
- **Exit Command**: Terminates a script and can return a value to the parent process. If no value is returned, the status of the last executed command is used.
- **Exit Status**: A successful command returns `0`, while an unsuccessful one returns a non-zero value.
- **$?**: Used to check the return value of the last executed command.

### Testing Script Inputs
- **Test Constructs**: Bash uses `if`, `test`, `[` (synonym for `test`), and `[[` (extended test) for condition testing.
- **Conditional Statements**: Includes `if-else`, `if-elif-else`, and nested `if` statements.
  
  Example:
  ```bash
  x=5; y=10
  if [ $x -gt $y ]; then 
      echo "X is greater than y"
  else
      echo "X is lower than y"
  fi
  ```

### Loop and Condition Examples
- **For Loops**: Example provided on creating a backup script using loops, conditions, and `tar` for archiving directories.
  
  ```bash
  for dir in /etc /home /tmp
  do
      [ ! -d $dir ] && echo "$dir does not exist" && continue
      tar -cf "$dir"_backup.tar $dir
      # Add further conditions and actions
  done
  ```

### Regular Expressions and `grep`
- **Regex Symbols**: Basic regex symbols used for matching patterns in text (e.g., `.`, `^`, `$`, `*`, etc.).
- **Examples with `grep`**: Demonstrates pattern matching using `grep`, such as finding words that start or end with a specific pattern.

### Summary
- This chapter covers Bash scripting fundamentals, including command execution, loops, condition testing, and using regular expressions for searching text.

This section outlines various methods to schedule tasks on Linux systems, either for a one-time execution or for repeated intervals. Here's a summary of the main concepts:

# **Scheduling One-Time Tasks with the `at` Command**
- **`at` Command Usage**: The `at` command allows scheduling tasks to run once at a specific time. You provide a **TIME SPEC** (like "now +5min", "noon", or "tomorrow 4PM") to specify when the task should be executed.
    - Example: `at now +5min` will execute the given command 5 minutes from now.
    - Commands to be executed are entered into the `at` command interface, followed by **Ctrl+D** to save.
- **Manage Jobs**:
    - Use `atq` to view scheduled jobs.
    - Use `atrm <job_id>` to remove a scheduled job.
    - Check the process running `systemctl status atd`.

## **Recurring Tasks with `crontab`**
- **`crontab` Command**: This command is used to schedule recurring jobs. It follows a specific format where the user specifies **minute**, **hour**, **day of the month**, **month**, **day of the week**, and the **command** to be run.
    - Example: `0 20 * * 1 /root/Desktop/backup.sh` will run a backup script every Monday at 8 PM.
    - **Crontab Commands**:
        - `crontab -e`: Open the crontab editor.
        - `crontab -l`: List all jobs for the current user.
        - `crontab -r`: Remove all jobs for the current user.
    - **Backup Crontab**:
        - Use `crontab -l > crontab_backup` to backup.
        - Restore using `crontab crontab_backup`.

## **System-Wide Cron Jobs**
- System administrators can manage recurring tasks that affect the whole system by placing scripts in directories like:
    - **`/etc/cron.daily`**: For daily tasks.
    - **`/etc/cron.monthly`**: For monthly tasks.
    - **`/var/spool/cron`**: Contains crontabs for individual users.
    - **`/etc/crontab`**: System-wide cron tasks.

## **Managing Temporary Files with `systemd-tmpfiles`**
- **systemd-tmpfiles**: A service that manages temporary files. It automatically cleans up old or unnecessary files, ensuring system directories like `/tmp` do not fill up over time.
    - You can view the configuration with `systemctl cat systemd-tmpfiles-clean.timer`.
    - To edit timers, copy the existing timer file to `/etc/systemd/system/` and modify it.

## **Key Files for `at` and `cron` Jobs**
- **For `at`**:
    - **`/etc/at.allow`** and **`/etc/at.deny`**: Files that control which users are allowed or denied from using the `at` command.
    - **`/var/spool/at/`**: Holds scheduled jobs.
- **For `cron`**:
    - **`/etc/cron.allow`** and **`/etc/cron.deny`**: Files that control access to the `cron` command.
    - **`/etc/cron.d`**: Contains system-wide cron jobs.
    - **`/var/spool/cron`**: Stores individual user cron jobs.

---

=======
# Linux Commands and Concepts

## File Operations

### Listing Files
- **ls -ltr** : List files with detailed info (long format) sorted by modification time, reversed.

### Creating Directories
- **mkdir -p dir1/dir2/dir3** : Create nested directories.

## Links

### Hard Link
- A hard link is another name for a file (refers to actual data).
- **ln <File> <HardLinkName>** : Create a hard link.

### Soft Link
- A soft link is a reference or pointer (like shortcuts in Windows).
- **ln -s <File> <SoftLinkName>** : Create a soft link.
- **ls -li** : Show inode number along with the list of files.

## Pattern Matching

### Symbols:
- **\*** : Matches any string of zero or more characters.
- **?** : Matches any single character.
- **[abc...]** : Matches any one character in the enclosed class.
- **[!abc...]** or **[^abc...]** : Matches any one character not in the enclosed class.

### Character Classes:
- **[[:alpha:]]** : Any alphabetic character.
- **[[:lower:]]** : Any lowercase character.
- **[[:upper:]]** : Any uppercase character.
- **[[:alnum:]]** : Any alphabetic character or digit.
- **[[:punct:]]** : Any printable character not a space or alphanumeric.
- **[[:digit:]]** : Any digit (0-9).
- **[[:space:]]** : Any single whitespace character (tabs, newlines, etc.).

## Basic Regular Expressions

- **.** : Matches any character.
- **^** : Matches the start of a string.
- **$** : Matches the end of a string.
- **\*** : Matches zero or more occurrences of the previous character.
- **\** : Escapes special characters.
- **()** : Groups regular expressions.
- **?** : Matches exactly one character.

## `cut` Command

- The `cut` command is used for cutting out sections from each line of a file and writing the result to standard output.
- **cut -d ":" -f 1,7 /etc/passwd** : Cut fields 1 and 7 using ":" as a delimiter.

## `wc` Command

- **echo "I Love Linux" | wc** : Counts words, lines, and characters in the input.

## Environment Variables

### Shell Variables:
- **set** : Lists all shell variables.

### Common Variables:
- **echo $HISTSIZE** : Shows the history size.
- **echo $HOME** : Shows the home directory.

### Modifying `PATH`:
- **PATH=PATH:/home/mohamed** : Append `/home/mohamed` to the `PATH`.

### Exporting Variables:
- **export <variables>** : Exports variables to child processes.

### Listing Environment Variables:
- **env** : List all environment variables.

## Managing Users and Groups

### Superuser and User IDs:
- **Superuser (UID: 0)**
- **System users (UID: 1–200 statically, 201–999 dynamically)**
- **Regular users (UID: 1000+)**

### User Commands:
- **whoami** : Show current username.
  
#### Switching Users:
- **su** : Switch to another user without changing the working directory.
- **su -** : Switch to another user and change the working directory.

### `sudo` Command:
- Allows a permitted user to execute a command as the superuser.
- **vim /etc/sudoers** : Edit the sudo configuration file using `visudo`.

#### Example `sudoers` Entries:
- **user01 ALL=(ALL) ALL** : Grant full sudo access to user01.
- **%group01 ALL=(ALL) ALL** : Grant full sudo access to group01.

### Adding and Modifying Users:
- **useradd <username>** : Add a new user.
- **useradd -md /home/user_1 -c "Planning user" -s /bin/sh -g mohamed -G wheel -u 5000 user01** : Add a user with options.
- **usermod <username>** : Modify an existing user.
  - **usermod -aG <group> <username>** : Add the user to a secondary group.
  - **usermod -L <username>** : Lock the user.
  - **usermod -U <username>** : Unlock the user.
- **userdel <username>** : Delete a user.
- **userdel -r <username>** : Delete a user and their home directory.

### Group Commands:
- **groupadd <groupname>** : Add a new group.
- **groupmod -n <newgroup> <oldgroup>** : Rename a group.
- **groupdel <groupname>** : Delete a group.

## Managing User Passwords

### `/etc/shadow` File Format:
- **(1)** Username
- **(2)** Encrypted password
- **(3)** Last password change (days since 1/1/1970)
- **(4)** Minimum number of days between password changes
- **(5)** Maximum number of days before password expires
- **(6)** Password warning period (days)
- **(7)** Inactivity period (days after password expires before account is locked)
- **(8)** Account expiration date (days since 1/1/1970)
- **(9)** Reserved for future use.

### Configuring Password Aging:
- **chage -m 0 -M 90 -W 7 -I 14 user03** : Set password aging parameters.
  - **-m** : Minimum days between password changes.
  - **-M** : Maximum days before password expires.
  - **-W** : Warning period (days before password expires).
  - **-I** : Inactive days after password expires before account is locked.

# Controlling Access to Files

## File Types
- **d** : Directory
- **-** : File
- **c** : Character device file
- **b** : Block device file
- **l** : Link file
- **p** : Pipe file

### File Permission Example
`-rwxr-x--- 1 root root 0 oct 31 11:06 test`

## Change Permissions of Files and Directories (Symbolic Method)

### Symbols:
- **u** : User
- **g** : Group
- **o** : Others
- **a** : All (User, Group, and Others)
- **r** : Read
- **w** : Write
- **x** : Execute

#### Usage:
- `chmod o-w <filename>` : Remove write permission for others.
- `chmod a+rwx test` : Add read, write, and execute permission for all.
- `chmod u+rwx, g=rx, o-wx test` : Set permissions for `test` file.

## Change Permissions of Files and Directories (Numeric Method)

### Numeric Permissions:
| Value | Binary | Meaning       |
|-------|--------|---------------|
| 7     | 111    | rwx (read, write, execute) |
| 6     | 110    | rw- (read, write)          |
| 5     | 101    | r-x (read, execute)        |
| 4     | 100    | r-- (read only)            |
| 3     | 011    | -wx (write, execute)       |
| 2     | 010    | -w- (write only)           |
| 1     | 001    | --x (execute only)         |

#### Usage:
- `chmod 777 test` : Give full permissions to user, group, and others.

## Change Ownership
- `chown mohamed file1` : Change ownership to `mohamed`.
- `chown mohamed:mohamed file1` : Change both owner and group.
- `chown :mohamed file1` : Change group ownership only.
- `chgrp mohamed file1` : Change group ownership.

#### Recursive Ownership Change:
- `chown -R root:root file1` : Change owner and group ownership for directory and its files.

## Special Permissions
- **Setuid**: `chmod u+s file1` or `chmod 4xxx file1`
- **Setgid**: `chmod g+s dir1` or `chmod 2xxx dir1`
- **Sticky bit**: `chmod o+t dir1` or `chmod 1xxx dir1`

## Searching Files
- `which <file>` : Search for a file in the system's PATH.
- `locate <file>` : Search for a file in the database.
- `updatedb` : Update the file location database.

## Default File Permissions (umask)
- `umask` : Display the current umask value.
  - Root user default: `0022`
  - Regular user default: `0002`
  
| Decimal | Binary   | Reverse | Symbolic (Directory) | Symbolic (File) |
|---------|----------|---------|----------------------|-----------------|
| 0 2 2   | 000 010  | 111 101 | rwx r-x r-x           | rw- r-- r--      |
| 0 0 2   | 000 000  | 111 111 | rwx rwx r-x           | rw- rw- r--      |

- `umask 007` : Set the umask to block permissions for others.

#### Notes:
- `.bashrc` : Works every time a new bash shell is opened.
- `.bash_profile` : Works once when you log in.

---

# Monitoring and Managing Linux Processes

## Process Information
- **PID** : Process ID
- **PPID** : Parent Process ID

#### Commands:
- `whoami` : Display the effective user.
- `ps aux` : Display all processes.
- `ps lax` : Long listing with technical details.
- `top` : Dynamic view of the system’s processes (similar to Task Manager in Windows).
- `pstree` : Display all processes as a tree.
  - `pstree -p` : Display processes with PID.
  - `pstree -p mohamed` : Display processes of a specific user.

## Managing Background Processes
- `<command> &` : Run a command in the background.
- `jobs` : List processes running in the background.
- `fg %<job number>` : Return a process to the foreground.

## Killing Processes
- `kill <PID>` : Kill a process by its ID.
- `kill -l` : List all kill signals.
- `kill -15 <PID>` : Default kill signal.
- `kill -9 <PID>` : Aggressive termination of a process.

## Process Scheduling and Priorities
- **Nice value** : Priority of the process (from -20 to 19).
  
#### Commands:
- `ps lax | less` : List processes with nice values.
- `nice -n 10 vim text &` : Start a process with a nice value of 10.
- `renice <nice value> <PID>` : Change the priority of a running process.
- `renice 19 $(pgrep sleep)` : Set the nice value of all sleep processes to 19.
  
---

# Controlling Services and Daemons

## Systemd Commands
- `systemctl list-units --type=service` : List all active services.
- `systemctl list-units --type= --all` : List all services (active and inactive).
- `systemctl --failed --type=service` : List failed services.
- `systemctl status <service>` : View the status of a specific service.
  - Example: `systemctl status sshd.service`
- `systemctl start/stop/restart <service>` : Start, stop, or restart a service.
- `systemctl reload <service>` : Reload the configuration file for a service.
- `systemctl enable/disable <service>` : Enable or disable a service at boot.
- `systemctl mask/unmask <service>` : Mask or unmask a service to prevent/allow starting.

---

# SSH Configuration and Security

## SSH Commands
- `ssh <username>@<remotehost>` : Create a remote interactive shell.
- `ssh <student>@<serverb> <hostname>` : Run a command on a remote server without accessing the shell.
- `ssh <username>@<remotehost> 'date; ls -lh'` : Execute multiple commands remotely without opening a shell.

## SSH Authentication Types
1. **Password authentication**
2. **Key-based authentication**

## Key-based Authentication
- `ssh-keygen` : Create a private key and matching public key for authentication.
  - Private key: `~/.ssh/id_rsa`
  - Public key: `~/.ssh/id_rsa.pub`
- `ssh-copy-id -i ~/.ssh/id_rsa.pub mohamed@192.168.1.10` : Copy the public key to the remote host.
- **Permissions**:
  - Private key permissions: `600`
  - Public key permissions: `644`

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

### CH1 - Improving Command-line Productivity

#### What, Why, and When to Use Shell Scripts?

**Goal:**
- Run commands more efficiently using advanced Bash shell features, shell scripts, and various utilities from Red Hat Enterprise Linux.

**Objectives:**
- Automate command sequences with shell scripts.
- Run commands over lists or items efficiently using `for` loops and conditionals.
- Use `grep` and regular expressions to find matching text patterns in logs or command output.

#### What is a Shell Script?
- A script is a list of system commands stored in an executable file.
- Saves time by avoiding retyping sequences of commands.

#### Why Shell Scripting?
- Essential for Linux system administration (e.g., setting up services at boot with `/etc/rc.d` scripts).
- Simple and straightforward syntax.
- Scripts can be built in sections, with only a few operators to learn.

#### When Not to Use Shell Scripts?
Avoid shell scripts for:
- Resource-intensive tasks (e.g., sorting, recursion).
- Complex mathematical operations (use C++/FORTRAN).
- Multi-dimensional arrays.
- Graphics/GUIs.
- Direct system hardware access.
- Using external libraries (consider Perl, Python, Ruby, or C/C++).

#### Tips for Writing Effective Bash Scripts:
- Use comments.
- Ensure scripts exit when they fail.
- Exit when using undeclared variables.
- Use double quotes when referencing variables.
- Use functions and perform debugging.
- Make variable and function names descriptive.

---

### What is a Sha-Bang (`#!`)?
- The sha-bang (`#!`) at the top of a script tells the system which interpreter to use.
- Example: `#!/bin/bash` specifies the Bash interpreter.
- The path after `#!` must be correct, or the script will fail.

### Invoking the Script:
- Use `sh scriptname` or `bash scriptname` to run a script.
- Alternatively, use `chmod +x scriptname` to make it executable, then run it with `./scriptname`.

---

### Providing Output from a Shell Script
- Use `which <command>` to find the location of a command.
  - Example: `which bash` returns `/usr/bin/bash`.

#### Writing a Simple "Hello, World!" Script:
1. Create the file:
   - `touch hello.sh`
   - `vim hello.sh`
   ```bash
   #!/bin/bash
   echo "Hello, World!"
   ```
   - Save and exit (`:wq`).

2. Make it executable:
   - `chmod +x hello.sh`

3. Run the script:
   - `./hello.sh`

---

### Writing an Effective Backup Script:
1. Create the file:
   - `touch backup.sh`
   - `vim backup.sh`
   ```bash
   #!/bin/bash
   tar -cf etc_backup.tar /etc
   scp etc_backup.tar root@192.168.1.2:/backup
   rm -rf etc_backup.tar
   ```
   - Save and exit (`:wq`).

2. Make it executable and run:
   - `chmod +x backup.sh`
   - `./backup.sh`

---

### Quoting Special Characters in Bash

Use `\`, `'`, or `"` to remove special meanings from characters:
- `\` escapes special meaning for the next character.
  - Example: `echo \# not a comment` will output `# not a comment`.
- Single quotes (`'`) prevent variable substitution.
- Double quotes (`"`) allow variable substitution.

---

### Special Characters and Operators in Bash:
- `.` (dot): Represents the current directory or matches any single character in regex.
- `$`: Refers to variables or marks the end of a line in regex.
- `*`: Wildcard for filename expansion or multiple characters in regex.
- `?`: Wildcard for single-character filename expansion or one character in regex.
- `()` and `{}`: Used for command grouping and brace expansion.
- `>` and `>>`: Redirect output (overwrite or append).
- `|` (pipe): Pass output from one command as input to another.

---

### Loops in Bash

#### `for` Loop:
- Iterates over a list of items.
```bash
for item in list
do
  command
done
```
Example:
```bash
for number in 1 2 3 4 5
do
  echo -n "$number"
done
# Outputs: 12345
```

#### `while` Loop:
- Runs as long as the condition is true.
```bash
i=1
while [ $i -le 10 ]
do
  echo $i
  i=$((i+1))
done
```

#### `until` Loop:
- Runs until the condition becomes true.
```bash
i=1
until [ $i -gt 10 ]
do
  echo $i
  i=$((i+1))
done
```


### Exit and Exit Status
- **Exit Command**: Terminates a script and can return a value to the parent process. If no value is returned, the status of the last executed command is used.
- **Exit Status**: A successful command returns `0`, while an unsuccessful one returns a non-zero value.
- **$?**: Used to check the return value of the last executed command.

### Testing Script Inputs
- **Test Constructs**: Bash uses `if`, `test`, `[` (synonym for `test`), and `[[` (extended test) for condition testing.
- **Conditional Statements**: Includes `if-else`, `if-elif-else`, and nested `if` statements.
  
  Example:
  ```bash
  x=5; y=10
  if [ $x -gt $y ]; then 
      echo "X is greater than y"
  else
      echo "X is lower than y"
  fi
  ```

### Loop and Condition Examples
- **For Loops**: Example provided on creating a backup script using loops, conditions, and `tar` for archiving directories.
  
  ```bash
  for dir in /etc /home /tmp
  do
      [ ! -d $dir ] && echo "$dir does not exist" && continue
      tar -cf "$dir"_backup.tar $dir
      # Add further conditions and actions
  done
  ```

### Regular Expressions and `grep`
- **Regex Symbols**: Basic regex symbols used for matching patterns in text (e.g., `.`, `^`, `$`, `*`, etc.).
- **Examples with `grep`**: Demonstrates pattern matching using `grep`, such as finding words that start or end with a specific pattern.

### Summary
- This chapter covers Bash scripting fundamentals, including command execution, loops, condition testing, and using regular expressions for searching text.

This section outlines various methods to schedule tasks on Linux systems, either for a one-time execution or for repeated intervals. Here's a summary of the main concepts:

# **Scheduling One-Time Tasks with the `at` Command**
- **`at` Command Usage**: The `at` command allows scheduling tasks to run once at a specific time. You provide a **TIME SPEC** (like "now +5min", "noon", or "tomorrow 4PM") to specify when the task should be executed.
    - Example: `at now +5min` will execute the given command 5 minutes from now.
    - Commands to be executed are entered into the `at` command interface, followed by **Ctrl+D** to save.
- **Manage Jobs**:
    - Use `atq` to view scheduled jobs.
    - Use `atrm <job_id>` to remove a scheduled job.
    - Check the process running `systemctl status atd`.

## **Recurring Tasks with `crontab`**
- **`crontab` Command**: This command is used to schedule recurring jobs. It follows a specific format where the user specifies **minute**, **hour**, **day of the month**, **month**, **day of the week**, and the **command** to be run.
    - Example: `0 20 * * 1 /root/Desktop/backup.sh` will run a backup script every Monday at 8 PM.
    - **Crontab Commands**:
        - `crontab -e`: Open the crontab editor.
        - `crontab -l`: List all jobs for the current user.
        - `crontab -r`: Remove all jobs for the current user.
    - **Backup Crontab**:
        - Use `crontab -l > crontab_backup` to backup.
        - Restore using `crontab crontab_backup`.

## **System-Wide Cron Jobs**
- System administrators can manage recurring tasks that affect the whole system by placing scripts in directories like:
    - **`/etc/cron.daily`**: For daily tasks.
    - **`/etc/cron.monthly`**: For monthly tasks.
    - **`/var/spool/cron`**: Contains crontabs for individual users.
    - **`/etc/crontab`**: System-wide cron tasks.

## **Managing Temporary Files with `systemd-tmpfiles`**
- **systemd-tmpfiles**: A service that manages temporary files. It automatically cleans up old or unnecessary files, ensuring system directories like `/tmp` do not fill up over time.
    - You can view the configuration with `systemctl cat systemd-tmpfiles-clean.timer`.
    - To edit timers, copy the existing timer file to `/etc/systemd/system/` and modify it.

## **Key Files for `at` and `cron` Jobs**
- **For `at`**:
    - **`/etc/at.allow`** and **`/etc/at.deny`**: Files that control which users are allowed or denied from using the `at` command.
    - **`/var/spool/at/`**: Holds scheduled jobs.
- **For `cron`**:
    - **`/etc/cron.allow`** and **`/etc/cron.deny`**: Files that control access to the `cron` command.
    - **`/etc/cron.d`**: Contains system-wide cron jobs.
    - **`/var/spool/cron`**: Stores individual user cron jobs.

---

>>>>>>> 0cc62acef8126efc964bc44b2282d7b8e2b0f07b
This chapter covers essential commands for scheduling tasks and managing system timers, focusing on using `at` for one-time tasks and `cron` for recurring jobs.