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


# **Managing Local Users and Groups in Linux**

Linux organizes users into categories like superusers, system users, and regular users. Each user has a specific User ID (UID) and Group ID (GID) associated with them. Proper management of users and groups is crucial for security and system functionality.

## **User Categories:**
1. **Superuser (root)**: UID 0.
2. **System Users**: Static (UID 1-200) and Dynamic (UID 201-999).
3. **Regular Users**: UID 1000 and above.

## **Basic Commands**

- **whoami**: Displays the effective user.
  
- **Difference between `su` and `su -`**:
  - `su <username>`: Switches the user without changing the current working directory.
  - `su - <username>`: Switches the user and changes to their home directory.

## **sudo Privileges**

- **sudo**: Allows permitted users to run commands as the superuser or another user.
  - In many systems, the root user might not have a valid password for security reasons.
  - If a user tries to run a command without permission, it will be blocked, logged, and an email may be sent to the root user (log stored in `/var/log/secure`).

### **sudo Configuration File:**
- **/etc/sudoers**: Main configuration file for managing sudo access.
  - Use `visudo` to safely edit this file:
    ```bash
    visudo
    ```
  - Examples:
    ```bash
    user01 ALL=(ALL) ALL     # Grant full sudo access to user01
    %group01 ALL=(ALL) ALL   # Grant full sudo access to group group01
    ```

## **Managing Users**

### **Adding Users**
- **useradd**: Adds a new user with various options.
  ```bash
  useradd <username>
  useradd -md /home/user_1 -c "Planning user" -s /bin/sh -g mohamed -G wheel -u 5000 user01
  ```
  - `-m`: Create the user's home directory.
  - `-d`: Specify home directory path.
  - `-c`: Comment field (usually for user descriptions).
  - `-s`: Specify the user's default shell.
  - `-g`: Primary group.
  - `-G`: Secondary groups.
  - `-u`: User ID.

### **Modifying Users**
- **usermod**: Modify existing users.
  ```bash
  usermod <username>
  usermod -c "Another comment" user01
  usermod -aG mohamed user01     # Add user to a secondary group
  usermod -L mohamed             # Lock user account
  usermod -U mohamed             # Unlock user account
  usermod -s /sbin/nologin mohamed  # Set shell to nologin (disables login)
  ```

### **Deleting Users**
- **userdel**: Delete users.
  ```bash
  userdel <username>           # Delete user without removing their home directory
  userdel -r <username>        # Delete user and their home directory
  ```

## **Managing Groups**

### **Adding Groups**
- **groupadd**: Adds a new group.
  ```bash
  groupadd -g 3000 group01    # Create a group with a specific GID
  ```

### **Modifying Groups**
- **groupmod**: Modify existing groups.
  ```bash
  groupmod -n newgroup group01  # Rename group
  ```

### **Deleting Groups**
- **groupdel**: Delete a group.
  ```bash
  groupdel group01
  ```

# **Managing User Passwords**

In Linux, user passwords are stored in the `/etc/shadow` file, which contains important information for each user account.

### **Example Entry in `/etc/shadow`:**
```
user03:$6$CSsX...:17933:0:9999:7::18113:
```
The fields in this file are separated by colons and include:
1. **Username**: The account name.
2. **Encrypted Password**: The hashed password.
3. **Last Password Change**: The number of days since 1/1/1970 when the password was last changed.
4. **Minimum Days**: The minimum number of days between password changes.
5. **Maximum Days**: The maximum number of days the password is valid before it must be changed.
6. **Warning Period**: The number of days before expiration to warn the user.
7. **Inactive Period**: Days of inactivity before the account is locked.
8. **Expiration Date**: Days since 1/1/1970 after which the password expires.
9. **Reserved for future use**.

### **Configuring Password Aging**
Use `chage` to configure password expiration policies:
```bash
chage -m 0 -M 90 -W 7 -I 14 user03
```
- `-m`: Minimum number of days between password changes.
- `-M`: Maximum number of days the password is valid.
- `-W`: Warning days before the password expires.
- `-I`: Days of inactivity before the account is locked.

