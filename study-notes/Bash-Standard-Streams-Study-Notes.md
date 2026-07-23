# Bash Standard Streams: stdin, stdout, and stderr

## Learning objectives

After completing these notes, you should be able to:

- Explain standard input, standard output, and standard error
- Recognize file descriptors `0`, `1`, and `2`
- Redirect normal output and error messages
- Read input from the keyboard or a file
- Send the output of one command to another command
- Hide unwanted output safely
- Write clear success and failure messages in Bash scripts
- Understand the difference between command output and exit status

---

## 1. What are standard streams?

When a Linux command starts, the operating system normally gives it three communication channels called **standard streams**.

| Stream | Short name | File descriptor | Default connection |
|---|---|---:|---|
| Standard input | stdin | `0` | Keyboard |
| Standard output | stdout | `1` | Terminal screen |
| Standard error | stderr | `2` | Terminal screen |

The numbers `0`, `1`, and `2` are called **file descriptors**.

```mermaid
flowchart LR
    A["Keyboard or file"] -->|"stdin: 0"| B["Command or script"]
    B -->|"stdout: 1"| C["Normal result"]
    B -->|"stderr: 2"| D["Error message"]
```

### Simple meaning

- **stdin** provides information to a command.
- **stdout** carries the command's normal result.
- **stderr** carries warnings and error messages.

---

## 2. Standard input — stdin

Standard input is the information received by a command or script.

Its file descriptor is:

```text
0
```

By default, stdin comes from the keyboard.

### Example: input from the keyboard

```bash
read -r -p "Enter your name: " name
echo "Hello, $name"
```

Explanation:

- `read` receives input.
- `-r` prevents backslashes from being treated as escape characters.
- `-p` displays a prompt.
- The entered value is stored in the variable `name`.

### Example: `cat` reading from the keyboard

```bash
cat
```

Type some text and press Enter. `cat` reads from stdin and displays the same text on stdout.

Press `Ctrl+D` to send an end-of-file signal and finish.

### Redirect a file into stdin

```bash
sort < students.txt
```

Here:

- `students.txt` becomes the input.
- `sort` reads the file through stdin.
- The sorted result appears on stdout.

This can also be written as:

```bash
sort students.txt
```

Both commands work, but the first one clearly demonstrates input redirection.

### Explicit stdin file descriptor

```bash
sort 0< students.txt
```

The `0` is optional because `<` redirects stdin by default.

---

## 3. Standard output — stdout

Standard output contains the normal or successful result of a command.

Its file descriptor is:

```text
1
```

By default, stdout appears on the terminal screen.

### Example

```bash
echo "NIT: Hello Doston"
```

The message is sent to stdout.

### Redirect stdout to a file

```bash
echo "Ali" > students.txt
```

The `>` operator:

- Creates the file if it does not exist
- Replaces the old content if the file already exists

### Explicit stdout file descriptor

```bash
echo "Ali" 1> students.txt
```

The `1` is optional because `>` redirects stdout by default.

### Append stdout to a file

```bash
echo "Sara" >> students.txt
echo "Omar" >> students.txt
```

The `>>` operator adds new content at the end without deleting the existing content.

### Important difference

```bash
command > file.txt
```

Overwrites the file.

```bash
command >> file.txt
```

Appends to the file.

---

## 4. Standard error — stderr

Standard error contains warnings, errors, and failure messages.

Its file descriptor is:

```text
2
```

By default, stderr also appears on the terminal. It uses a separate stream so normal output and errors can be handled independently.

### Generate normal output

```bash
ls /etc/passwd
```

The valid result is sent to stdout.

### Generate an error

```bash
ls /missing-file
```

The error message is sent to stderr.

### Redirect stderr to a file

```bash
ls /missing-file 2> errors.log
```

The error is saved in `errors.log` instead of appearing on the screen.

### Append stderr

```bash
ls /missing-one 2>> errors.log
ls /missing-two 2>> errors.log
```

Both errors are added to the same file.

### Send a script message to stderr

```bash
echo "Error: username is required" >&2
```

This is recommended for usage messages and failure messages.

Example:

```bash
#!/bin/bash

if [ "$#" -ne 1 ]
then
    echo "Usage: $0 USERNAME" >&2
    exit 1
fi

echo "Username received: $1"
exit 0
```

---

## 5. stdout and stderr look similar on the terminal

Both streams normally appear on the screen, so they may look like one stream. They are still separate.

Run:

```bash
ls /etc/passwd /missing-file
```

This command produces:

- A valid filename on stdout
- An error message on stderr

Save only stdout:

```bash
ls /etc/passwd /missing-file > success.log
```

Result:

- The valid result goes to `success.log`.
- The error remains on the terminal.

Save only stderr:

```bash
ls /etc/passwd /missing-file 2> errors.log
```

Result:

- The valid result remains on the terminal.
- The error goes to `errors.log`.

Save them separately:

```bash
ls /etc/passwd /missing-file > success.log 2> errors.log
```

---

## 6. Redirect stdout and stderr into one file

Use:

```bash
command > combined.log 2>&1
```

Example:

```bash
ls /etc/passwd /missing-file > combined.log 2>&1
```

Reading it from left to right:

1. `> combined.log` sends stdout to the file.
2. `2>&1` sends stderr to the current destination of stdout.

### Bash shortcut

In Bash, you can also write:

```bash
command &> combined.log
```

Append both streams:

```bash
command &>> combined.log
```

The longer `> file 2>&1` form is widely recognized and commonly appears in scripts and interviews.

---

## 7. Redirection order matters

These two commands are not identical:

```bash
command > output.log 2>&1
```

Both stdout and stderr go to `output.log`.

```bash
command 2>&1 > output.log
```

In the second command:

1. stderr is first connected to the terminal destination currently used by stdout.
2. stdout is then moved to `output.log`.
3. stderr remains on the terminal.

### Recommended form for one combined file

```bash
command > output.log 2>&1
```

Think of redirections as instructions processed from **left to right**.

---

## 8. Pipes

A pipe sends the stdout of one command to the stdin of another command.

The pipe operator is:

```text
|
```

### Example

```bash
cat students.txt | sort
```

Flow:

```text
cat stdout -> sort stdin
```

Another example:

```bash
cat /etc/passwd | grep bash
```

`cat` produces output, and `grep` receives it as input.

### Simpler command

When a command can read a file directly, this is usually better:

```bash
grep bash /etc/passwd
```

### A normal pipe does not carry stderr

```bash
command1 | command2
```

Only stdout from `command1` is piped to `command2`. stderr still goes to the terminal.

To include stderr:

```bash
command1 2>&1 | command2
```

Example:

```bash
ls /etc/passwd /missing-file 2>&1 | tee command.log
```

This displays both streams and saves them in `command.log`.

---

## 9. The `tee` command

`tee` displays output on the screen and writes it to a file at the same time.

```bash
echo "Deployment started" | tee deployment.log
```

Append instead of overwriting:

```bash
echo "Deployment completed" | tee -a deployment.log
```

Capture both stdout and stderr:

```bash
command 2>&1 | tee command.log
```

### Why DevOps engineers use `tee`

It is useful when you want to:

- Watch a command while it runs
- Save its output for troubleshooting
- Preserve a deployment or automation log

---

## 10. `/dev/null`

`/dev/null` is a special Linux device that discards anything written to it.

It is sometimes called the **bit bucket**.

### Hide stdout

```bash
command > /dev/null
```

Errors still appear.

### Hide stderr

```bash
command 2> /dev/null
```

Normal output still appears.

### Hide both stdout and stderr

```bash
command > /dev/null 2>&1
```

Bash shortcut:

```bash
command &> /dev/null
```

### Use carefully

Do not hide errors while learning or troubleshooting. Error messages often explain the exact problem.

Good use:

```bash
grep -q "Ali" students.txt
```

`grep -q` is designed for quiet checking, so it is often better than manually discarding useful output.

---

## 11. Streams are not the same as exit status

Command output and command exit status are different concepts.

### Output

The command may write text to stdout or stderr.

### Exit status

The command returns a number when it finishes:

- `0` normally means success.
- A non-zero value normally means failure.

Example:

```bash
ls /etc/passwd
echo "$?"
```

Expected status:

```text
0
```

Failure example:

```bash
ls /missing-file
echo "$?"
```

Expected status:

```text
2
```

The exact non-zero value can vary by command.

### Important rule

Check `$?` immediately:

```bash
some_command
status="$?"
echo "Exit status: $status"
```

Every new command replaces the previous value of `$?`.

---

## 12. Practical script example

Create `check-file.sh`:

```bash
#!/bin/bash

if [ "$#" -ne 1 ]
then
    echo "Usage: $0 FILE" >&2
    exit 1
fi

file="$1"

if [ ! -f "$file" ]
then
    echo "Error: file does not exist: $file" >&2
    exit 1
fi

echo "File found: $file"
echo "First three lines:"
head -n 3 "$file"
exit 0
```

Make it executable:

```bash
chmod u+x check-file.sh
```

Successful test:

```bash
./check-file.sh /etc/passwd
echo "$?"
```

Failed test:

```bash
./check-file.sh /missing-file
echo "$?"
```

Separate its streams:

```bash
./check-file.sh /etc/passwd > success.log 2> errors.log
./check-file.sh /missing-file >> success.log 2>> errors.log
```

Review the files:

```bash
cat success.log
cat errors.log
```

