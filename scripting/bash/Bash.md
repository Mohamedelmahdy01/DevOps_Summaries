# Bash Scripting Basics

## Introduction

### Definition of Bash Scripting
A bash script is a file containing a sequence of commands that are executed by the bash program line by line. It allows you to perform a series of actions, such as navigating to a specific directory, creating a folder, and launching a process using the command line.

By saving these commands in a script, you can repeat the same sequence of steps multiple times and execute them by running the script.

### Advantages of Bash Scripting
Bash scripting is a powerful and versatile tool for automating system administration tasks, managing system resources, and performing other routine tasks in Unix/Linux systems. Some advantages of shell scripting are:

- **Automation**: Shell scripts allow you to automate repetitive tasks and processes, saving time and reducing the risk of errors that can occur with manual execution.
- **Portability**: Shell scripts can be run on various platforms and operating systems, including Unix, Linux, macOS, and even Windows through emulators or virtual machines.
- **Flexibility**: Shell scripts are highly customizable and can be easily modified to suit specific requirements. They can also be combined with other programming languages or utilities to create more powerful scripts.
- **Accessibility**: Shell scripts are easy to write and don’t require any special tools or software. They can be edited using any text editor, and most operating systems have a built-in shell interpreter.
- **Integration**: Shell scripts can be integrated with other tools and applications, such as databases, web servers, and cloud services, allowing for more complex automation and system management tasks.
- **Debugging**: Shell scripts are easy to debug, and most shells have built-in debugging and error-reporting tools to help identify and fix issues quickly.

## Overview of the Bash Shell and Command Line Interface
The terms "shell" and "bash" are sometimes used interchangeably, but there is a subtle difference between the two. The term **shell** refers to a program that provides a command-line interface for interacting with an operating system. **Bash** (Bourne-Again SHell) is one of the most commonly used Unix/Linux shells and is the default shell in many Linux distributions.

## How to Create and Execute Bash Scripts

### Script Naming Conventions
By naming convention, bash scripts end with `.sh`. However, bash scripts can run perfectly fine without the `.sh` extension.

### Adding the Shebang
Bash scripts start with a shebang. Shebang is a combination of `#` (hash) and `!` (bang) followed by the bash shell path. This is the first line of the script and tells the shell to execute it via the bash shell. The shebang is simply an absolute path to the bash interpreter.

Below is an example of the shebang statement:

```bash
#!/bin/bash
```

You can find your bash shell path (which may vary from the above) using the command:

```bash
which bash
```

### Creating Our First Bash Script
Our first script prompts the user to enter a path. In return, its contents will be listed.

Create a file named `run_all.sh` using the `vi` command (or any editor of your choice):

```bash
vi run_all.sh
```

Add the following commands in your file and save it:

```bash
#!/bin/bash
echo "Today is " `date`

echo -e "\nEnter the path to directory"
read the_path

echo -e "\nYour path contains the following files and folders:"
ls $the_path
```

#### Explanation of the Script
1. **Line #1**: The shebang (`#!/bin/bash`) points toward the bash shell path.
2. **Line #2**: The `echo` command displays the current date and time on the terminal. Note that the `date` is enclosed in backticks.
3. **Line #4**: Prompts the user to enter a valid path.
4. **Line #5**: The `read` command reads the input and stores it in the variable `the_path`.
5. **Line #8**: The `ls` command takes the variable with the stored path and displays the current files and folders.

### Executing the Bash Script
To make the script executable, assign execution rights to your user with this command:

```bash
chmod u+x run_all.sh
```

Here:
- `chmod` modifies the ownership of a file for the current user (`u`).
- `+x` adds the execution rights to the current user.
- `run_all.sh` is the file we wish to run.

You can run the script using any of the following methods:

```bash
sh run_all.sh
bash run_all.sh
./run_all.sh
```

## Bash Scripting Basics

### Comments in Bash Scripting
Comments start with a `#` in bash scripting. Any line beginning with `#` is a comment and will be ignored by the interpreter. Comments are very helpful in documenting code, and it is a good practice to add them to help others understand the code.

Examples of comments:

```bash
# This is an example comment
# Both of these lines will be ignored by the interpreter
```