### Example:
```bash
chage -m 0 -M 90 -W 7 user03   # Password can be changed anytime, expires in 90 days, 7-day warning
``` 

This ensures that user accounts are secure and managed according to policy.
# **Controlling Access to Files**

In Linux, controlling file access and permissions is essential for system security and efficient multi-user environments. Files can have different types and permissions that determine who can read, write, or execute them.

## **File Types**

- **d**: Directory
- **-**: Regular file
- **c**: Character device file
- **b**: Block device file
- **l**: Symbolic link file
- **p**: Named pipe file

Example of file permissions:
```
-rwxr-x--- 1 root root 0 oct 31 11:06 test
```

## **Changing Permissions**

### **Symbolic Method**
Permissions are split into three categories for **user (u)**, **group (g)**, and **other (o)**. You can modify these permissions using symbols:

- **r**: Read permission
- **w**: Write permission
- **x**: Execute permission

Permissions are added or removed with:
- **+**: Add permission
- **-**: Remove permission
- **=**: Set exactly the specified permission

Example commands:
```bash
chmod u+r test  # Add read permission for the user
chmod g-w test  # Remove write permission for the group
chmod a+x test  # Add execute permission for all (user, group, others)
```

You can combine permissions:
```bash
chmod u+rwx, g=rx, o-w test
```

### **Numeric Method**
Permissions can also be changed using a numeric representation. Each set of permissions is represented by a number:

- **7**: Full permission (rwx)
- **6**: Read and write (rw-)
- **5**: Read and execute (r-x)
- **4**: Read only (r--)
- **3**: Write and execute (-wx)
- **2**: Write only (-w-)
- **1**: Execute only (--x)

Example command:
```bash
chmod 777 test  # Full permissions for everyone
```

## **Changing Ownership**

You can change the ownership of files and directories using the following commands:

- Change the owner of a file:
  ```bash
  chown mohamed file1
  ```

- Change both the owner and group:
  ```bash
  chown mohamed:mohamed file1
  ```

- Change only the group ownership:
  ```bash
  chown :mohamed file1
  chgrp mohamed file1
  ```

- Recursively change ownership for directories and their contents:
  ```bash
  chown -R root:root dir1
  ```

## **Special Permissions**

Special permissions add advanced features to files and directories:

- **setuid (u+s)**: Grants the file’s owner permissions when the file is executed.
- **setgid (g+s)**: Ensures that files created within a directory inherit the group ID of the directory.
- **sticky bit (o+t)**: Prevents users from deleting files in a directory unless they are the owner.

Symbolic method:
```bash
chmod u+s file    # Apply setuid
chmod g+s dir1    # Apply setgid to a directory
chmod o+t dir1    # Apply sticky bit to a directory
```

Numeric method (fourth preceding digit):
```bash
chmod 2770 dir1   # Apply setgid and full permission for the owner and group
```

## **Searching for Files**

- Search for a file's location:
  ```bash
  which <file>
  ```
- Search using a database:
  ```bash
  locate <file>
  ```
- Update the search database (required for `locate` to find newly created files):
  ```bash
  updatedb
  ```

## **Default File Permissions**

**umask** defines the default permissions for new files and directories. The umask value is subtracted from the default permissions (777 for directories, 666 for files).

- View the current umask value:
  ```bash
  umask
  ```

### **Default umask Values**:
- **root**: `0022` (results in `755` permissions for directories and `644` for files)
- **regular users**: `0002` (results in `775` for directories and `664` for files)

### **Setting umask**:
- Set a new umask:
  ```bash
  umask 007
  ```

- **Umask Calculation Example**:
  - If the umask is `0022`:
    - Directory: `777` - `022` = `755` (`rwxr-xr-x`)
    - File: `666` - `022` = `644` (`rw-r--r--`)
  - If the umask is `0007`:
    - Directory: `777` - `007` = `770` (`rwxrwx---`)
    - File: `666` - `007` = `660` (`rw-rw----`)

### **Persistent umask**:
To make the umask setting permanent for the current user, add it to `.bashrc` or `.bash_profile`:

