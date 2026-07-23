# Bash Scripting Level 2 — Solution Guide

This folder contains the tested solution for the nine-task Guided Automation Lab.

## Three-stage solution flow

| Stage | Tasks | Result |
|---|---:|---|
| 1. Combined basics | 1-3 | Arguments, conditions, validation, and exit statuses |
| 2. Local automation | 4-6 | Directories, copying, command chaining, backups, and logs |
| 3. Connected project | 7-9 | Preflight, processing, controller, and audit log |

## Solution files

```text
Bash-Level-2-Solution/
├── README.md
├── 01-user-role.sh
├── 02-argument-check.sh
├── 03-homework-validator.sh
├── 04-workspace-setup.sh
├── 05-homework-copy.sh
├── 06-backup-with-log.sh
├── 07-submission-preflight.sh
├── 08-submission-processor.sh
├── 09-submission-controller.sh
└── data/
    ├── homework-ali.txt
    ├── homework-sara.txt
    └── empty-homework.txt
```

## Important Level 2 rules

- Validate the argument count before using positional arguments.
- Send errors to standard error with `>&2`.
- Return `0` for success and non-zero for failure.
- Quote file paths and variable expansions.
- Check files before copying them.
- Create directories before writing into them.
- Use `>>` when old log records must remain.
- Stop the flow when a required step fails.

## Prepare the solution

Enter this directory and add executable permission:

```bash
cd Bash-Level-2-Solution
chmod u+x *.sh
```

Check every script:

```bash
bash -n 01-user-role.sh
bash -n 02-argument-check.sh
bash -n 03-homework-validator.sh
bash -n 04-workspace-setup.sh
bash -n 05-homework-copy.sh
bash -n 06-backup-with-log.sh
bash -n 07-submission-preflight.sh
bash -n 08-submission-processor.sh
bash -n 09-submission-controller.sh
```

No output means Bash found no syntax errors.

---

# Stage 1 — Combined Basics

## Task 1 — User Role

Script:

```text
01-user-role.sh
```

Tests:

```bash
./01-user-role.sh Ali student
./01-user-role.sh Khalid teacher
./01-user-role.sh Sara visitor
```

Expected access messages:

| Role | Access |
|---|---|
| `student` | Learning area |
| `teacher` | Teaching area |
| Any other role | Guest area |

This task combines `$1` and `$2` with string conditions.

## Task 2 — Argument Count

Script:

```text
02-argument-check.sh
```

Success:

```bash
./02-argument-check.sh inventory-api dev
echo "$?"
```

Expected status: `0`.

Failure:

```bash
./02-argument-check.sh inventory-api
echo "$?"
```

Expected status: `1`.

The important condition is:

```bash
if [ "$#" -ne 2 ]
```

## Task 3 — Homework Validator

Script:

```text
03-homework-validator.sh
```

Tests:

```bash
./03-homework-validator.sh data/homework-ali.txt
echo "$?"

./03-homework-validator.sh data/missing.txt
echo "$?"

./03-homework-validator.sh data/empty-homework.txt
echo "$?"
```

The script uses:

| Test | Meaning |
|---|---|
| `-f` | Existing regular file |
| `-s` | Existing non-empty file |
| `!` | Reverse the test result |

Only the first test should return `0`.

---

# Stage 2 — Local Automation

## Task 4 — Workspace Setup

Script:

```text
04-workspace-setup.sh
```

Run:

```bash
./04-workspace-setup.sh bash-101
echo "$?"
```

Verify:

```bash
find classroom/bash-101 -maxdepth 1 -type d
```

Expected directories:

```text
classroom/bash-101/incoming
classroom/bash-101/processed
classroom/bash-101/reports
```

The `&&` chain continues only while the preceding command succeeds.

## Task 5 — Homework Copy

Script:

```text
05-homework-copy.sh
```

Success:

```bash
./05-homework-copy.sh data/homework-ali.txt classroom/bash-101/incoming
echo "$?"
```

Failure:

```bash
./05-homework-copy.sh data/missing.txt classroom/bash-101/incoming
echo "$?"
```

The script uses `||` to run a failure block when `mkdir` or `cp` fails.

## Task 6 — Timestamped Backup

Script:

```text
06-backup-with-log.sh
```

Run:

```bash
./06-backup-with-log.sh data/homework-ali.txt backups
echo "$?"
```

Verify:

```bash
find backups -type f
cat logs/backup.log
```

The backup name contains:

```text
YYYYMMDD-HHMMSS-original-filename
```

The script appends the log with `>>`, so older records remain.

---

# Stage 3 — Connected Student-Submission Project

## Project flow

```text
07-submission-preflight.sh
            |
            v
08-submission-processor.sh
            |
            v
09-submission-controller.sh
```

## Task 7 — Submission Preflight

Script:

```text
07-submission-preflight.sh
```

Success:

```bash
./07-submission-preflight.sh Ali data/homework-ali.txt
echo "$?"
```

Failure tests:

```bash
./07-submission-preflight.sh Ali data/missing.txt
./07-submission-preflight.sh Ali data/empty-homework.txt
./07-submission-preflight.sh "Ali/Khan" data/homework-ali.txt
```

The slash check uses Bash pattern matching:

```bash
[[ "$student_name" == */* ]]
```

## Task 8 — Submission Processor

Script:

```text
08-submission-processor.sh
```

Run:

```bash
./08-submission-processor.sh Ali data/homework-ali.txt classroom/bash-101
echo "$?"
```

Verify:

```bash
find classroom/bash-101/processed -type f
```

The processor runs the preflight script as an `if` condition. It creates and copies only after approval.

## Task 9 — Submission Controller

Script:

```text
09-submission-controller.sh
```

Successful attempt:

```bash
./09-submission-controller.sh Ali data/homework-ali.txt classroom/bash-101
echo "$?"
```

Failed attempt:

```bash
./09-submission-controller.sh Sara data/missing.txt classroom/bash-101
echo "$?"
```

Empty-file attempt:

```bash
./09-submission-controller.sh Sara data/empty-homework.txt classroom/bash-101
echo "$?"
```

Inspect the audit log:

```bash
cat classroom/bash-101/submission-audit.log
```

The log should contain separate `SUCCESS` and `FAILED` records.

---

# Complete Demonstration

Run these commands in order:

```bash
./04-workspace-setup.sh bash-101
./06-backup-with-log.sh data/homework-ali.txt backups
./09-submission-controller.sh Ali data/homework-ali.txt classroom/bash-101
./09-submission-controller.sh Sara data/missing.txt classroom/bash-101
```

Inspect all generated results:

```bash
find classroom -type f
find backups -type f
cat logs/backup.log
cat classroom/bash-101/submission-audit.log
```

# Quick Reference

## Exit statuses

| Status | Meaning |
|---:|---|
| `0` | Success |
| Non-zero | Failure or rejected condition |

## Tests

| Test | Meaning |
|---|---|
| `-z "$value"` | String is empty |
| `-f "$file"` | Regular file exists |
| `-s "$file"` | File exists and is not empty |
| `[ "$#" -ne 2 ]` | Argument count is not two |

## Operators and redirection

| Syntax | Meaning |
|---|---|
| `command1 && command2` | Run command 2 after command 1 succeeds |
| `command1 || command2` | Run command 2 after command 1 fails |
| `>` | Create or overwrite output |
| `>>` | Append output and preserve old content |
| `>&2` | Send a message to standard error |

# Final Result

The solution demonstrates a safe progression from validated arguments to connected local automation without using functions, loops, arrays, `sudo`, or remote systems.
