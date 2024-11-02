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


### Variable Naming Conventions
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
### Best Practices for Nameing Variables
 - when naming variables, use daecriptive names that explain their purpose.

Examples
```bash
user_name 
file_count
```

Following these naming conventions helps make Bash scripts more readable and easier to maintain.

### Best Practices for Writing clean Scripts

 - Use Descriptive variables names to make your code self-explanatory.
 - Keep your scripts modular by breaking them into functions
 - Always test your scripts with different inputs to ensure they
 behave as expacted.
 - Comment your code to explain non-obvious parts or important logic.




## Input and Output in Bash Scripts

### Gathering Input

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

### Displaying Output

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

# looping in bash scripting

#### Comparison Operatorts :
 - Equal (eq) `=`
 - Not Equal (ne) `!=`
 - less than (lt) `<`
 - Greater Than (gt) `>`
 - Less than or equal to (le) `<=`
 - Greater than or equal to (ge) `>=`

Example :
```bash
[$a -eq $b] # True if $a equals $b
```
```bash
[$a -ne $b] # True if $a does not equal $b
```
```bash
[$a -lt $b] # True if $a is less than $b
```
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

### Conditional Statements with Logical Operators in Bash

This script uses conditional statements with `if`, `elif`, and logical operators `&&` (AND) and `||` (OR) to determine age-based categories for users.

#### Script

```bash
#!/bin/bash

age=17

if [ $age -ge 18 ] && [ $age -lt 65 ]; then
    echo "You are an adult of working age."
elif [ $age -ge 13 ] || [ $age -gt 65 ]; then
    echo "You are eligible for a discounted ticket."
else 
    echo "Your code is wrong."
fi
```

#### Explanation

1. The script assigns the variable `age` a value of 17.
2. It then uses `if` statements to check the value of `age` and outputs different messages based on conditions:
    - If `age` is between 18 and 64, it echoes **"You are an adult of working age."**
    - If `age` is either 13 or greater, or more than 65, it echoes **"You are eligible for a discounted ticket."**
    - If neither condition is met, it outputs **"Your code is wrong."**

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
### until loop

The `until` loop in Bash is the opposite of the `while` loop. It keeps executing the code inside the loop **until** a specified condition becomes true. This means it will run as long as the condition is false.

### Syntax

```bash
until [ condition ];
do
    # code to execute until the condition becomes true
done
```

The loop will stop executing once the condition evaluates to true.

### Example: Using an `until` Loop

Here's an example that counts from 1 to 5 using an `until` loop. The loop will run until the value of `counter` is greater than 5.

```bash
#!/bin/bash

counter=1

until [ $counter -gt 5 ]; 
do
    echo "Counter: $counter"
    ((counter++))
done
```

#### Explanation

1. **Initialize the Counter**: We set `counter=1` as our starting point.
2. **Condition**: `[ $counter -gt 5 ]` - the loop will keep running as long as `counter` is **not greater than 5**.
3. **Execution**: Inside the loop, it echoes the value of `counter` and then increments `counter` by 1 using `((counter++))`.
4. **Loop End**: Once `counter` becomes greater than 5, the loop stops.

#### Output

```plaintext
Counter: 1
Counter: 2
Counter: 3
Counter: 4
Counter: 5
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


# Functions in Bash Scripting

## What is a Function in Bash Scripting?

In programming, a function is a block of code that performs a specific task and can be called multiple times to execute that task. Functions provide modularity and reduce code length, making scripts more organized and manageable. Functions in Bash are similar to those in other programming languages.

### Example Script

```bash
#!/bin/bash
# Define a function
myFunction () {
    echo "Hello World from GeeksforGeeks"
}

# Call the function
myFunction
```

**Output:**
```plaintext
Hello World from GeeksforGeeks
```

### Syntax

```bash
# Define the function
function_name() {
    # Commands
}

# Call the function
function_name
```

---

## Functions with Arguments

You can pass arguments to functions in Bash, allowing the function to work with specific data. Inside the function, these arguments are accessed as `$1`, `$2`, and so on.

### Syntax

```bash
# Define a function with arguments
function_name() {
    parameter_1=$1
    parameter_2=$2
    # Commands
}

# Call the function with arguments
function_name p1 p2
```

### Example

```bash
#!/bin/bash

add_two_num() {
    local sum=$(($1 + $2))
    echo "Sum of $1 and $2 is $sum"
}

add_two_num 2 3
```

**Output:**
```plaintext
Sum of 2 and 3 is 5
```

---

## Functions with Return Values

In Bash, a function can return a value, which is assigned to the `$?` variable after the function call.

### Example

```bash
#!/bin/bash

myfun() {
    return 7
}

myfun
echo "The return value is $?"
```

**Output:**
```plaintext
The return value is 7
```

### Example: Return Value with Arguments

Modifying the sum function to use a return value:

```bash
#!/bin/bash

myfun() {
    return $(($1 + $2))
}

myfun 2 3
echo "The sum is $?"
```

**Output:**
```plaintext
The sum is 5
```

---

## Variable Scope in Functions

- **Global Variables**: By default, all variables are global in Bash, meaning they can be accessed from anywhere in the script.
- **Local Variables**: To limit a variable's scope to within a function, use the `local` keyword.

### Example

```bash
#!/bin/bash

var1="Apple" # Global variable
myfun() {
    local var2="Banana" # Local variable
    var3="Cherry" # Global variable
    echo "The name of first fruit is $var1"
    echo "The name of second fruit is $var2"
}
myfun