```bash
echo "umask 007" >> ~/.bashrc
```

- **.bashrc**: Executed every time a new shell is opened.
- **.bash_profile**: Executed once when you log in.

By mastering file types, permissions, ownership, and special permissions, you can manage access control effectively in a Linux system.

# **Monitoring and Managing Linux Processes**

In Linux, a **process** is an instance of a running executable program. Each process is assigned a **Process ID (PID)**, and every process has a **Parent Process ID (PPID)**, which represents the parent process that created it.

## **Basic Commands for Process Management**

1. **Identify the User**:
   - Display the current effective user:
     ```bash
     whoami
     ```

2. **Process Listing**:
   - List current running processes:
     ```bash
     ps
     ```
   - Display all processes, including those without a controlling terminal:
     ```bash
     ps aux
     ```
   - A long listing with more technical details:
     ```bash
     ps lax
     ```
   - Interactive process viewer similar to Task Manager in Windows:
     ```bash
     top
     ```
   - Show processes in a tree structure:
     ```bash
     pstree
     ```
   - Show processes as a tree with their PIDs:
     ```bash
     pstree -p
     ```
   - Display processes of a specific user:
     ```bash
     pstree -p mohamed
     ```

3. **Find Specific Processes**:
   - Show process names for a specific user:
     ```bash
     pgrep -u mohamed -l
     ```

## **Managing Background and Foreground Processes**

1. **Running Processes in the Background**:
   - Run a command in the background:
     ```bash
     <command> &
     ```
   - List processes running in the background:
     ```bash
     jobs
     ```

2. **Bringing Processes to the Foreground**:
   - Bring a background process to the foreground:
     ```bash
     fg %<job number>
     ```

## **Killing and Stopping Processes**

1. **Killing a Process**:
   - Kill a process by PID:
     ```bash
     kill <PID>
     ```
   - List all available kill signals:
     ```bash
     kill -l
     ```
   - Default termination signal (SIGTERM):
     ```bash
     kill -15 <PID>
     ```
   - Forcefully terminate a process (SIGKILL):
     ```bash
     kill -9 <PID>
     ```
   - Reload configuration without terminating the process (SIGHUP):
     ```bash
     kill -1 <PID>
     ```

2. **Finding and Killing Processes**:
   - Find the PID of a process by name:
     ```bash
     pidof <process_name>
     ```
   - Kill all instances of a process by name:
     ```bash
     killall sleep
     ```
   - Kill all processes of a specific user:
     ```bash
     pkill -U mohamed
     ```

## **Monitoring and Scheduling Processes**

1. **Monitoring System Processes with `top`**:
   - View dynamic information about system processes:
     ```bash
     top
     ```
   - Limit the number of updates:
     ```bash
     top -n 2
     ```
   - Set the delay between updates (in seconds):
     ```bash
     top -d 2
     ```

2. **Process Scheduling and Priorities**:
   - List processes with their **nice** values (priority levels):
     ```bash
     ps lax | less
     ```
   - Show user, PID, nice value, and command:
     ```bash
     ps axo user,pid,nice,command
     ```

3. **Setting Process Priorities with `nice`**:
   - Start a process with a defined priority (default is 10):
     ```bash
     nice vim text
     ```
   - Start a process with a custom priority (e.g., 10):
     ```bash
     nice -n 10 vim text &
     ```

4. **Changing Process Priorities with `renice`**:
   - Change the priority of a running process:
     ```bash
     renice <nice_value> <PID>
     ```
   - Set the priority of all `sleep` processes to 19 (lowest priority):
     ```bash
     renice 19 $(pgrep sleep)
     ```

By mastering these commands, you can efficiently monitor, manage, and schedule processes in Linux, ensuring system resources are used effectively.


# **Controlling Services and Daemons in Linux**

In Red Hat Enterprise Linux, **systemd** is the first process that starts (PID 1), managing all other system services and processes.

### **Common `systemctl` Commands**

1. **Listing Services**:
   - To list all active services:
     ```bash
     systemctl list-units --type=service
     ```
   - To list all active and inactive services:
     ```bash
     systemctl list-units --type=service --all
     ```
   - To list failed services:
     ```bash
     systemctl --failed --type=service
     ```

