# CH1 - Improving Command-Line Productivity

### **What, Why, and When to Use Shell Scripts?**

**Goal:**
- Run commands more efficiently using Bash shell features, shell scripts, and utilities in Red Hat Enterprise Linux.

**Objectives:**
- Automate sequences of commands with simple shell scripts.
- Run commands efficiently using `for` loops and conditionals.
- Find text matching patterns in logs using `grep` and regular expressions.

---

### **What is a Script?**
- A script is a file containing system commands.
- Saves the effort of retyping commands each time you want to invoke them.

---

### **Why Shell Scripting?**
- Essential for proficiency in system administration.
- Linux uses shell scripts during boot (e.g., `/etc/rc.d` scripts).
- Simple syntax similar to command-line utilities.
- Easy to learn since it can be built in small sections.

---

### **When Not to Use Shell Scripts?**
Avoid shell scripts for:
- Resource-heavy tasks (e.g., sorting, recursion).
- Complex math operations.
- Multi-dimensional arrays.
- Graphics/GUIs.
- Direct hardware access.
- Complex libraries or legacy code interfaces.

For these, consider more powerful languages like Perl, Python, or compiled languages like C/C++.

---

### **Useful Tips for Writing Effective Bash Scripts:**
- Use comments to explain the script.
- Ensure the script exits if a command fails.
- Exit on undeclared variables.
- Use double quotes for variable references.
- Utilize functions in scripts.
- Debug long scripts.
- Use descriptive names for functions and variables.

---

### **What is a Shebang (`#!`)?**
- The `#!` at the start of a script tells the system which interpreter to use.
- Common shebang examples:
  - `#!/bin/bash`
  - `#!/usr/bin/python`
- If missing, the system uses the default shell (usually Bash).

**Example:**
```bash
#!/bin/bash
echo "Hello, world!"
```

### **Invoking the Script:**
- Use `bash scriptname` or `./scriptname` after making it executable:
  ```bash
  chmod +x scriptname
  ./scriptname
  ```

### **Providing Output From a Shell Script:**
- Use `echo` to print output, or assign a command output to a variable using backticks or `$(command)` syntax.

**Example:**
```bash
HOST=$(hostname -s)
echo "Hostname: $HOST"
```

---