echo "The name of first fruit is $var1"
# Attempt to access local variable outside the function
echo "The name of second fruit is $var2"
echo "The name of third fruit is $var3"
```

**Output:**
```plaintext
The name of first fruit is Apple
The name of second fruit is Banana
The name of first fruit is Apple
The name of second fruit is
The name of third fruit is Cherry
```

---

## Overriding Commands

You can override built-in commands by defining functions with the same name. This can be useful to customize command behavior.

### Example

```bash
#!/bin/bash

# Override the echo command
echo() {
    builtin echo "The name is : $1"
}

echo "Satyajit Ghosh"
```

**Output:**
```plaintext
The name is : Satyajit Ghosh
```

---

## Conclusion

Functions are essential in Bash scripting, providing structure, modularity, and efficiency to scripts. With functions, you can:

- Break down complex tasks into manageable parts
- Reuse code efficiently
- Pass arguments, use return values, and manage variable scope
- Customize commands by overriding them

Mastering functions will enhance your scripting skills and enable you to write more powerful and flexible scripts.

---


# Standard Input, Output and Error
In Linux, the concepts of standard input (stdin), standard output (stdout), and standard error (stderr) are essential for managing data communication between applications. Here’s a breakdown:

### 1. **Standard Input (stdin)**: 
   - Stdin is the default data stream for receiving input data from the user or other applications. It typically comes from the keyboard but can be redirected from files or other data sources.

### 2. **Standard Output (stdout)**:
   - Stdout is the main data stream that applications use to send output. By default, it’s displayed on the console but can be redirected to files or other processes.

### 3. **Standard Error (stderr)**:
   - Stderr is used to output error messages. Unlike stdout, stderr is intended for error reporting. This separation helps in debugging by isolating error messages from regular output.

Each stream has a file descriptor:
- `0` for stdin
- `1` for stdout
- `2` for stderr

### Redirection and Manipulation
Streams can be redirected using `>` for output and `2>` for errors. Here’s a rundown of common redirection techniques:

- **Redirect stdout**: `command > file.txt` sends stdout to `file.txt`.
- **Redirect stderr**: `command 2> error.txt` sends stderr to `error.txt`.
- **Combine stdout and stderr**: `command &> file.txt` merges stderr into stdout so both go to `file.txt`.
- **Combine stdout and stderr**: `command > file.txt 2>&1` merges stderr into stdout so both go to `file.txt`.
- **Suppress output**: `command >/dev/null 2>&1` discards all output and errors.

### Examples
- **Basic Redirection**:
   ```bash
   ls /existing_path > output.txt        # Redirects stdout to output.txt
   ls /nonexistent_path 2> error.txt     # Redirects stderr to error.txt
   ```

- **Piping Streams**:
   Use `|` to chain commands, feeding stdout of one as stdin to another:
   ```bash
   ls | grep "pattern"                   # Lists files and filters for "pattern"
   ```

- **Here Documents**:
   Used to send multiple lines of input to a command:
   ```bash
   grep "text" <<EOF
   This is some text.
   Another line with text.
   EOF
   ```

### FAQs
1. **How do I redirect both output and error to the same file?**
   - Use `command > file.txt 2>&1`.
  
2. **How do I discard all output?**
   - Use `command > /dev/null 2>&1`.

3. **How to read user input in a shell script?**
   ```bash
   read -p "Enter your name: " name
   ```


## handking command -line arguments 
In shell scripting, command-line arguments allow users to pass data to scripts when they execute them. Here’s an overview of the special variables you can use to handle these arguments:

### 1. **Command-Line Arguments**:
   - `$0`: The name of the script itself.
   - `$1`, `$2`, …: These variables represent the individual arguments passed to the script. `$1` is the first argument, `$2` is the second, and so on.

   ```bash
   # Example
   ./myscript.sh arg1 arg2 arg3
   # $0 = ./myscript.sh
   # $1 = arg1
   # $2 = arg2
   # $3 = arg3
   ```

### 2. **Special Variables**:
   - `$#`: The number of command-line arguments passed to the script.
   - `$@`: All arguments passed to the script as separate quoted strings. This preserves each argument as a separate item.
   - `$*`: All arguments passed to the script as a single string. This treats all arguments as one combined string.

   ```bash
   # Script example:
   echo "Script name: $0"
   echo "First argument: $1"
   echo "Second argument: $2"
   echo "Total arguments: $#"
   echo "All arguments (\$@): $@"
   echo "All arguments (\$*): $*"
   ```

   Running the script with arguments:
   ```bash
   ./myscript.sh foo bar
   # Output:
   # Script name: ./myscript.sh
   # First argument: foo
   # Second argument: bar
   # Total arguments: 2
   # All arguments ($@): foo bar
   # All arguments ($*): foo bar
   ```

### **Difference between `$@` and `$*`**:
   - `$@` keeps each argument as a separate entity.
   - `$*` treats all arguments as a single string, which can sometimes lead to unexpected results when dealing with spaces.

For example:
   ```bash
   for arg in "$@"; do
       echo "$arg"
   done
   # This iterates through each argument individually.

   for arg in "$*"; do
       echo "$arg"
   done
   # This treats all arguments as one single string.
   ```

### Summary:
- **`$0`**: Script name.
- **`$1`, `$2`, ...**: Individual arguments.
- **`$#`**: Number of arguments.
- **`$@`**: All arguments as separate items.
- **`$*`**: All arguments as a single string. 

This gives flexibility for handling different numbers and types of inputs when scripting.

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