2. **Viewing Service Status**:
   - To check the status of a specific service (e.g., `sshd`):
     ```bash
     systemctl status sshd.service
     ```

3. **Service State Queries**:
   - Check if a service is active:
     ```bash
     systemctl is-active sshd.service
     ```
   - Check if a service is enabled to start at boot:
     ```bash
     systemctl is-enabled sshd.service
     ```
   - Check if a service has failed:
     ```bash
     systemctl is-failed sshd.service
     ```

### **Managing Services**

1. **Starting and Stopping Services**:
   - Start a service:
     ```bash
     systemctl start sshd.service
     ```
   - Stop a service:
     ```bash
     systemctl stop sshd.service
     ```
   - Restart a service:
     ```bash
     systemctl restart sshd.service
     ```

2. **Reloading a Service**:
   - Reload a service to re-read its configuration file without stopping it:
     ```bash
     systemctl reload sshd.service
     ```

3. **Managing Service Startup at Boot**:
   - Enable a service to start at boot:
     ```bash
     systemctl enable sshd.service
     ```
   - Disable a service from starting automatically at boot:
     ```bash
     systemctl disable sshd.service
     ```

### **Masking and Unmasking Services**

- **Masking** a service prevents it from being started (either manually or automatically):
   ```bash
   systemctl mask sendmail.service
   ```

- **Unmasking** a service re-enables it:
   ```bash
   systemctl unmask sendmail.service
   ```

### **Additional Commands**

1. **Listing Service Dependencies**:
   - To display a hierarchy of service dependencies:
     ```bash
     systemctl list-dependencies <unit>
     ```
   
By mastering these `systemctl` commands, you can control, monitor, and manage services and daemons effectively on a Linux system.

# **Configuration and Securing SSH**

### **Basic SSH Usage**

1. **SSH for Remote Interactive Shell**:
   - The command below opens a remote interactive shell on a remote system.
   
   ```bash
   ssh <username>@<remotehost>
   ```

   Example:
   ```bash
   ssh student@serverb
   ```

2. **SSH Command Execution without Interactive Shell**:
   - You can use SSH to execute a command on the remote system without accessing the interactive shell.
   
   Example:
   ```bash
   ssh <student>@<serverb> hostname
   ```
   This command runs the `hostname` command on the remote system as the `student` user.

3. **Execute Multiple Commands Remotely**:
   - Execute a series of commands without an interactive shell:
   
   ```bash
   ssh <username>@<remotehost> 'date; ls -lh'
   ```

---

### **Types of SSH Authentication**

There are two main types of authentication in SSH:

1. **Password Authentication**:
   - Requires the user to enter their password to access the remote system.

2. **Key-Based Authentication**:
   - A more secure method involving a key pair: a **private key** and a **public key**.

---

### **Generating SSH Key Pair**

- To generate a key pair, use the `ssh-keygen` command:

   ```bash
   ssh-keygen
   ```

   - The keys are saved in your `~/.ssh/` directory:
     - **Private key**: `~/.ssh/id_rsa`
     - **Public key**: `~/.ssh/id_rsa.pub`

   **File Permissions**:
   - The private key must have permissions set to `600`:
     
     ```bash
     chmod 600 ~/.ssh/id_rsa
     ```
   - The public key should have permissions `644`:

     ```bash
     chmod 644 ~/.ssh/id_rsa.pub
     ```

---

### **Copying Public Key to Remote Server**

1. **Using `ssh-copy-id`**:
   - Automatically copies your public key to the remote system:

     ```bash
     ssh-copy-id -i ~/.ssh/id_rsa.pub mohamed@192.168.1.10
     ```

2. **Manually Copying the Public Key**:
   - If `ssh-copy-id` is not available, you can manually copy the key:

   1. **Copy the public key**:
      ```bash
      clip < ~/.ssh/id_rsa.pub
      ```
   
   2. **Access the remote server** and navigate to the `.ssh` directory:
      ```bash
      cd /root/.ssh
      ```

   3. **Add the public key** to the `authorized_keys` file:
      ```bash
      vi authorized_keys
      ```

   4. **Paste** the copied public key and save the file.