### Variables and Data Types in Bash
Variables let you store data. You can use variables to read, access, and manipulate data throughout your script. There are no data types in Bash; a variable can store numeric values, individual characters, or strings.

You can set and access variables as follows:

- Assign the value directly:

  ```bash
  country=egypt
  ```

- Assign a value based on the output obtained from a program or command:

  ```bash
  same_country=$country
  ```

To access the variable value, prepend `$` to the variable name:

```bash
country=egypt
echo $country     # Outputs: egypt
new_country=$country
echo $new_country # Outputs: egypt
```

#### Variable Naming Conventions
- Variable names should start with a letter or underscore `_`.
- Variable names can contain letters, numbers, and underscores `_`.
- Variable names are case-sensitive.
- Variable names should not contain spaces or special characters.
- Use descriptive names that reflect the purpose of the variable.
- Avoid using reserved keywords such as `if`, `then`, `else`, `fi`, etc., as variable names.

Examples of valid variable names:
```bash
name
count
_var
myVar
MY_VAR
```

Examples of invalid variable names:
```bash
2ndvar    # Variable name starts with a number
my var    # Variable name contains a space
my-var    # Variable name contains a hyphen
```

Following these naming conventions helps make Bash scripts more readable and easier to maintain.

### Input and Output in Bash Scripts

#### Gathering Input

1. **Reading User Input and Storing in a Variable**

    ```bash
    #!/bin/bash
    echo "What's your name?"
    read entered_name
    echo -e "\nWelcome to bash tutorial, $entered_name"
    ```

2. **Reading from a File**

    This code reads each line from a file named `input.txt` and prints it to the terminal:

    ```bash
    while read line
    do
      echo $line
    done < input.txt
    ```

3. **Command Line Arguments**

    `$1` denotes the first argument, `$2` the second, etc.

    ```bash
    #!/bin/bash
    echo "Hello, $1!"
    ```

#### Displaying Output

1. **Printing to the Terminal**:

    ```bash
    echo "Hello, World!"
    ```

2. **Writing to a File**:

    ```bash
    echo "This is some text." > output.txt
    ```

3. **Appending to a File**:

    ```bash
    echo "More text." >> output.txt
    ```

4. **Redirecting Output**:

    ```bash
    ls > files.txt
    ```

## Basic Bash Commands
Here is a list of some commonly used bash commands:

- `cd`: Change the directory.
- `ls`: List the contents of the current directory.
- `mkdir`: Create a new directory.
- `touch`: Create a new file.
- `rm`: Remove a file or directory.
- `cp`: Copy a file or directory.
- `mv`: Move or rename a file or directory.
- `echo`: Print text to the terminal.
- `cat`: Concatenate and print the contents of a file.
- `grep`: Search for a pattern in a file.
- `chmod`: Change the permissions of a file or directory.
- `sudo`: Run a command with administrative privileges.
- `df`: Display the amount of disk space available.
- `history`: Show a list of previously executed commands.
- `ps`: Display information about running processes.

---

## Conditional Statements (if/else)

Expressions that produce a boolean result, either true or false, are called conditions. We can evaluate conditions in various ways, including `if`, `if-else`, `if-elif-else`, and nested conditionals.

### Syntax
```bash
if [[ condition ]]; then
    statement
elif [[ condition ]]; then
    statement 
else
    do this by default
fi
```

You can use logical operators, such as `-a` (AND) and `-o` (OR), to make comparisons with more complex conditions.

```bash
if [ $a -gt 60 -a $b -lt 100 ]; then
    # do something
fi
```

### Example
Here's a Bash script that uses `if`, `if-else`, and `if-elif-else` statements to determine if a user-inputted number is positive, negative, or zero:

```bash
#!/bin/bash

echo "Please enter a number: "
read num

if [ $num -gt 0 ]; then
  echo "$num is positive"
elif [ $num -lt 0 ]; then
  echo "$num is negative"
else
  echo "$num is zero"
fi
```

The script prompts the user for a number and uses conditional statements to output whether the number is positive, negative, or zero.

---

## Looping and Branching in Bash

### While Loop
A `while` loop checks for a condition and continues looping while the condition remains true. To control loop execution, provide a counter statement that increments with each iteration.

```bash
#!/bin/bash
i=1
while [[ $i -le 10 ]] ; do
   echo "$i"
  (( i += 1 ))
done
```

