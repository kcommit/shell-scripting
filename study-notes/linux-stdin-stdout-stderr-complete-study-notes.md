# Linux stdin, stdout, stderr, --stdin and --stdout
## Complete Study Notes (A to Z)

# Table of Contents

1. Introduction
2. Standard Streams
3. stdin (Standard Input)
4. stdout (Standard Output)
5. stderr (Standard Error)
6. Input and Output Flow
7. Redirection Operators
8. Understanding --stdin
9. Understanding --stdout
10. Pipes and Streams
11. Real Linux Examples
12. DevOps Examples
13. Interview Questions
14. Roman Urdu Summary
15. Quick Memory Tricks

---

# Introduction

Linux programs communicate using standard communication channels called Standard Streams.

Every Linux process automatically gets three streams:

1. stdin
2. stdout
3. stderr

These streams are the foundation of:

- Linux Administration
- Shell Scripting
- RHCSA
- DevOps
- Automation
- Troubleshooting

---

# Standard Streams

| Stream | Full Form | Stream Number | Default |
|----------|-----------|--------------|----------|
| stdin | Standard Input | 0 | Keyboard |
| stdout | Standard Output | 1 | Terminal Screen |
| stderr | Standard Error | 2 | Terminal Screen |

---

# stdin (Standard Input)

stdin is where a program receives its input.

Default source:

```text
Keyboard
```

Example:

```bash
cat
```

press "Enter"

Because `cat` is waiting for input from stdin (the keyboard).


Now type:

```text
Hello Khalid
```

press "Enter"

Output:

```text
Hello Khalid
```

Why did it appear?

Because:

1. You typed Hello Khalid
2. That text went into stdin
3. `cat` read it.
4. `cat` immediately printed it back to the screen.

Think of `cat` as a parrot.

You say:
```text
Hello
```
The parrot repeats:
```text
Hello
```
You say:
```text
Linux
```
The parrot repeats:
```text
Linux
```

Press:

```text
Ctrl + D
```

to stop input.

This sends EOF (End Of File).

It means:

"I'm done typing."

Then `cat` exits.

Flow:

```text
Keyboard
    ↓
 stdin
    ↓
 Program
```

# Another Example

Run:
```bash
sort
```
Now type:
```text
banana
apple
mango
orange
```
Nothing happens yet.

Press:
```text
Ctrl + D
```

Output:
```text
apple
banana
mango
orange
```

Why?

Because `sort` waits until it receives EOF before sorting all the input.


---

# stdout (Standard Output)

stdout is where a program sends normal output.

Example:

```bash
echo "Hello World"
```

Output:

```text
Hello World
```

Flow:

```text
Program
    ↓
 stdout
    ↓
 Screen
```

---

# stderr (Standard Error)

stderr is used for error messages.

Example:

```bash
ls file-does-not-exist
```

Output:

```text
ls: cannot access 'file-does-not-exist': No such file or directory
```

This message goes to stderr.

Flow:

```text
Program
    ↓
 stderr
    ↓
 Screen
```

---

# Understanding File Descriptors

Linux represents streams using numbers.

| Stream | File Descriptor |
|----------|----------------|
| stdin | 0 |
| stdout | 1 |
| stderr | 2 |

Examples:

```bash
1> output.txt
2> error.log
0< input.txt
```

---

# Input and Output Flow

```text
Keyboard
   │
   ▼
 stdin (0)
   │
   ▼
Program
   │
   ├── stdout (1) → Screen
   │
   └── stderr (2) → Screen
```

---

# Redirect stdout

Save output to a file:

```bash
echo "Hello Khalid" > file.txt
```

Check:

```bash
cat file.txt
```

Output:

```text
Hello Khalid
```

---

# Append stdout

```bash
echo "Another Line" >> file.txt
```

---

# Redirect stderr

```bash
ls missingfile 2> error.log
```

View:

```bash
cat error.log
```

---

# Redirect stdin

```bash
cat < file.txt
```

Flow:

```text
file.txt
   ↓
stdin
   ↓
cat
```

---

# Redirect stdout and stderr Together

```bash
command > output.log 2>&1
```

Meaning:

```text
stdout → output.log
stderr → output.log
```

---

# Understanding --stdin

Some commands support:

```bash
--stdin
```

Meaning:

```text
Read data from Standard Input.
```

Example:

```bash
echo "mypassword" | passwd --stdin khalid
```

Flow:

```text
echo
  ↓
stdin
  ↓
passwd
```

Used mostly on RHEL-based systems.

---

# Understanding --stdout

Some commands support:

```bash
--stdout
```

Meaning:

```text
Send output to Standard Output.
```

Example:

```bash
gzip --stdout file.txt
```

Equivalent:

```bash
gzip -c file.txt
```

Can be redirected:

```bash
gzip --stdout file.txt > file.txt.gz
```

---

# Pipes

Pipe operator:

```bash
|
```

Pipe takes stdout of one command and sends it to stdin of another.

Example:

```bash
echo "hello" | grep hello
```

Flow:

```text
echo
  ↓ stdout
  ↓
stdin
  ↓
grep
```

---

# Real Linux Examples

Show processes:

```bash
ps aux | grep ssh
```

Search logs:

```bash
cat /var/log/syslog | grep error
```

Count users:

```bash
cat /etc/passwd | wc -l
```

---

# DevOps Examples

Check website:

```bash
curl -I https://google.com
```

Save output:

```bash
curl https://example.com > website.html
```

Redirect errors:

```bash
curl https://wrong-url.com 2> curl-errors.log
```

---

# Common Redirection Operators

| Operator | Purpose |
|-----------|---------|
| > | Redirect stdout |
| >> | Append stdout |
| < | Redirect stdin |
| 2> | Redirect stderr |
| 2>> | Append stderr |
| 2>&1 | Combine stderr with stdout |
| | | Pipe stdout to another command |

---

# Interview Questions

## What is stdin?

Standard Input, usually the keyboard.

## What is stdout?

Standard Output, usually the terminal screen.

## What is stderr?

Standard Error, used for error messages.

## What is file descriptor 0?

stdin

## What is file descriptor 1?

stdout

## What is file descriptor 2?

stderr

## What does --stdin mean?

Read data from standard input.

## What does --stdout mean?

Send data to standard output.

## What is the difference between > and >> ?

> overwrites a file.
>> appends to a file.

---

# Quick Memory Tricks

```text
stdin  = Input  = Andar

stdout = Output = Bahar

stderr = Error  = Problem
```

---

# Roman Urdu Summary

stdin ka matlab hai program input kahan se le raha hai.

Default stdin keyboard hota hai.

stdout ka matlab hai program output kahan bhej raha hai.

Default stdout screen hoti hai.

stderr error messages ke liye use hota hai.

--stdin ka matlab:

Input stdin se lo.

--stdout ka matlab:

Output stdout par bhejo.

Linux mein pipes, redirection aur shell scripting ka sara concept stdin, stdout aur stderr par based hai.

---

# Conclusion

stdin, stdout, stderr, --stdin and --stdout Linux ke bunyadi concepts hain. In concepts ko samajhna Linux Administration, RHCSA, Shell Scripting, DevOps, CI/CD aur troubleshooting ke liye bohat zaroori hai.