---

### **Customizing SSH Service Configuration**

The OpenSSH service is controlled by a daemon called **sshd**, and its main configuration file is located at `/etc/ssh/sshd_config`.

1. **Disabling Root Login**:
   - To enhance security, disable root login via SSH by modifying the `PermitRootLogin` setting in `/etc/ssh/sshd_config`:
   
   ```bash
   PermitRootLogin no
   ```

2. **Disabling Password Authentication**:
   - To force users to authenticate using SSH keys and disable password authentication, modify the `PasswordAuthentication` setting:
   
   ```bash
   PasswordAuthentication no
   ```

3. **Reloading the SSH Service**:
   - After making changes to the configuration file, reload the SSH service to apply the changes:
   
   ```bash
   sudo systemctl reload sshd.service
   ```

### **Note:**
- By default, SSH listens on **port 22**. You can change this by modifying the `Port` setting in `/etc/ssh/sshd_config`.

---


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
# Archiving and Transferring Files on Linux


#### **Goal:**
Archive and copy files from one system to another.

---

#### **Objectives:**
1. **Archive files and directories into a compressed file using `tar`**.
2. **Extract the contents of an existing `tar` archive**.
3. **Transfer files securely using SSH**.

---

### **Managing Compressed TAR Archives**

Archiving and compressing files are useful for backups and transferring data across networks. The `tar` command is commonly used to create and manage archive files.

---

### **`tar` Command Options:**

- **`-c`**: Create a new archive.
- **`-x`**: Extract from an existing archive.
- **`-t`**: List the contents of an archive.
- **`-v`**: Verbose output, showing the files being processed.
- **`-f`**: Specifies the name of the archive file.
- **`-p`**: Preserve permissions when extracting files.

#### Example:
- **Create an archive**:
  ```bash
  tar -cvf etc_backup.tar /etc
  ```
- **Extract from an archive**:
  ```bash
  tar -xvf etc_backup.tar
  ```

---

### **Creating Compressed Archives**

The `tar` command supports different compression methods:

- **gzip**: (`.tar.gz`)
- **bzip2**: (`.tar.bz2`)
- **xz**: (`.tar.xz`)

#### Examples:
- **gzip compression**:
  ```bash
  tar -czf etc_backup.tar.gz /etc
  ```
- **bzip2 compression**:
  ```bash
  tar -cjf etc_backup.tar.bz2 /etc
  ```
- **xz compression**:
  ```bash
  tar -cJf etc_backup.tar.xz /etc
  ```

#### Compression Comparison:
- `gzip`: Fastest, but lower compression.
- `bzip2`: Slower but better compression than `gzip`.
- `xz`: Slowest, but best compression.

---

### **Extracting Compressed Archives**

To extract files from a compressed archive:

#### Examples:
- **Extract `.tar.gz`**:
  ```bash
  tar -xzf etc_backup.tar.gz
  ```
- **Extract `.tar.bz2`**:
  ```bash
  tar -xjf etc_backup.tar.bz2
  ```
- **Extract `.tar.xz`**:
  ```bash
  tar -xJf etc_backup.tar.xz
  ```

---

### **Compressing and Extracting Individual Files**

You can also compress and extract individual files using gzip, bzip2, and xz.

#### Compression:
- **gzip**:
  ```bash
  gzip etc.tar
  ```
- **bzip2**:
  ```bash
  bzip2 abc.tar
  ```
- **xz**:
  ```bash
  xz myarchive.tar
  ```

#### Extraction:
- **gunzip**:
  ```bash
  gunzip etc.tar.gz
  ```
- **bunzip2**:
  ```bash
  bunzip2 abc.tar.bz2
  ```
- **unxz**:
  ```bash
  unxz myarchive.tar.xz
  ```

---

### **Transferring Files Using Secure Copy (SCP)**

`scp` is used to transfer files between local and remote systems over SSH.

#### Examples:
- **Transfer file from local to remote**:
  ```bash
  scp etc.tar root@192.168.1.10:/root
  ```