### **Quoting Special Characters:**
Special characters can be escaped using:
- **Backslash (`\`)**: Escapes one character.
- **Single quotes (`'`)**: Treats everything literally inside.
- **Double quotes (`"`)**: Expands variables but keeps spaces intact.

**Example:**
```bash
echo "This is \$HOST"     # Outputs: This is $HOST
echo 'This is $HOST'      # Outputs: This is $HOST (literal)
```

---

### **File and Directory Handling with Quoting:**
- Use quotes to handle file or directory names with spaces:
  ```bash
  touch "file 1"
  mkdir "dir 1"
  cd "dir 1"
  ```

---

### **Special Characters in Bash:**
- **`.` (Dot)**: 
  - Hidden files start with a dot.
  - Single dot (`.`) represents the current directory.
  - Double dots (`..`) refer to the parent directory.
- **`*` (Asterisk)**: Wildcard for filename expansion or multiplication.
- **`$` (Dollar)**: Refers to variables or end-of-line in regular expressions.

---

### **Brace Expansion:**
Used for generating sequences.
```bash
touch {file1,file2,file3}
echo {1..5}  # Outputs: 1 2 3 4 5
```

---

### **Redirection & Pipes:**
- **`>`**: Redirects output to a file (overwrites).
- **`>>`**: Appends output to a file.
- **`|`**: Pipe output from one command to another.

**Example:**
```bash
ls | grep ".sh" > scriptlist.txt
```

---

## **Loops for Running Commands Efficiently**

Loops are essential for organizing shell scripts, enabling structured operations on code blocks. Looping and branching constructs allow efficient execution of tasks within a script.

A loop is a block of code that iterates over a list of commands as long as the loop control condition is true.

### **`for` Loop Example**
```bash
for arg
do
    command1
    command2
    command3
done
```

Here’s a practical example:
```bash
NUMBERS="1 2 3 4 5"
for number in $NUMBERS
do
    echo -n "$number"
done
```
**Output:**
```
12345
```

Another example to list files:
```bash
for file in file*
do
    ls -l $file
done
```
**Output:**
```
-rw-r--r-- 1 root root 0 Dec 26 11:23 file4
-rw-r--r-- 1 root root 0 Dec 26 11:23 file5
```

Example for renaming files:
```bash
for file in file*
do
    mv $file New_$file
    ls New*
    sleep 2
done
```

---

### **`while` and `until` Loops**

#### **Infinite `while` Loop Example**
```bash
while true
do 
    echo "Hello, world"
done
```

#### **Counter-controlled `while` Loop Example**
```bash
i=1
while [ $i -le 10 ]
do 
    echo $i
    let $i+=1
done
```

#### **`until` Loop Example**
The `until` loop works like a reverse `while` loop. It continues until the condition becomes true.
```bash
i=1
until [ $i -gt 10 ]
do 
    echo $i 
    let $i+=1
done
```

---

## **Exit and Exit Status**

The `exit` command is used to terminate a script and return a value (exit status) to the script's parent process. Every command returns an exit status: `0` for success and non-zero for failure.

**Example:**
```bash
#! /bin/bash
COMMAND_1
COMMAND_LAST
exit $?  # Will exit with the status of the last command.
```

`$?` holds the return value of the last executed command. If it is `0`, the command was successful.

---

## **Testing Script Inputs**

Bash provides several ways to test conditions within a script, using the `test` command, bracket operators, and the `if/then` construct.

### **`if/then` Construct**
The `if/then` construct checks whether the exit status of a command is `0`, and if so, it executes the associated commands.

**Example:**
```bash
if [ condition-true ]
then
    command1
    command2
else
    command3
    command4
fi
```

---

### **`if/elif/else` Construct**
The `elif` (else if) allows multiple conditions to be tested.
```bash
if [ condition1 ]
then
    command1
elif [ condition2 ]
then
    command2
else
    command3
fi
```

---

### **Nested `if/then` Conditions**
You can also nest `if` statements:
```bash
if [ condition1 ]
then
    if [ condition2 ]
    then
        do-something  # Only if both conditions are true.
    fi
fi
```

Alternatively, you can place the `if` and `then` on the same line, but you must use a semicolon:
```bash
if [ -x "$filename" ]; then
    echo "File is executable"
fi
```

---

## **Examples Using `[[...]]` and Unary Operators**

```bash
[ 1 -eq 1 ]; echo $?
# Output: 0 (true)

[ 1 -ne 1 ]; echo $?
# Output: 1 (false)

[[ "abc" = "abc" ]]; echo $?
# Output: 0

[[ "abc" != "def" ]]; echo $?
# Output: 0
```

### **Checking Directories and Files**
```bash
[ -d /etc ]; echo $?
# Output: 0 (directory exists)

[ -f /etc/passwd ]; echo $?
# Output: 0 (file exists)

[ -r /etc/passwd ]; echo $?
# Output: 0 (readable)
```

---

## **Examples of `if` Statements**

**Example:**
```bash
x=5
y=10
if [ $x -gt $y ]
then
    echo "X is greater than Y"
else
    echo "X is lower than Y"
fi
```
**Output:**
```
X is lower than Y
```

You can also compare files using the `cmp` command:
```bash
cmp /etc/passwd /etc/passwd
# No output (files are identical)

cmp /etc/passwd /etc/shadow
# Output: "/etc/passwd /etc/shadow differ: byte 6, line 1"
```

### **Example Using `for` Loop and `if`**
```bash
#!/usr/bin/bash
for dir in /etc /home /tmp
do
   

 if [ -d $dir ]
    then
        echo "Directory $dir exists"
    fi
done
```


---

### **Example Using `for` Loop and `if`**

```bash
#!/usr/bin/bash
for dir in /etc /home /tmp
do
    # Check if directory exists
    [ ! -d $dir ] && echo "$dir does not exist" && continue
    
    # Create a tar archive of the directory
    tar -cf "$dir"_backup.tar $dir
    
    # Check if tar command was successful
    if [ $? -eq 0 ]; then
        echo "Tar archive for $dir is created successfully"
    else
        echo "An error occurred while processing $dir"
    fi
    
    # Securely copy the tar file to a remote server
    scp "$dir"_backup.tar root@192.168.1.0:/backup
    
    # Check if scp command was successful
    if [ $? -eq 0 ]; then
        echo "Secure copy for $dir is done successfully"
    else
        echo "An error occurred during remote file copy for $dir"
    fi
done
```

---

## **Regular Expressions in Shell Scripting**

Regular expressions (regex) are powerful tools used in shell scripting to match patterns in text files, logs, and output. They are integral to commands like `grep`, `sed`, and `awk` for text processing.

### **Basic Regular Expression Symbols**

| Symbol | Description                                      |
|--------|--------------------------------------------------|
| `.`    | Matches any single character.                    |
| `^`    | Matches the start of a line or string.           |
| `$`    | Matches the end of a line or string.             |
| `*`    | Matches zero or more of the preceding character. |
| `[]`   | Matches any one of the enclosed characters.      |
| `|`    | Acts as an OR operator.                         |
| `\`    | Escapes special characters to treat them literally.|

---

### **Examples of Regular Expressions**

```bash
ls fil*       # Matches any file starting with "fil".
ls ???        # Matches any file with exactly three characters.
ls file[ab]   # Matches files starting with "file" and ending with either "a" or "b".
ls file[0-9]  # Matches files starting with "file" and ending with a digit.
ls file[!a-z] # Matches files starting with "file" and NOT ending with a lowercase letter.
```

---

## **Using `grep` with Regular Expressions**

The `grep` command searches through files for lines that match a specified regular expression. It is a fast and useful tool for locating patterns in files such as logs or configuration files.

### **Common `grep` Examples:**

```bash
grep cat /usr/share/dict/words        # Lists lines containing the word "cat".
grep ^cat /usr/share/dict/words       # Lists lines starting with "cat".
grep cat$ /usr/share/dict/words       # Lists lines ending with "cat".
grep ^c.t$ /usr/share/dict/words      # Matches lines starting with "c", ending with "t", and any character in between.
grep "[0-9]" /usr/share/dict/words    # Matches lines that contain digits.
```

---

## **Summary**

In this chapter, we covered:
- How to create and execute simple Bash scripts to automate tasks.
- Using loops like `for` and `while` to run commands efficiently.
- Conditional testing using `if/else` constructs to control script flow.
- Working with regular expressions to match patterns in text and how to use `grep` to search through files.
- Practical examples of how regular expressions can simplify complex text searches.

---

# Chapter 2: Scheduling Future Tasks

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

# CH4: Controlling Access to Files with ACLs

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