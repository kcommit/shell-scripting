# Bash Standard Streams and Error Redirection Study Notes

## 1. Introduction

Every Linux command normally works with three standard data streams:

| File Descriptor | Stream | Purpose |
|---:|---|---|
| `0` | `stdin` | Standard input |
| `1` | `stdout` | Standard output |
| `2` | `stderr` | Standard error |

Example:

```bash
cat abc.txt
```

If `abc.txt` does not exist, Bash displays:

```text
cat: abc.txt: No such file or directory
```

This message is sent through **stderr**, not stdout.

---

## 2. Important Concept

`stderr` is **not a folder**.

It is an output stream used by commands to display error messages.

You can redirect stderr into any file or folder you create.

---

## 3. Redirect stdout

Use `>` to send standard output into a file.

```bash
ls > output.log
```

This overwrites the file.

To append output:

```bash
ls >> output.log
```

---

## 4. Redirect stderr

Use `2>` to send error messages into a file.

```bash
cat abc.txt 2> error.log
```

Because `abc.txt` does not exist, the error is saved in `error.log`.

Check it:

```bash
cat error.log
```

Output:

```text
cat: abc.txt: No such file or directory
```

### Append stderr

```bash
cat abc.txt 2>> error.log
```

- `2>` overwrites the file.
- `2>>` appends to the file.

---

## 5. Why This Command Failed

Incorrect command:

```bash
cat abc.txt 2>
```

Error:

```text
-bash: syntax error near unexpected token `newline'
```

Reason:

`2>` must be followed by a destination filename.

Correct example:

```bash
cat abc.txt 2> error.log
```

---

## 6. Understanding `2>&1`

Command:

```bash
cat abc.txt 2>&1
```

Meaning:

```text
Send stderr to the same destination where stdout is currently going.
```

Since stdout is still connected to the terminal, the error also appears on the terminal.

```text
cat: abc.txt: No such file or directory
```

`2>&1` alone does not automatically create a log file.

---

## 7. Save stdout and stderr in the Same File

Traditional syntax:

```bash
cat abc.txt > combined.log 2>&1
```

Bash shortcut:

```bash
cat abc.txt &> combined.log
```

Both commands save stdout and stderr into `combined.log`.

Check the file:

```bash
cat combined.log
```

---

## 8. Why Nothing Appeared on the Terminal

Command:

```bash
cat abc.txt &> combined.log
```

Nothing appeared because both output streams were redirected:

- stdout went to `combined.log`
- stderr went to `combined.log`

The command still produced an error, but the error was saved instead of displayed.

Check:

```bash
cat combined.log
```

---

## 9. Append stdout and stderr Together

```bash
cat abc.txt &>> combined.log
```

Equivalent form:

```bash
cat abc.txt >> combined.log 2>&1
```

This adds new output to the end of the existing file.

---

## 10. Save stdout and stderr Separately

```bash
command > output.log 2> error.log
```

Example:

```bash
ls create_user.sh abc.txt > output.log 2> error.log
```

Expected result:

`output.log` contains:

```text
create_user.sh
```

`error.log` contains:

```text
ls: cannot access 'abc.txt': No such file or directory
```

---

## 11. Create a Dedicated Logs Folder

```bash
mkdir -p logs
```

Save normal output:

```bash
ls > logs/stdout.log
```

Save errors:

```bash
cat abc.txt 2> logs/stderr.log
```

Save both:

```bash
cat abc.txt &> logs/combined.log
```

Suggested structure:

```text
project/
├── script.sh
└── logs/
    ├── stdout.log
    ├── stderr.log
    └── combined.log
