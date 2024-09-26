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

