# Shell Scripting — From Beginner to Automation

A structured, hands-on Bash scripting repository containing lessons, practice labs, assignments, solutions, quizzes, posters, and progressively more advanced automation projects.

This project begins with true beginner concepts and introduces advanced topics only after the required foundations have been practiced.

## Learning Method

```text
Learn → Type → Run → Make Mistakes → Debug → Verify → Automate
```

Each learning day may include:

- Lesson notes
- Beginner-friendly command practice
- Hands-on assignment
- Separate instructor solution
- Interactive MCQ quiz
- Visual study poster
- Verification checklist

## Current Course Progress

### Day 1 — Shell and Bash Introduction

Topics:

- What a shell is
- Bash introduction
- Terminal versus shell
- Simple Linux architecture
- User → Shell → Kernel → Hardware
- Machine-information commands
- Basic file and directory commands
- Vim and Nano introduction
- Shebang and comments
- First Bash script
- Execute permission
- `bash hello.sh` versus `./hello.sh`

### Day 2 — Output, Variables, and User Creation

Topics:

- Standard output and standard error
- Successful and failed commands
- Exit status using `$?`
- `&&` and `||`
- Multiline descriptions
- Simple Bash variables
- Variable expansion
- User input with `read`
- Creating a Linux user with `useradd`
- Checking users with `id` and `getent passwd`
- Verifying the real command result before reporting success

## Repository Structure

```text
shell-scripting/
├── README.md
├── Day-01-Shell-Basics/
│   ├── Assignment/
│   ├── Solution/
│   ├── MCQ-Quiz/
│   └── Posters/
├── Day-02-Output-Variables-User-Creation/
│   ├── Assignment/
│   ├── Solution/
│   ├── MCQ-Quiz/
│   └── Posters/
└── Future-Days/
```

Empty directories are not stored by Git. Add a `README.md` or `.gitkeep` file when an empty directory must be preserved.

## Beginner Rules

The scripts for each day use only concepts already taught by that point.

For example, the first beginner scripts do not use:

- Functions
- Arrays
- Loops
- Advanced argument parsing
- Strict mode
- Regular expressions
- Complex error-handling frameworks

These concepts will be introduced gradually in later lessons.

## Basic Environment

You can practice using:

- Ubuntu Linux
- WSL Ubuntu on Windows
- A Linux virtual machine
- An approved AWS EC2 lab instance

Check the environment:

```bash
echo "$SHELL"
echo "$0"
bash --version
whoami
hostname
pwd
```

## Running a Bash Script

Run a readable script through Bash:

```bash
bash hello.sh
```

Give the script execute permission and run it directly:

```bash
chmod u+x hello.sh
./hello.sh
```

Check its syntax:

```bash
bash -n hello.sh
```

No output from `bash -n` normally means no syntax error was found.

## Working with Assignments and Solutions

Students should complete the assignment before opening the corresponding solution.

Recommended workflow:

1. Read the assignment.
2. Type every command manually.
3. Create the required scripts.
4. Test successful and failed cases.
5. Record errors and corrections.
6. Run the verification commands.
7. Compare the work with the solution.
8. Complete the MCQ quiz.

## Safety Notes

- Use WSL, a disposable VM, or another approved Linux lab.
- Do not test user-management or deletion scripts on production systems.
- Do not manually edit `/etc/passwd`, `/etc/shadow`, or `/etc/group`.
- Never store plaintext passwords, tokens, private keys, or cloud credentials in Git.
- Check a command's result before printing a success message.
- Read scripts carefully before using `sudo`.

## Planned Learning Roadmap

| Stage | Topics |
|---|---|
| Foundation | Shell, Bash, commands, editors, scripts, permissions |
| Variables and input | Variables, quoting, input, substitution, arguments |
| Decisions | Exit status, tests, `if`, `elif`, `else`, `case` |
| Repetition | `for`, `while`, `until`, `break`, `continue` |
| Reusable scripts | Functions, parameters, local variables, return status |
| Structured data | Indexed and associative arrays |
| Linux automation | Files, logs, processes, services, backups, monitoring |
| Production practices | Validation, logging, traps, debugging, ShellCheck, testing |
| Capstone | Linux Operations Automation Toolkit |

## Git Workflow

```bash
git status
git add .
git commit -m "Add Bash scripting learning materials"
git push
```

Use small and meaningful commits for each learning day.

## Repository

```text
https://github.com/kcommit/shell-scripting
```

## Author

**Muhammad Khalid Khan**  
GitHub: [kcommit](https://github.com/kcommit)

## Purpose

The purpose of this repository is to build practical Bash scripting skills through consistent terminal practice, carefully sequenced assignments, and real Linux administration examples.

---

**Start simple. Understand every line. Then automate with confidence.**
