# Bash Scripting Level 3 — Solution Guide

This folder contains the tested solution for the Loops and Batch Processing Lab.

## Three-stage solution

| Stage | Tasks | Main result |
|---|---:|---|
| 1. Loop foundations | 1-3 | `for`, `while`, counters, and file reading |
| 2. Loop control | 4-6 | `continue`, `break`, globs, and file counters |
| 3. Batch project | 7-9 | Preflight, processor, controller, and audit log |

## Files

```text
Bash-Level-3-Solution/
├── README.md
├── 01-for-fruits.sh
├── 02-while-counter.sh
├── 03-read-students.sh
├── 04-skip-empty-lines.sh
├── 05-find-student.sh
├── 06-homework-report.sh
├── 07-batch-preflight.sh
├── 08-batch-processor.sh
├── 09-batch-controller.sh
└── data/
    ├── students.txt
    ├── students-with-blanks.txt
    ├── valid/
    │   ├── homework-ali.txt
    │   ├── homework-sara.txt
    │   └── homework-omar.txt
    └── mixed/
        ├── homework-ali.txt
        └── homework-empty.txt
```

## Prepare the solution

```bash
cd Bash-Level-3-Solution
chmod u+x *.sh
bash -n *.sh
```

No output from `bash -n` means no syntax errors were found.

---

# Stage 1 — Loop Foundations

## Task 1 — `for` Loop over Arguments

```bash
./01-for-fruits.sh apple banana cherry
```

Expected:

```text
Fruit: apple
Fruit: banana
Fruit: cherry
```

Failure test:

```bash
./01-for-fruits.sh
echo "$?"
```

The loop uses quoted `"$@"`, so each argument remains a separate item.

## Task 2 — `while` Counter

```bash
./02-while-counter.sh 5
```

The script starts with `count=1`, repeats while the count is less than or equal to the limit, and increases it with:

```bash
count=$((count + 1))
```

## Task 3 — Read Students

```bash
./03-read-students.sh data/students.txt
```

Expected total:

```text
Total students: 3
```

The input redirection is placed after `done`:

```bash
done < "$student_file"
```

This keeps the counter available after the loop.

---

# Stage 2 — Loop Control

## Task 4 — Skip Empty Lines

```bash
./04-skip-empty-lines.sh data/students-with-blanks.txt
```

Expected total:

```text
Non-empty students: 3
```

`continue` skips the rest of the current iteration and begins the next one.

## Task 5 — Find and Stop

Success:

```bash
./05-find-student.sh Sara data/students.txt
echo "$?"
```

Failure:

```bash
./05-find-student.sh Ahmed data/students.txt
echo "$?"
```

`break` stops the loop as soon as the requested student is found.

## Task 6 — Homework Report

Valid batch:

```bash
./06-homework-report.sh data/valid
```

Mixed batch:

```bash
./06-homework-report.sh data/mixed
```

Expected summaries:

| Directory | Total | Valid | Empty |
|---|---:|---:|---:|
| `data/valid` | 3 | 3 | 0 |
| `data/mixed` | 2 | 1 | 1 |

This line safely skips a glob that did not match a real file:

```bash
[ -e "$homework_file" ] || continue
```

---

# Stage 3 — Connected Batch Project

## Flow

```text
07-batch-preflight.sh
          |
          v
08-batch-processor.sh
          |
          v
09-batch-controller.sh
```

## Task 7 — Batch Preflight

Success:

```bash
./07-batch-preflight.sh data/valid
echo "$?"
```

Failure:

```bash
./07-batch-preflight.sh data/mixed
echo "$?"
```

The preflight fails if:

- The input path is not a directory
- No `.txt` files are present
- Any matching file is empty

## Task 8 — Batch Processor

Success:

```bash
./08-batch-processor.sh data/valid processed-homework
echo "$?"
```

Verify:

```bash
find processed-homework -type f
```

Failure:

```bash
./08-batch-processor.sh data/mixed rejected-output
echo "$?"
```

The processor creates the output directory only after preflight approval.

## Task 9 — Batch Controller

Successful batch:

```bash
./09-batch-controller.sh data/valid final-homework
echo "$?"
```

Failed batch:

```bash
./09-batch-controller.sh data/mixed failed-homework
echo "$?"
```

Inspect the result:

```bash
find final-homework -type f
cat logs/batch-audit.log
```

The audit log should contain both `SUCCESS` and `FAILED` records.

---

# Quick Reference

## Loop structure

```bash
for item in values
do
    echo "$item"
done
```

```bash
while [ condition ]
do
    echo "Repeat work"
done
```

## Loop control

| Keyword | Meaning |
|---|---|
| `continue` | Skip the rest of the current iteration |
| `break` | Stop the loop completely |
| `do` | Begin the repeated commands |
| `done` | End the loop block |

## Counters

```bash
count=0
count=$((count + 1))
```

## Safe line reading

```bash
while IFS= read -r line
do
    echo "$line"
done < "$file"
```

# Complete Demonstration

```bash
./01-for-fruits.sh apple banana cherry
./02-while-counter.sh 5
./03-read-students.sh data/students.txt
./04-skip-empty-lines.sh data/students-with-blanks.txt
./05-find-student.sh Sara data/students.txt
./06-homework-report.sh data/mixed
./09-batch-controller.sh data/valid final-homework
./09-batch-controller.sh data/mixed failed-homework
```

# Final Result

The Level 3 solution demonstrates repeated work, loop control, batch validation, safe copying, counters, exit statuses, and audit logging without functions or arrays.
