# Bash Scripting Level 2 — Guided Automation Lab

## Three Controlled Steps from Foundation to Automation

## Lab type

Beginner-plus student assignment — solutions are not included.

## Objective

Move beyond one-concept scripts by combining familiar Bash topics into safe local automation.

Level 2 is divided into three steps:

| Step | Focus | Tasks |
|---|---|---:|
| 1 | Combine arguments, conditions, and validation | 1-3 |
| 2 | Add exit statuses, command chaining, copying, and logging | 4-6 |
| 3 | Build a connected student-submission processor | 7-9 |

All work remains local. No `sudo`, remote server, or production resource is required.

## Skills practised

- Positional arguments and descriptive variables
- Argument-count validation with `$#`
- Usage messages
- String and numeric conditions
- File tests with `-f` and `-s`
- Empty-string tests with `-z`
- Success and failure exit statuses
- Checking `$?`
- Command chaining with `&&` and `||`
- Safe directory creation with `mkdir -p`
- Local file copying with `cp`
- Command substitution with `date`, `whoami`, and `basename`
- Standard output and standard error
- Append redirection with `>>`
- Timestamped log records
- Running one Bash script from another
- A connected preflight, processor, and controller flow

## Level 2 boundaries

Use:

- Shebang and comments
- `echo`
- Variables and arguments
- `if`, `elif`, `else`, and `fi`
- `[ ]` and `[[ ]]`
- `&&` and `||`
- `exit`
- Basic local Linux commands
- Output redirection

Do not use yet:

- Functions
- Loops
- Arrays
- `case`
- `getopts`
- `sudo`
- Remote systems

---

# Lab Setup

Create the workspace:

```bash
mkdir -p bash-level-2-lab/data
mkdir -p bash-level-2-lab/logs
cd bash-level-2-lab
```

Create two sample homework files:

```bash
echo "Ali: Bash arguments practice" > data/homework-ali.txt
echo "Sara: Bash conditionals practice" > data/homework-sara.txt
```

Create an empty homework file for a failure test:

```bash
touch data/empty-homework.txt
```

Check the files:

```bash
ls -lh data/
```

---

# Step 1 — Combine Two Concepts

# Task 1 — User Role Message

## Create

```text
01-user-role.sh
```

## Arguments

```text
$1 = Name
$2 = Role
```

## Requirements

1. Store `$1` in `name`.
2. Store `$2` in `role`.
3. Display the name.
4. If the role is `student`, display `Access: Learning area`.
5. Else if the role is `teacher`, display `Access: Teaching area`.
6. Otherwise, display `Access: Guest area`.

## Tests

```bash
bash 01-user-role.sh Ali student
bash 01-user-role.sh Khalid teacher
bash 01-user-role.sh Sara visitor
```

## Learning goal

Combine positional arguments with string conditions.

---

# Task 2 — Validate Argument Count

## Create

```text
02-argument-check.sh
```

## Expected arguments

```text
$1 = Application name
$2 = Environment
```

## Requirements

1. Check whether exactly two arguments were supplied.
2. If the count is incorrect, send this usage message to standard error:

   ```text
   Usage: 02-argument-check.sh APPLICATION ENVIRONMENT
   ```

3. Return exit status `1` for an incorrect count.
4. Store the two arguments in descriptive variables.
5. Display the application and environment.
6. Return exit status `0` for success.

## Tests

```bash
bash 02-argument-check.sh inventory-api dev
echo "$?"

bash 02-argument-check.sh inventory-api
echo "$?"
```

## Expected exit statuses

| Test | Status |
|---|---:|
| Two arguments | `0` |
| One argument | `1` |

---

# Task 3 — Validate a Homework File

## Create

```text
03-homework-validator.sh
```

## Argument

```text
$1 = Homework file
```

## Requirements

1. Require exactly one argument.
2. Display a usage error and exit `1` when the count is incorrect.
3. Store `$1` in `homework_file`.
4. Use `-f` to confirm it is a regular file.
5. Use `-s` to confirm it is not empty.
6. Display a specific error for a missing file.
7. Display a specific error for an empty file.
8. Display `Homework validation passed` when both checks pass.
9. Return `0` only for a valid, non-empty file.

## Tests