### For Loop
A `for` loop also allows executing statements multiple times, but with different syntax. This example iterates five times:

```bash
#!/bin/bash

for i in {1..5}
do
    echo $i
done
```

---

## Case Statements

In Bash, `case` statements compare a value against a list of patterns and execute a block of code based on the first matching pattern.

### Syntax
```bash
case expression in
    pattern1)
        # code to execute if expression matches pattern1
        ;;
    pattern2)
        # code to execute if expression matches pattern2
        ;;
    *)
        # code to execute if none of the above patterns match expression
        ;;
esac
```

### Example
```bash
fruit="apple"

case $fruit in
    "apple")
        echo "This is a red fruit."
        ;;
    "banana")
        echo "This is a yellow fruit."
        ;;
    "orange")
        echo "This is an orange fruit."
        ;;
    *)
        echo "Unknown fruit."
        ;;
esac
```

In this example, the value of `fruit` determines the output.

---

## Scheduling Scripts with Cron

`cron` is a utility for job scheduling on Unix-like operating systems. You can automate jobs to run daily, weekly, monthly, or at specific times.

### Syntax
```bash
* * * * * sh /path/to/script.sh
```
Each `*` represents minute(s), hour(s), day(s), month(s), and weekday(s) respectively.

### Examples of Scheduling
| Schedule       | Description                              | Example                     |
|----------------|------------------------------------------|-----------------------------|
| `0 0`          | Run a script at midnight every day       | `0 0 /path/to/script.sh`    |
| `/5`           | Run a script every 5 minutes             | `/5 /path/to/script.sh`     |
| `0 6 1-5`      | Run a script at 6 am from Monday-Friday  | `0 6 1-5 /path/to/script.sh`|
| `0 0 1-7`      | Run a script on the first 7 days of each month | `0 0 1-7 /path/to/script.sh`|
| `0 12 1`       | Run a script at noon on the first day of each month | `0 12 1 /path/to/script.sh` |

### Using `crontab`
- `crontab -l`: List scheduled scripts for a user.
- `crontab -e`: Add or edit cron jobs.

---

## Debugging and Troubleshooting Bash Scripts

Debugging is crucial in Bash scripting to handle errors and unexpected behavior.

### Techniques for Debugging

#### Enable Debugging Mode
Use `set -x` at the beginning of the script to enable debugging mode. This causes Bash to print each command it executes to the terminal, which is helpful in identifying errors.

```bash
#!/bin/bash

set -x
# Your script goes here
```

#### Check the Exit Code
When Bash encounters an error, it sets an exit code. Use `$?` to check the exit code of the most recent command (0 for success, anything else indicates an error).

```bash
#!/bin/bash

# Your script
if [ $? -ne 0 ]; then
    echo "Error occurred."
fi
```

#### Use `echo` Statements
Insert `echo` statements to track variable values and the script's flow.

```bash
#!/bin/bash

# Your script
echo "Value of variable x is: $x"
```

#### Enable Immediate Exit on Error
Use `set -e` to exit the script immediately if any command fails.

```bash
#!/bin/bash

set -e
# Your script
```

---

## Troubleshooting Cron Jobs with Logs

Cron jobs generate logs that can be checked to verify if a job ran as expected. 

For Ubuntu/Debian, you can find cron logs in:
```plaintext
/var/log/syslog
```

### Example Log Output
```plaintext
2022-03-11 00:00:01 Task started
2022-03-11 00:00:02 Running script /path/to/script.sh
2022-03-11 00:00:03 Script completed successfully
2022-03-11 00:05:01 Task started
2022-03-11 00:05:02 Running script /path/to/script.sh
2022-03-11 00:05:03 Error: unable to connect to database
2022-03-11 00:05:03 Script exited with error code 1
2022-03-11 00:10:01 Task started
2022-03-11 00:10:02 Running script /path/to/script.sh
2022-03-11 00:10:03 Script completed successfully
```

---

## Conclusion

In this guide, we covered:
- How to use basic Bash commands and conditionals.
- Branching with loops and conditionals.
- Automating tasks with cron.
- Debugging and troubleshooting techniques.

Mastering these basics in Bash scripting will provide a solid foundation for automating tasks and managing systems effectively.
