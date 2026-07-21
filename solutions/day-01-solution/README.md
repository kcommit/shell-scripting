# Bash Scripting Day 1 — True Beginner Solution

## Introduction to Shell, Machine, Commands, and Editors

This solution uses only the topics included in the Day 1 assignment:

- Shell and Bash introduction
- Simple Linux architecture
- Machine-information commands
- Basic file and directory commands
- Vim or Nano
- Shebang and comments
- `echo`
- Script permissions
- Script execution

The solution does not use user-created variables, `read`, arguments, conditions, loops, functions, arrays, regex, or user creation.

---

## Solution Files

```text
day-01-beginner-solution/
├── README.md
├── environment.txt
├── commands.txt
├── editor-practice.txt
└── hello.sh
```

---

# Task 1 Solution — Shell Introduction

## Commands

```bash
echo "$SHELL"
echo "$0"
bash --version
```

## Answers

### 1. What is a shell?

A shell is a program that reads commands from the user and asks the operating system to run them.

### 2. What is Bash?

Bash is a popular Linux shell. Its full name is **Bourne Again Shell**.

### 3. What does `$SHELL` show?

`$SHELL` normally shows the configured login shell.

Example:

```text
/bin/bash
```

### 4. What does `$0` normally show?

`$0` normally shows the name of the current shell or script.

Example inside an interactive Bash shell:

```text
bash
```

### 5. What is the difference between a terminal and a shell?

- A terminal provides the window or interface.
- A shell reads and executes commands inside the terminal.

---

# Task 2 Solution — Linux Architecture

```text
USER
  ↓
SHELL / BASH
  ↓
KERNEL
  ↓
HARDWARE
```

## Layer Descriptions

### User

The user types commands and uses Linux programs.

### Shell/Bash

The shell reads and understands the commands typed by the user.

### Kernel

The kernel is the core of Linux. It manages the CPU, memory, disks, devices, and processes.

### Hardware

Hardware includes the physical CPU, memory, storage devices, and network devices.

### Question: When a user types a command, which layer reads it first?

The **Shell/Bash** layer reads the command first.

---

# Task 3 Solution — Inspect the Machine

## Commands

```bash
whoami
hostname
pwd
uname -r
uptime
free -h
df -h
```

## Meanings

| Command | Meaning |
|---|---|
| `whoami` | Displays the current username. |
| `hostname` | Displays the machine name. |
| `pwd` | Displays the current directory. |
| `uname -r` | Displays the running Linux kernel version. |
| `uptime` | Displays how long the machine has been running. |
| `free -h` | Displays memory information in a readable format. |
| `df -h` | Displays filesystem disk usage in a readable format. |

The provided `environment.txt` is an example. Generate the correct version on your own machine:

```bash
echo "LINUX ENVIRONMENT INFORMATION" > environment.txt
echo "=============================" >> environment.txt
echo "Current user:" >> environment.txt
whoami >> environment.txt
echo "Hostname:" >> environment.txt
hostname >> environment.txt
echo "Current directory:" >> environment.txt
pwd >> environment.txt
echo "Login shell:" >> environment.txt
echo "$SHELL" >> environment.txt
echo "Kernel:" >> environment.txt
uname -r >> environment.txt
```

Display it:

```bash
cat environment.txt
```

---

# Task 4 Solution — Basic Commands

The completed commands are available in `commands.txt`.

## Command Answers

### 1. What does `mkdir` do?

`mkdir` creates a directory.

### 2. What does `cd` do?

`cd` changes the current directory.

### 3. What does `touch` do?

`touch` creates an empty file when the file does not exist. It updates the timestamp when the file already exists.

### 4. What does `cp` do?

`cp` copies a file or directory.

### 5. What does `mv` do?

`mv` moves or renames a file or directory.

### 6. What does `ls -l` show?

`ls -l` displays a long listing containing permissions, owner, group, size, date, and filename.

### 7. What does `cat` do?

`cat` displays the contents of a text file.

### 8. What does `pwd` show?

`pwd` shows the full path of the current working directory.

## Practice Commands

```bash
mkdir practice
cd practice
touch file1.txt
touch file2.txt
echo "My first Linux practice file" > file1.txt
cp file1.txt file1-copy.txt
mv file2.txt renamed-file.txt
ls
ls -l
cat file1.txt
pwd
cd ..
```

---

# Task 5 Solution — Vim or Nano

The completed example is available in `editor-practice.txt`.

## Vim Method

```bash
vim editor-practice.txt
```

1. Press `i`.
2. Type the text.
3. Press `Esc`.
4. Type `:wq`.
5. Press Enter.

## Nano Method

```bash
nano editor-practice.txt
```

1. Type the text.
2. Press `Ctrl+O`.
3. Press Enter.
4. Press `Ctrl+X`.

Display the file:

```bash
cat editor-practice.txt
```

---

# Task 6 Solution — First Bash Script

The completed script is `hello.sh`.

View it:

```bash
cat hello.sh
```

The script contains:

- `#!/bin/bash`
- Script name comment
- Student name comment
- Purpose comment
- Four required `echo` messages
- `date`
- `hostname`
- `pwd`

It does not contain variables, input, conditions, loops, arguments, or functions.

---

# Task 7 Solution — Permission and Execution

## Check Current Permission

```bash
ls -l hello.sh
```

## Run Through Bash

```bash
bash hello.sh
```

## Give Execute Permission

```bash
chmod u+x hello.sh
```

## Run Directly

```bash
./hello.sh
```

## Answers

### 1. What does `chmod u+x hello.sh` do?

It gives the file owner permission to execute `hello.sh`.

### 2. Why can `bash hello.sh` work without execute permission?

The Bash program is executed and then reads `hello.sh` as an input file. The script must be readable.

### 3. Why does `./hello.sh` require execute permission?

The operating system is asked to execute `hello.sh` directly, so the file needs execute permission.

### 4. What does `./` mean?

`./` means the file is located in the current directory.

---

# Final Verification

```bash
chmod u+x hello.sh

bash -n hello.sh
bash hello.sh
./hello.sh
```

Correct results:

- `bash -n hello.sh` displays no syntax error.
- Both execution methods display the same script output.
- The script displays the required messages.
- The script displays the current date, hostname, and directory.

---

# Suggested Git Commit

```bash
git add day-01-beginner-solution/
git commit -m "Add Bash Day 1 beginner assignment solution"
```

---

**Day 1 completed:** Shell → Linux architecture → machine → commands → editor → first script → permissions → execution.
