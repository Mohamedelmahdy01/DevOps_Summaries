# Linux Administration Summary

## Variables

### Types of Variables

- **Environmental Variables**: Typically in capital letters.
  - `env`: Show environmental variables.
- **User Defined Variables**: Typically in small letters.
  - `set`: Show environmental and user-defined variables.

### Using Variables

- **Print Variable**: `echo $<varname>`

### Shell Prompt

- `[mohamed2@mohamed ~]`
- `[user@machinename cwd]`: Stored in `PS1` variable.
  - Example: `PS1='[\u@\h \w]'`

### Editing Files

- **nano <filename>**: If the file exists, it opens, and if it does not exist, it creates a file.

### System and User Variables

- **System-wide Variables (global)**
  - Stored in `/etc/ <profile | bashrc>`.
- **User Specific Variables**
  - Stored in `<~/ .bash_profile | ~/ .bashrc>`.

### Aliases

- **Creating an Alias**: `alias <shortname>=<'longer command' | 'sequence of commands'>`
- **Print Aliases**: `alias -p`
- **Removing an Alias**: `unalias [alias name]`

### Alias Examples

- `alias ..='cd ..'`
- `alias cls='clear'`
- `alias ll='ls -l'`

## Redirection

- **Default Input**: Keyboard (`<`)
- **Default Output**: Screen (`>`)

### Overwrite and Append

- `>`: Overwrite.
- `>>`: Append.

### Redirection Examples

- `ls > result.txt`: Save output to `result.txt`.
- `ls install2 2> result.txt`: Save error to `result.txt`.
- `ls install.log install2 1>output.txt 2>error.txt`: Save output to `output.txt` and error to `error.txt`.
- `ls -l anaconda-ks.cfg meshwawgood 2&>result3.txt`: Save output and error to `result3.txt`.
- `ls -l anaconda-ks.cfg meshwawgood >>result3.txt 2>>result2.txt`: Append output to `result3.txt` and error to `result2.txt`.

### Using `cat` with Redirection

- `cat result3.txt == cat < result3.txt`: Default input is from the file.

## Text Manipulation

- `tr 'a-z' 'A-Z'`: Transform from lowercase to uppercase.
- `tr 'a-z' 'A-Z' <.bashrc >.bashrc`: Convert text in a Bash file from lowercase to uppercase and save the change.
- `grep [--color | -n | --color -n ] <keyword> <filename>`: Returns all lines that contain `keyword`.
  - Example: `grep 'root' /etc/passwd`

## Using `tee`

- **tee**: Split the output of a program so that it can be both displayed and saved in a file.

## Pipe

- **pipe**: `<|>`

### Pipe Example

- `find / -name passwd | grep [i | v | iv] 'bin'`: Find all files named passwd and return all lines containing "bin" from the find command.

## File Viewing

- **less <filename>**: Display file page by page.
- **more <filename>**: Display file page by page (closes automatically at the end).

## Sorting and Uniqueness

- **sort <filename>**: Sort lines in this file.
- **uniq**: Remove sequential redundancies.
  - Example: `cat test | sort | uniq`

## Cutting Fields

- **cut -<f1|f2|.....> -d <delimiter> <file>**: Display field number from file.
  - Example: `cut -f1 -d : /etc/passwd`

### Delimiters

- `:` (colon)
- `" "` (space)
- `;` (semicolon)

## Head and Tail

- **head [-n numberoflines] <filename>**: Display the number of lines from the beginning of the file (10 lines by default).
- **tail [-n numberoflines] <filename>**: Display the number of lines from the end of the file (10 lines by default).

### Head and Tail Example

- `head -n 3 /etc/passwd | tail -n 1 == head -n +3 /etc/passwd`: Display line 3 from file.

## Spell Checking

- **aspell check <filename>**: Check file for spelling errors.

## User Information

- **w**: Displays a list of all logged-in users and what they are doing.
  - This command is similar to `who` but displays more information about logged-in users.
- **PTS**: Pseudo terminal screen.

## Linking

### Soft Link

- **Usage**: Should use absolute path.
  - `ln -s /root/file2 /tmp/myfile`

### Hard Link

- **Usage**: It is no longer in common use and hard link is not allowed for directories.
  - `ln file2 file3`

## Master Boot Record (MBR) and Inode Number

### Master Boot Record (MBR)

**Purpose:**
- The MBR is a special type of boot sector located at the very beginning of partitioned storage devices like hard drives or SSDs.
- It contains the information required to boot the operating system, including the partition table that describes the layout of the partitions on the storage device.

**Key Features:**
- **Location:** The first sector of a storage device (sector 0).
- **Size:** Typically 512 bytes.
- **Components:** 
  - Bootloader: A small program that loads the operating system's bootloader.
  - Partition Table (64 bytes): Contains entries for the primary partitions (up to 4 in a traditional MBR scheme). Each one has 16 bytes.
  - Magic Number: Used to validate the integrity of the MBR.

**Usage:**
- Essential for booting legacy BIOS systems.
- Defines the structure of the storage device and the location of the partitions.

### Inode Number

**Purpose:**
- An inode number is an identifier used by many Unix-like file systems to identify files and directories.
- Each inode contains metadata about a file or directory (e.g., permissions, ownership, size, timestamps, and disk block locations) but not the name or the actual data content.

**Key Features:**
- **Location:** Spread throughout the file system; each file and directory has an associated inode.
- **Components:** 
  - Metadata: Information about the file/directory.
  - Pointers: Addresses pointing to the actual data blocks on the disk.

**Usage:**
- Used internally by the file system to manage and locate files.
- Allows efficient file access and management by separating metadata from file names.

### Comparison

| Feature                | MBR                             | Inode Number                    |
|------------------------|---------------------------------|---------------------------------|
| **Purpose**            | Bootstrapping and partitioning  | File system metadata management |
| **Location**           | First sector of storage device  | Throughout the file system      |
| **Size**               | 512 bytes typically             | Varies                          |
| **Content**            | Bootloader, partition table     | File metadata, pointers         |
| **Relevance**          | Boot process, partition layout  | File access and management      |
| **Operating System**   | Legacy BIOS systems             | Unix-like file systems          |

In summary, the MBR is crucial for booting and partition management, while inode numbers are essential for file system organization and file management.