---

## 13. Common redirection operators

| Operator | Meaning |
|---|---|
| `< file` | Read stdin from a file |
| `> file` | Write stdout to a file and overwrite it |
| `>> file` | Append stdout to a file |
| `1> file` | Explicitly redirect stdout |
| `1>> file` | Explicitly append stdout |
| `2> file` | Write stderr to a file and overwrite it |
| `2>> file` | Append stderr to a file |
| `> file 2>&1` | Send stdout and stderr to one file |
| `&> file` | Bash shortcut for both streams |
| `|` | Send stdout to another command's stdin |
| `2>&1 \|` | Send stdout and stderr through a pipe |
| `>&2` | Send a message to stderr |
| `> /dev/null` | Discard stdout |
| `2> /dev/null` | Discard stderr |
| `> /dev/null 2>&1` | Discard both streams |

---

## 14. Common mistakes

### Mistake 1: overwriting a file accidentally

```bash
echo "Omar" > students.txt
```

This removes the old content.

Use `>>` when you want to append:

```bash
echo "Omar" >> students.txt
```

### Mistake 2: redirecting only stdout

```bash
command > command.log
```

Errors are not saved.

Use:

```bash
command > command.log 2>&1
```

### Mistake 3: using the wrong redirection order

```bash
command 2>&1 > command.log
```

This does not send both streams to the file.

Use:

```bash
command > command.log 2>&1
```

### Mistake 4: treating stderr as an exit status

An error message is text. An exit status is a number. They are related, but they are not the same thing.

### Mistake 5: hiding all errors too early

```bash
command > /dev/null 2>&1
```

During troubleshooting, run the command without redirection first so you can see the error.

### Mistake 6: forgetting quotes

Unsafe:

```bash
cat $file
```

Safer:

```bash
cat "$file"
```

Quoting protects filenames containing spaces and prevents unwanted word splitting.

---

## 15. Six-task beginner lab

### Task 1 — Observe stdout

Run:

```bash
echo "Hello Bash"
pwd
whoami
```

Identify the normal output produced by each command.

### Task 2 — Create stderr

Run:

```bash
ls /missing-file
cd /missing-directory
```

Notice the error messages and check the exit status immediately after each command.

### Task 3 — Separate the streams

Run:

```bash
ls /etc/passwd /missing-file > success.log 2> errors.log
```

Display both log files and explain why their contents are different.

### Task 4 — Practise stdin

Create a file:

```bash
echo "banana" > fruits.txt
echo "apple" >> fruits.txt
echo "cherry" >> fruits.txt
```

Sort it through stdin:

```bash
sort < fruits.txt
```

### Task 5 — Use a pipe and `tee`

Run:

```bash
cat fruits.txt | sort | tee sorted-fruits.txt
```

Confirm that the result appears on the terminal and in `sorted-fruits.txt`.

### Task 6 — Write a clear script

Create a script that:

1. Accepts one filename as an argument.
2. Sends a usage message to stderr if the argument is missing.
3. Sends a missing-file message to stderr.
4. Sends a success message to stdout.
5. Returns `0` for success and `1` for failure.
6. Is tested with separate `success.log` and `errors.log` files.

---

## 16. Interview questions

### 1. What are stdin, stdout, and stderr?

They are the three standard streams used by a process for input, normal output, and errors.

### 2. What are their file descriptor numbers?

- stdin: `0`
- stdout: `1`
- stderr: `2`

### 3. What is the difference between `>` and `>>`?

`>` overwrites a file, while `>>` appends to it.

### 4. How do you redirect only stderr?

```bash
command 2> errors.log
```

### 5. How do you combine stdout and stderr?

```bash
command > combined.log 2>&1
```

### 6. What does a pipe transfer?

By default, a pipe transfers stdout from the command on the left to stdin of the command on the right.

### 7. What is `/dev/null`?

It is a special device that discards data written to it.

### 8. What is the difference between stderr and exit status?

stderr carries error text. Exit status is a numeric result returned when the command finishes.

### 9. Why should failure messages be written to stderr?

It allows normal results and errors to be stored, piped, or handled separately.

### 10. Why does redirection order matter?

The shell processes redirections from left to right, so a file descriptor is copied to the destination that exists at that moment.

---

## 17. Quick revision

```text
stdin  = 0 = input
stdout = 1 = normal output
stderr = 2 = error output
```

```bash
command < input.txt
command > output.txt
command >> output.txt
command 2> errors.txt
command > all-output.txt 2>&1
command | another_command
command 2>&1 | tee command.log
echo "Error message" >&2
command > /dev/null 2>&1
```

## Final rule

Use stdout for useful results, stderr for problems, and meaningful exit statuses so people and automation tools can understand whether the script succeeded.