- **Transfer file from remote to local**:
  ```bash
  scp root@192.168.1.10:/root/date.txt .
  ```

---

### **Transferring Files Using Secure File Transfer Program (SFTP)**

`sftp` is an interactive tool for transferring files securely over SSH.

#### Examples:
- **Connect to a remote host**:
  ```bash
  sftp root@192.168.1.10
  ```
- **Upload a file**:
  ```bash
  put etc.tar
  ```
- **Download a file**:
  ```bash
  get date.txt
  ```

#### Local Commands in `sftp`:
- **Print local directory**:
  ```bash
  lpwd
  ```

### Installing and Updating Software Packages in RHEL (Red Hat Enterprise Linux)

---

#### **Goal**:  
Download, install, update, and manage software packages from RedHat and Yum Package repositories.

---

### **Explaining and Investigating RPM Software Packages**

RPM (Red Hat Package Manager) is a system for managing software on Linux systems. Package files have the following structure:
```
name-version-release-architecture.rpm
```
- **Name**: Describes the contents.
- **Version**: Version number of the software.
- **Release**: Release number of the package.
- **Architecture**: Processor type (e.g., `x86_64`, `noarch` for architecture-independent packages).

#### **Useful Commands for RPM**:
- **View OS Information**:
  - `hostnamectl` – Track how the local system appears on the network.
  - `cat /etc/redhat-release` – Show OS name and version.
  - `uname -a` – Display OS details.

- **Downloading Packages**:
  - `wget <URL>` – Non-interactive downloader for files from the web.

---

### **Managing RPM Packages**:

RPM allows managing software on a Linux system in various ways, from installation to querying details about packages.

#### **Query RPM Packages**:
- **List all installed packages**:  
  ```bash
  rpm -qa
  ```
- **Check the version of an installed package**:  
  ```bash
  rpm -q <packagename>
  ```
- **Find the package that provides a specific file**:  
  ```bash
  rpm -qf <filename>
  ```
- **Get detailed package information**:  
  ```bash
  rpm -qi <packagename>
  ```
- **List files installed by a package**:  
  ```bash
  rpm -ql <packagename>
  ```
- **List configuration files of a package**:  
  ```bash
  rpm -qc <packagename>
  ```
- **View package installation/removal scripts**:  
  ```bash
  rpm -q --scripts <packagename>
  ```
- **View the changelog for a package**:  
  ```bash
  rpm -q --changelog <packagename>
  ```

#### **Installing and Removing RPM Packages**:
- **Install an RPM package**:  
  ```bash
  rpm -ivh <Package.rpm>
  ```
  Options:
  - `-i`: Install the package.
  - `-v`: Verbose output.
  - `-h`: Show progress with hash marks (`#`).

- **Remove an installed RPM package**:  
  ```bash
  rpm -ev <packagename>
  ```

---

### **Creating Yum Repositories**

To manage packages using **Yum**, you need to configure repositories. Here's how to set up a local Yum repository from an ISO image:

1. **Mount the ISO image**:
   ```bash
   mount -o loop /dev/sr0 /mnt
   ```

2. **Create repository files**:
   Create `.repo` files under `/etc/yum.repos.d/` for both `AppStream` and `BaseOS`:
   ```bash
   vim /etc/yum.repos.d/AppStream.repo
   ```
   Contents:
   ```ini
   [Local_AppStream]
   name="RHEL9 Local AppStream repository"
   baseurl=file:///mnt/AppStream
   enabled=1
   gpgcheck=0
   ```

   Similarly, create `BaseOS.repo`:
   ```bash
   vim /etc/yum.repos.d/BaseOS.repo
   ```
   Contents:
   ```ini
   [Local_BaseOS]
   name="RHEL9 Local BaseOS repository"
   baseurl=file:///mnt/BaseOS
   enabled=1
   gpgcheck=0
   ```

3. **Verify the repositories**:
   ```bash
   yum repolist
   ```

4. **Disable subscription warning**:
   Disable the subscription manager plugin:
   ```bash
   vi /etc/yum/pluginconf.d/subscription-manager.conf
   ```
   Change:
   ```ini
   enabled=0
   ```

