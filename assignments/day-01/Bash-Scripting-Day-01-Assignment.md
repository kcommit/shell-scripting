# Bash Scripting — Day 1 Assignment

## Introduction to Shell, Machine, Commands, and Editors

**Level:** True Beginner  
**Estimated time:** 60–90 minutes  
**Total marks:** 100  
**Environment:** WSL Ubuntu, Linux virtual machine, EC2 lab, or another Linux practice machine

---

## Learning Objectives

After completing this assignment, the student should be able to:

- Explain the basic purpose of a shell.
- Recognize Bash as a Linux shell.
- Describe the simple Linux architecture.
- Display basic machine information.
- Navigate and work with files and directories.
- Open, edit, save, and close a file using Vim or Nano.
- Create a first Bash script using `echo`.
- Add a shebang and comments to a script.
- Give execute permission to a script.
- Run a script using `bash script.sh` and `./script.sh`.

---

## Topics Not Required Yet

Do not use these topics in the Day 1 assignment:

- User-created variables
- `read` or interactive input
- Positional arguments
- `if`, `else`, or `elif`
- Loops
- Functions
- Arrays
- Regex
- Advanced redirection
- User creation

These topics will be introduced later.

---

## Required Directory Structure

Create this directory structure:

```text
day-01/
├── README.md
├── environment.txt
├── commands.txt
├── editor-practice.txt
└── hello.sh
```

Create and enter the directory:

```bash
mkdir -p day-01
cd day-01
```

---

# Assignment Tasks

## Task 1 — Shell Introduction (10 Marks)

Run the following commands:

```bash
echo "$SHELL"
echo "$0"
bash --version
```

Answer these questions in `README.md`:

1. What is a shell?
2. What is Bash?
3. What does `$SHELL` show?
4. What does `$0` normally show?
5. What is the difference between a terminal and a shell?

### Expected understanding

- A terminal provides the window or interface.
- A shell reads and runs commands.
- Bash is one type of shell.

---

## Task 2 — Linux Architecture (10 Marks)

Study this simple Linux architecture:

```text
USER
  ↓
SHELL / BASH
  ↓
KERNEL
  ↓
HARDWARE
```

Write one simple sentence about each layer in `README.md`:

1. User
2. Shell/Bash
3. Kernel
4. Hardware

Answer this question:

```text
When a user types a command, which layer reads the command first?
```

---

## Task 3 — Inspect the Machine (15 Marks)

Run these commands:

```bash
whoami
hostname
pwd
uname -r
uptime
free -h
df -h
```

Create `environment.txt` using `echo`:

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

Display the file:

```bash
cat environment.txt
```

### Required result

`environment.txt` must contain the student's actual machine information.

---

## Task 4 — Practice Basic Commands (15 Marks)

Perform these steps inside the `day-01` directory:

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

Save the commands in `commands.txt`.

You may create the file with an editor and type the commands into it.

Answer these questions in `README.md`:

1. What does `mkdir` do?
2. What does `cd` do?
3. What does `touch` do?
4. What does `cp` do?
5. What does `mv` do?
6. What does `ls -l` show?
7. What does `cat` do?
8. What does `pwd` show?

---

## Task 5 — Practice Vim or Nano (15 Marks)

Choose **Vim** or **Nano**.

### Option A — Vim

Open a file:

```bash
vim editor-practice.txt
```

Complete these actions:

1. Press `i` to enter Insert mode.
2. Type the required text shown below.
3. Press `Esc` to return to Normal mode.
4. Type `:wq` and press Enter to save and quit.

### Option B — Nano

Open a file:

```bash
nano editor-practice.txt
```

Complete these actions:

1. Type the required text shown below.
2. Press `Ctrl+O` to save.
3. Press Enter to confirm the filename.
4. Press `Ctrl+X` to exit.

### Required text

```text
My name is: YOUR NAME
My editor is: Vim or Nano
My shell is: Bash
Today I created and edited my first Linux text file.
```

Display the saved file:

```bash
cat editor-practice.txt
```

---

## Task 6 — Create Your First Bash Script (20 Marks)

Create a file named `hello.sh`:

```bash
vim hello.sh
```

or:

```bash
nano hello.sh
```

The script must include:

1. A Bash shebang.
2. Script name in a comment.
3. Student name in a comment.
4. Script purpose in a comment.
5. At least four `echo` commands.
6. The `date`, `hostname`, and `pwd` commands.

### Required output messages

Your script must display these messages:

```text
NIT: Hello Doston
Welcome to Bash Scripting
This is my first Bash script
I am learning Linux automation
```

### Important rule

Use only simple commands. Do not use variables, `read`, conditions, loops, or functions.

---

## Task 7 — Script Permission and Execution (15 Marks)

First display the script permission:

```bash
ls -l hello.sh
```

Run the script using Bash:

```bash
bash hello.sh
```

Now give execute permission:

```bash
chmod u+x hello.sh
```

Check the permission again:

```bash
ls -l hello.sh
```

Run the script directly:

```bash
./hello.sh
```

Answer these questions in `README.md`:

1. What does `chmod u+x hello.sh` do?
2. Why can `bash hello.sh` run a readable script without its execute bit?
3. Why does `./hello.sh` require execute permission?
4. What does `./` mean?

---

# Final Verification

Run:

```bash
ls -l
cat environment.txt
cat editor-practice.txt
cat hello.sh
bash -n hello.sh
bash hello.sh
./hello.sh
```

### Correct result

- All required files exist.
- `bash -n hello.sh` displays no syntax error.
- `bash hello.sh` works.
- `./hello.sh` works after execute permission is added.
- The output contains the four required messages.
- The date, hostname, and current directory are displayed.

---

# Submission Checklist

- [ ] `README.md` contains all written answers.
- [ ] `environment.txt` contains real machine information.
- [ ] `commands.txt` contains the practiced commands.
- [ ] `editor-practice.txt` contains the required text.
- [ ] `hello.sh` contains the shebang and comments.
- [ ] `hello.sh` contains four `echo` messages.
- [ ] `hello.sh` runs with `bash hello.sh`.
- [ ] `hello.sh` runs with `./hello.sh` after `chmod u+x`.
- [ ] `bash -n hello.sh` reports no syntax error.
- [ ] No advanced Bash topics are used.

---

# Grading Rubric

| Task | Marks |
|---|---:|
| Task 1 — Shell introduction | 10 |
| Task 2 — Linux architecture | 10 |
| Task 3 — Machine inspection | 15 |
| Task 4 — Basic commands | 15 |
| Task 5 — Vim or Nano | 15 |
| Task 6 — First Bash script | 20 |
| Task 7 — Permission and execution | 15 |
| **Total** | **100** |

---

# Suggested Git Commit

```bash
git add day-01/
git commit -m "Complete Bash Day 1 beginner assignment"
```

---

**Day 1 learning path:** Understand the shell → inspect the machine → practice commands → use an editor → create a script → make it executable → run it.