```bash
bash 03-homework-validator.sh data/homework-ali.txt
echo "$?"

bash 03-homework-validator.sh data/missing.txt
echo "$?"

bash 03-homework-validator.sh data/empty-homework.txt
echo "$?"
```

---

# Step 2 — Small Local Automation

# Task 4 — Create a Class Workspace

## Create

```text
04-workspace-setup.sh
```

## Argument

```text
$1 = Class name
```

## Required structure

For a class named `bash-101`, create:

```text
classroom/bash-101/
├── incoming/
├── processed/
└── reports/
```

## Requirements

1. Require exactly one argument.
2. Store it in `class_name`.
3. Reject an empty class name.
4. Build the base path `classroom/CLASS_NAME`.
5. Use `mkdir -p` to create all three subdirectories.
6. Use `&&` so the success message appears only after all directories are created.
7. Send a failure message to standard error.
8. Return `0` for success and `1` for failure.

## Test

```bash
bash 04-workspace-setup.sh bash-101
echo "$?"
find classroom/bash-101 -maxdepth 1 -type d
```

---

# Task 5 — Copy a Homework File

## Create

```text
05-homework-copy.sh
```

## Arguments

```text
$1 = Source homework file
$2 = Destination directory
```

## Requirements

1. Require exactly two arguments.
2. Confirm the source is a regular file.
3. Create the destination with `mkdir -p`.
4. Use `||` to stop with an error if directory creation fails.
5. Copy the file with `cp`.
6. Use `||` to stop with an error if copying fails.
7. Display the destination path after success.
8. Return `0` only after a successful copy.

## Test

```bash
bash 05-homework-copy.sh data/homework-ali.txt classroom/bash-101/incoming
echo "$?"
ls -lh classroom/bash-101/incoming/
```

## Failure test

```bash
bash 05-homework-copy.sh data/missing.txt classroom/bash-101/incoming
echo "$?"
```

---

# Task 6 — Create a Timestamped Backup and Log

## Create

```text
06-backup-with-log.sh
```

## Arguments

```text
$1 = Source file
$2 = Backup directory
```

## Requirements

1. Require exactly two arguments.
2. Validate the source with `-f`.
3. Create the backup directory.
4. Store a timestamp using:

   ```bash
   date +%Y%m%d-%H%M%S
   ```

5. Store the source filename using `basename`.
6. Build a backup filename containing the timestamp.
7. Copy the source into the backup directory.
8. Create the `logs/` directory if needed.
9. Append one successful record to:

   ```text
   logs/backup.log
   ```

10. Include the date, current user, source, backup path, and `SUCCESS`.
11. Use `>>` so earlier records remain.
12. Return a non-zero status if any required action fails.

## Test

```bash
bash 06-backup-with-log.sh data/homework-ali.txt backups
echo "$?"
find backups -type f
cat logs/backup.log
```

---

# Step 3 — Connected Student-Submission Project

The final three scripts form one connected flow:

```text
Preflight check -> Process submission -> Controller and audit log
```

# Task 7 — Submission Preflight

## Create

```text
07-submission-preflight.sh
```

## Arguments

```text
$1 = Student name
$2 = Homework file
```

## Requirements

1. Require exactly two arguments.
2. Store both arguments in descriptive variables.
3. Reject an empty student name with `-z`.
4. Reject a student name containing `/` using `[[ ]]` pattern matching.
5. Confirm the homework path is a regular file with `-f`.
6. Confirm the homework file is not empty with `-s`.
7. Display a specific error for each failed check.
8. Display `Submission preflight passed` after success.
9. Return `0` only when every check passes.

## Tests

```bash
bash 07-submission-preflight.sh Ali data/homework-ali.txt
echo "$?"

bash 07-submission-preflight.sh Ali data/missing.txt
echo "$?"

bash 07-submission-preflight.sh Ali data/empty-homework.txt
echo "$?"

bash 07-submission-preflight.sh "Ali/Khan" data/homework-ali.txt
echo "$?"
```

---

# Task 8 — Submission Processor

## Create

```text
08-submission-processor.sh
```

## Arguments

```text
$1 = Student name
$2 = Homework file
$3 = Class workspace
```

Example:

```bash
bash 08-submission-processor.sh Ali data/homework-ali.txt classroom/bash-101
```