---

### **Installing and Updating Software Packages with YUM**

Yum is a high-level package management tool for managing RPM-based packages, resolving dependencies, and pulling from repositories.

#### **Common Yum Commands**:
- **List installed and available packages**:
  ```bash
  yum list
  ```
- **Search for a package**:
  ```bash
  yum search <keyword>
  ```
- **Install a package**:
  ```bash
  yum install <packagename>
  ```
- **Update a package**:
  ```bash
  yum update <packagename>
  ```
- **Remove a package**:
  ```bash
  yum remove <packagename>
  ```
- **View Yum transaction history**:
  ```bash
  yum history
  ```

---

### **Application Streams in RHEL 9**

RHEL 9 has two main repositories:
- **BaseOS**: Focuses on core OS functionalities.
- **AppStream**: Contains applications and related packages.

Both repositories are essential to a complete RHEL 9 system.

---

### **Summary of Commands**

#### **RPM Commands**:
- **List all installed packages**:  
  `rpm -qa`
- **View package details**:  
  `rpm -qi <packagename>`
- **List files in a package**:  
  `rpm -ql <packagename>`
- **Install an RPM package**:  
  `rpm -ivh <Package.rpm>`
- **Remove an RPM package**:  
  `rpm -ev <packagename>`

#### **Yum Commands**:
- **List installed/available packages**:  
  `yum list`
- **Install a package**:  
  `yum install <packagename>`
- **Update a package**:  
  `yum update <packagename>`
- **Remove a package**:  
  `yum remove <packagename>`

---

# **Accessing Linux File Systems**

### **Goal**
- Access, inspect, and use existing file systems on storage attached to a Linux server.

### **Objectives**
- List the block devices and file systems.
- Mount and unmount file systems and partitions in Linux.
- Search for files on mounted file systems using the `find` and `locate` commands.

---

## **File system and mount points**

- To make the contents of a file system available in the file-system hierarchy, it must be mounted on an empty directory.
- This directory is called a **mount point**. Once mounted, if you use the `ls` command to list that directory, you will see the contents of the mounted file system, and you can access and use those files normally.
- Many file systems are automatically mounted as part of the boot process.

---

## **Examining file systems**

- To get an overview of local and remote file system devices and the amount of free space available, run the `df` command.
  
  ```bash
  df       # report file system disk space usage
  df -h    # print sizes in human-readable format (powers of 1024)
  ```

- **`du`**: Shows the size of all files in the current directory tree recursively.

  ```bash
  du -h    # human-readable format
  ```

---

## **Identifying the block device**

- Use the `lsblk` command to list the details of a specified block device or all available devices.

  ```bash
  lsblk -fp   # lists file system type and provides more details
  ```

---

## **Mounting and unmounting file systems**

- There are two common ways to specify the file system on a disk partition for the `mount` command:
  1. With the name of the device file in `/dev` containing the file system.
  2. With the UUID written to the file system, a universally-unique identifier (UUID).

### **Examples**:

- **Mounting using the name of the device:**

  ```bash
  mount <blockname> <dirname>
  mount /dev/vdb1 /mnt/data   # mounts /dev/vdb1 on /mnt/data
  mount /dev/nvme0n1p6 /data  # mounts /dev/nvme0n1p6 on /data
  ```

- **Mounting using UUID**:

  To get the UUID:

  ```bash
  lsblk -fd     # or blkid
  ```

  Then mount it using:

  ```bash
  mount UUID="<UUID>" <dirname>
  ```

- **Unmounting** a file system:

  ```bash
  umount <dirname>
  umount /data   # unmounts /data
  ```

- **Finding processes accessing a particular directory**:

  ```bash
  lsof /data    # shows processes using /data
  ```

- **`blkid`**: Prints block device attributes, such as UUIDs.


# **Searching for files on mounted file systems**

### **Locating files on the system**

A system administrator needs tools to search for files matching certain criteria on the file system. This section discusses two commands that can search for files in the file-system hierarchy:

1. **`locate`**: Searches a pre-generated index for file names or file paths and returns results instantly. It is fast because it looks up this information from the `mlocate` database.

   - However, this database is not updated in real time, so it must be frequently updated for results to be accurate.
   - The `locate` database is automatically updated every day, but the root user can manually update it by issuing the `updatedb` command.

#### **Examples**:

- **Locate** a file by name or path:

  ```bash
  locate file1          # searches for file1
  locate -i file1       # case-insensitive search
  locate -n 5 file1     # limit results to 5 entries
  ```

### **Searching for files in real time**

2. **`find`**: Performs a real-time search in the file-system hierarchy. It is slower than `locate` but more accurate. It can search for files based on various criteria, such as name, permissions, type, size, or modification time.

   - The `find` command searches files based on the account that executed the search. The user must have **read** and **execute** permissions on a directory to examine its contents.

#### **Examples**:

- **Search by name**:

  ```bash
  find <location> -name <filename>
  find / -name sshd_config            # searches for files named sshd_config starting from the / directory
  find / -name '*.txt'                # searches for all .txt files
  ```

- **Case-insensitive search by name**:

  ```bash
  find / -iname '*messages*'   # searches for files containing 'messages' in their names
  ```

- **Search by file owner**:

  ```bash
  find -user <username>
  find -user mohamed           # searches for files owned by mohamed
  ```

- **Search by group owner**:

  ```bash
  find -group <groupname>
  find -group mohamed          # searches for files owned by group mohamed
  ```

- **Search by user ID (UID)**:

  ```bash
  find -uid <uid>
  find -uid 1000               # searches for files owned by user with UID 1000
  ```

- **Search by file ownership and group**:

  ```bash
  find / -user root -group mail  # files owned by root and affiliated with group mail
  ```

---

## **Searching files based on permissions**

- The **`-perm`** option is used to search for files with a specific set of permissions, described as octal values (e.g., 764).

#### **Examples**:

- **Search for files with permissions 764**:

  ```bash
  find /home -perm 764
  ```

- **Search for files with at least specified permissions**:

  ```bash
  find /home -perm -324
  ```

---

## **Searching files based on size**

- Use the `-size` option with the `find` command, followed by a numerical value and the unit.
  
  **Units**:  
  - `k`: kilobyte  
  - `M`: megabyte  
  - `G`: gigabyte  

#### **Examples**:

- **Search for files of exactly 10 MB**:

  ```bash
  find / -size 10M
  ```

- **Search for files larger than 10 GB**:

  ```bash
  find / -size +10G
  ```

- **Search for files smaller than 10 KB**:

  ```bash
  find / -size -10k
  ```

- **Preallocate space for a file (1 GB)**:

  ```bash
  fallocate -l 1G file1
  ```

---

## **Searching files based on modification time**

- The **`-mmin`** option, followed by time in minutes, searches for files whose content was changed a certain number of minutes ago.  
  **Use `+`** for more than a certain time, and **`-`** for less than.

#### **Examples**:

- **Search for files modified exactly 120 minutes ago**:

  ```bash
  find / -mmin 120
  ```

- **Search for files modified more than 200 minutes ago**:

  ```bash
  find / -mmin +200
  ```

---

## **Searching files based on type**

- The **`-type`** option limits the search to a specific file type.  
  **Types**:  
  - `f`: regular file  
  - `d`: directory  
  - `l`: symbolic link  
  - `b`: block device

#### **Examples**:

- **Search for all directories in `/etc`**:

  ```bash
  find /etc -type d
  ```

- **Search for all symbolic links**:

  ```bash
  find / -type l
  ```

- **List all block devices in `/dev`**:

  ```bash
  find /dev -type b
  ```

---

## **Summary**
- **Block devices** represent storage devices in Linux.
- **The `df` command** reports disk usage and available space.
- **The `mount` command** attaches a file system, while `umount` detaches it.
- **The `find` command** performs real-time searches in local file systems based on various criteria like name, permissions, ownership, size, and modification time.

---

This document outlines everything you need to know about managing and searching file systems in Linux. Feel free to ask if you want to explore any specific command or concept further!