```

---

## 12. Redirection Order Matters

Correct:

```bash
command > output.log 2>&1
```

Processing order:

1. stdout is redirected to `output.log`
2. stderr is redirected to the current stdout destination
3. both streams go to `output.log`

Different behavior:

```bash
command 2>&1 > output.log
```

Processing order:

1. stderr is connected to the terminal
2. stdout is redirected to `output.log`
3. stderr remains on the terminal

Therefore, redirections are processed from left to right.

---

## 13. Discard Error Messages

Use `/dev/null` when you do not want to save or display errors.

```bash
cat abc.txt 2> /dev/null
```

Discard stdout:

```bash
command > /dev/null
```

Discard both stdout and stderr:

```bash
command > /dev/null 2>&1
```

Bash shortcut:

```bash
command &> /dev/null
```

Use this carefully because important errors may be hidden.

---

## 14. Redirect Errors for an Entire Script

Example:

```bash
#!/bin/bash

mkdir -p logs

exec 2>> logs/stderr.log

echo "Script started"

cat abc.txt
ls /wrong-directory

echo "Script finished"
```

After this line:

```bash
exec 2>> logs/stderr.log
```

all later stderr messages are appended to `logs/stderr.log`.

---

## 15. Redirect stdout and stderr for an Entire Script

```bash
#!/bin/bash

mkdir -p logs

exec >> logs/stdout.log
exec 2>> logs/stderr.log

echo "Script started"

ls
cat abc.txt

echo "Script finished"
```

Normal output goes to:

```text
logs/stdout.log
```

Errors go to:

```text
logs/stderr.log
```

---

## 16. Add Date and Time to Log Files

```bash
mkdir -p logs

LOG_FILE="logs/error-$(date '+%Y-%m-%d_%H-%M-%S').log"

cat abc.txt 2> "$LOG_FILE"
```

Example filename:

```text
logs/error-2026-07-23_05-30-15.log
```

---

## 17. Practical Logging Script

```bash
#!/bin/bash

LOG_DIR="./logs"
STDOUT_LOG="$LOG_DIR/stdout.log"
STDERR_LOG="$LOG_DIR/stderr.log"

mkdir -p "$LOG_DIR"

exec >> "$STDOUT_LOG"
exec 2>> "$STDERR_LOG"

echo "[$(date)] Script started"

ls
cat abc.txt

status=$?

echo "[$(date)] Last command exit status: $status"
echo "[$(date)] Script finished"
```

---

## 18. Quick Reference Table

| Syntax | Meaning |
|---|---|
| `>` | Redirect stdout and overwrite |
| `>>` | Redirect stdout and append |
| `2>` | Redirect stderr and overwrite |
| `2>>` | Redirect stderr and append |
| `2>&1` | Send stderr to stdout's current destination |
| `&>` | Redirect stdout and stderr; overwrite |
| `&>>` | Redirect stdout and stderr; append |
| `<` | Redirect file into stdin |
| `/dev/null` | Discard output |

---

## 19. Practice Commands

### Practice 1

```bash
cat missing.txt
```

Observe the error on the terminal.

### Practice 2

```bash
cat missing.txt 2> error.log
cat error.log
```

### Practice 3

```bash
ls > output.log
cat output.log
```

### Practice 4

```bash
ls create_user.sh missing.txt > output.log 2> error.log
```

Check both files:

```bash
cat output.log
cat error.log
```

### Practice 5

```bash
cat missing.txt &> combined.log
cat combined.log
```

### Practice 6

```bash
cat missing.txt &>> combined.log
cat combined.log
```

---

## 20. Interview Questions

### Question 1

What is the file descriptor number for stderr?

**Answer:** `2`

### Question 2

What is the difference between `2>` and `2>>`?

**Answer:**

- `2>` overwrites the destination file.
- `2>>` appends to the destination file.

### Question 3

What does `2>&1` mean?

**Answer:** Redirect stderr to the current destination of stdout.

### Question 4

What does this command do?

```bash
command > output.log 2>&1
```

**Answer:** It saves both stdout and stderr in `output.log`.

### Question 5

Why does redirection order matter?

**Answer:** Bash processes redirections from left to right.

---

## 21. Final Memory Rule

```text
0 = stdin
1 = stdout
2 = stderr
```

Remember:

```bash
command > output.log 2> error.log
```

means:

```text
Normal output goes to output.log.
Error output goes to error.log.
```