## Requirements

1. Require exactly three arguments.
2. Store all arguments in descriptive variables.
3. Run `07-submission-preflight.sh` with the student and file.
4. Use its exit status as an `if` condition.
5. Stop if preflight fails.
6. Create this destination only after approval:

   ```text
   CLASS_WORKSPACE/processed/STUDENT_NAME
   ```

7. Copy the homework file into the destination.
8. Display the final copied path.
9. Return `0` only after successful processing.

## Success test

```bash
bash 08-submission-processor.sh Ali data/homework-ali.txt classroom/bash-101
echo "$?"
find classroom/bash-101/processed -type f
```

## Failure test

```bash
bash 08-submission-processor.sh Ali data/missing.txt classroom/bash-101
echo "$?"
```

---

# Task 9 — Submission Controller and Audit Log

## Create

```text
09-submission-controller.sh
```

## Arguments

```text
$1 = Student name
$2 = Homework file
$3 = Class workspace
```

## Requirements

1. Require exactly three arguments.
2. Store all arguments in descriptive variables.
3. Store the current date and time.
4. Store the current user.
5. Run `08-submission-processor.sh` with the correct arguments.
6. Record `SUCCESS` when processing succeeds.
7. Record `FAILED` when processing fails.
8. Append every attempt to:

   ```text
   CLASS_WORKSPACE/submission-audit.log
   ```

9. Each record must include:
   - Date and time
   - Current user
   - Student name
   - Homework path
   - Final status
10. Preserve old records with `>>`.
11. Display a clear final message.
12. Return `0` only for a successful submission.

## Success test

```bash
bash 09-submission-controller.sh Ali data/homework-ali.txt classroom/bash-101
echo "$?"
```

## Failure test

```bash
bash 09-submission-controller.sh Sara data/missing.txt classroom/bash-101
echo "$?"
```

## Empty-file test

```bash
bash 09-submission-controller.sh Sara data/empty-homework.txt classroom/bash-101
echo "$?"
```

## Verify results

```bash
find classroom/bash-101 -type f
cat classroom/bash-101/submission-audit.log
```

---

# Final Verification

## Check every script

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

## Add executable permission

```bash
chmod u+x *.sh
```

## Run the connected success flow

```bash
bash 04-workspace-setup.sh bash-101
bash 09-submission-controller.sh Ali data/homework-ali.txt classroom/bash-101
echo "$?"
```

## Run at least three failure tests

- Incorrect argument count
- Missing homework file
- Empty homework file
- Invalid student name

Every failure should display a clear error and return a non-zero exit status.

# Required Deliverables

```text
bash-level-2-lab/
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
├── data/
│   ├── homework-ali.txt
│   ├── homework-sara.txt
│   └── empty-homework.txt
├── backups/
├── logs/
│   └── backup.log
└── classroom/
    └── bash-101/
        ├── incoming/
        ├── processed/
        ├── reports/
        └── submission-audit.log
```

# Student README Requirements

Explain:

- Why argument-count validation matters
- Meaning of exit status `0` and non-zero
- Difference between `-f`, `-s`, and `-z`
- How `&&` and `||` work
- Why variables and arguments should be quoted
- Difference between `>` and `>>`
- Purpose of a timestamped log
- How Tasks 7, 8, and 9 connect
- One success test and three failure tests

# Evaluation

| Requirement | Marks |
|---|---:|
| Tasks 1-3: Combined input and validation | 25 |
| Tasks 4-6: Local automation and logging | 30 |
| Task 7: Submission preflight | 15 |
| Task 8: Submission processing | 15 |
| Task 9: Controller and audit log | 10 |
| Syntax, comments, quoting, exit statuses, and README | 5 |
| **Total** | **100** |

# Recommended Pace

| Lesson | Work |
|---|---|
| Lesson 1 | Tasks 1-3 |
| Lesson 2 | Tasks 4-5 |
| Lesson 3 | Task 6 and logging review |
| Lesson 4 | Task 7 |
| Lesson 5 | Tasks 8-9 |
| Assessment | MCQ quiz and project demonstration |

# Safety

All names, homework files, logs, backups, and class workspaces are fictional local practice data. Do not add `sudo`, real student data, remote hosts, or production paths.
