# Linux Commands and Concepts

## File and Directory Operations
- `ls -ltr` : List files with detailed info in reverse time order.
- `mkdir -p dir1/dir2/dir3` : Create nested directories.

## Links
- **Hard link**: Another name for a file that refers to the actual data.
- **Soft link**: A reference or pointer (similar to shortcuts in Windows).
- `ln <File> <HardLinkName>` : Create a hard link.
- `ln -s <File> <SoftLinkName>` : Create a soft link.
- `ls -li` : Show inode number.

## Pattern Matching
- `*` : Any string of zero or more characters.
- `?` : Any single character.
- `[abc...]` : Any one character within the class.
- `[!abc...]` / `[^abc...]` : Any one character not in the class.
- `[[:alpha:]]` : Any alphabetic character.
- `[[:lower:]]` : Lowercase characters.
- `[[:upper:]]` : Uppercase characters.
- `[[:alnum:]]` : Alphabetic characters or digits.
- `[[:punct:]]` : Any printable character that's not alphanumeric.
- `[[:digit:]]` : Digits (0-9).
- `[[:space:]]` : Any whitespace character (e.g., tab, space, newline).

## Basic Regular Expressions
- `.` : Any character.
- `^` : Matches the start of a string.
- `$` : Matches the end of a string.
- `*` : Zero or more occurrences of the preceding character.
- `\` : Escapes special characters.
- `()` : Groups regular expressions.
- `?` : Matches exactly one character.

## `cut` Command
- `cut -d : -f 1,7 /etc/passwd` : Extract fields 1 and 7 using `:` as a delimiter.

## `wc` Command
- `echo "I Love Linux" | wc` : Count words, lines, and characters.

## Variables
- **User-Defined Variables**: Custom variables in shell.
- **Shell Variables**: Built-in variables.
- `set` : List all shell variables.
- `echo $HISTSIZE` or `echo $HOME` : Display variable values.
- `export <variable>` : Export variable to child processes.
- `PATH` : A list of directories containing programs.
  - `PATH=PATH:/home/mohamed` : Append `/home/mohamed` to `PATH`.
- `env` : List environment variables.

---

# Managing Local Users and Groups

## User Accounts
- **Superuser** (UID 0), **System Users** (UID 1-999), **Regular Users** (UID 1000+).
- `whoami` : Show current user.
- `su` : Switch users without changing the directory.
- `su -` : Switch users and change to the user's home directory.
- `sudo` : Run commands as another user, typically root.
  - Configuration: `/etc/sudoers` (Edit using `visudo`).
  - Example: `user01 ALL=(ALL) ALL` : Enable full sudo access for user01.

## User Management
- `useradd <username>` : Create a new user.
  - Example: `useradd -md /home/user_1 -c "Planning user" -s /bin/sh -g mohamed -G wheel -u 5000 user01`.
- `usermod <username>` : Modify user information.
  - Example: `usermod -aG mohamed user01` : Append to secondary group.
- `userdel <username>` : Delete user (without home directory).
  - `userdel -r <username>` : Delete user with home directory.

## Group Management
- `groupadd -g 3000 group01` : Create group with ID 3000.
- `groupmod -n newgroup group01` : Rename group.
- `groupdel group01` : Delete group.

---

# Managing User Passwords

- User passwords are stored in `/etc/shadow` file with encrypted passwords.
- **Password Fields**: Username, encrypted password, last changed date, minimum days, maximum days, warning period, inactivity period, expiration date.

## Configuring Password Aging
- Example: `chage -m 0 -M 90 -W 7 -I 14 user03`.
  - `-m` : Minimum days before password change.
  - `-M` : Maximum days before password expires.
  - `-W` : Warning days before password expiration.
  - `-I` : Inactive days before account lock.

# Controlling Access to Files

## File Types
- **d** : Directory
- **-** : File
- **c** : Character device file
- **b** : Block device file
- **l** : Link file
- **p** : Pipe file

## File Permissions
Example: `-rwxr-x--- 1 root root 0 Oct 31 11:06 test`

### Changing Permissions (Symbolic Method)
- **u** : User
- **g** : Group
- **o** : Other
- **a** : All (User, Group, and Others)
- **r** : Read
- **w** : Write
- **x** : Execute

#### Usage:
- `chmod u+rwx, g=rx, o-wx test` : Set permissions for `test` file.
- `chmod o-w <filename>` : Remove write permission for others.

### Changing Permissions (Numeric Method)
- **rwx** : Read, write, execute.
- **7** : rwx (111)
- **6** : rw- (110)
- **5** : r-x (101)
- **4** : r-- (100)
  
#### Usage:
- `chmod 777 test` : Give full permissions to user, group, and others.

## Changing Ownership
- `chown mohamed file1` : Change ownership to `mohamed`.
- `chown mohamed:mohamed file1` : Change both owner and group.
- `chgrp mohamed file1` : Change group ownership.

## Special Permissions
- **Setuid**: `chmod u+s file1` or `chmod 4xxx file1`
- **Setgid**: `chmod g+s dir1` or `chmod 2xxx dir1`
- **Sticky bit**: `chmod o+t dir1` or `chmod 1xxx dir1`

## Searching Files
- `which <file>` : Search for a file in the system's PATH.
- `locate <file>` : Search for a file in the database.
- `updatedb` : Update the file location database.

## Default File Permissions
- `umask` : Displays the current umask value (default is `0022` for root, `0002` for regular users).
- `umask 007` : Set the umask to `007` (blocks permissions for others).

---

# Monitoring and Managing Linux Processes

## Process Information
- **PID** : Process ID
- **PPID** : Parent Process ID
- `whoami` : Show the current user.
- `ps aux` : Display all processes.
- `top` : Dynamic system process view (like Task Manager in Windows).
- `pstree` : Display all processes as a tree.

## Managing Background Processes
- `<command> &` : Run a command in the background.
- `jobs` : List background jobs.
- `fg %<job number>` : Bring background job to the foreground.
- `kill <PID>` : Kill a process by its ID.
- `kill -9 <PID>` : Forcefully kill a process.

## Process Scheduling and Priorities
- `nice -n 10 vim text &` : Start a process with a nice value of 10.
- `renice <nice value> <PID>` : Change the priority of a running process.

---

# Controlling Services and Daemons

## Systemd Commands
- `systemctl list-units --type=service` : List all active services.
- `systemctl status <service>` : View the status of a specific service.
- `systemctl start/stop/restart <service>` : Start, stop, or restart a service.
- `systemctl enable/disable <service>` : Enable or disable a service at boot.
- `systemctl mask/unmask <service>` : Mask or unmask a service.

---

# SSH Configuration and Security

## Connecting via SSH
- `ssh <username>@<remotehost>` : Create a remote shell session.
- `ssh <username>@<remotehost> 'date; ls -lh'` : Execute commands remotely without an interactive shell.

## SSH Authentication Types
1. **Password authentication**
2. **Key-based authentication**

## Key-based Authentication
- `ssh-keygen` : Generate an SSH key pair.
  - Private key: `~/.ssh/id_rsa`
  - Public key: `~/.ssh/id_rsa.pub`
- `ssh-copy-id -i ~/.ssh/id_rsa.pub mohamed@192.168.1.10` : Copy the public key to the remote host.
