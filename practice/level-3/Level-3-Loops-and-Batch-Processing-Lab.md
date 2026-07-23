# Bash Scripting Level 3 — Loops and Batch Processing Lab

## Three Controlled Steps from Repetition to Batch Automation

## Lab type

Intermediate-beginner student assignment — solutions are not included.

## Objective

Learn how Bash repeats work safely with `for` and `while` loops, counters, `break`, and `continue`, then combine those skills into a connected local batch-processing project.

## Three-step structure

| Step | Focus | Tasks |
|---|---|---:|
| 1 | Loop foundations and counters | 1-3 |
| 2 | Control loop behavior and inspect multiple files | 4-6 |
| 3 | Build a connected batch-processing flow | 7-9 |

## Skills practised

- `for` loops
- `while` loops
- Looping over `"$@"`
- Numeric counters
- Arithmetic expansion with `$(( ))`
- Reading files with `while IFS= read -r`
- Skipping work with `continue`
- Stopping a search with `break`
- Boolean-style status variables
- File globs such as `*.txt`
- Handling a glob with no matches
- Counting valid and empty files
- Batch preflight checks
- Batch file processing
- Calling loop-based scripts from other scripts
- Timestamped audit logging
- Success and failure exit statuses

## Level 3 boundaries

Use:

- All Level 1 and Level 2 concepts
- `for`, `while`, `do`, and `done`
- `break` and `continue`
- Arithmetic expansion
- Local file and directory operations

Do not use yet:

- Functions
- Arrays
- `case`
- `getopts`
- `sudo`
- Remote systems

Functions will be introduced in Level 4 after students understand repeated work.

---

# Lab Setup

Create the workspace:

```bash
mkdir -p bash-level-3-lab/data/valid
mkdir -p bash-level-3-lab/data/mixed
cd bash-level-3-lab
```

Create a student list:

```bash
echo "Ali" > data/students.txt
echo "Sara" >> data/students.txt
echo "Omar" >> data/students.txt
```

Create valid homework files:

```bash
echo "Ali: Loops practice" > data/valid/homework-ali.txt
echo "Sara: While-loop practice" > data/valid/homework-sara.txt
echo "Omar: Counters practice" > data/valid/homework-omar.txt
```

Create mixed test data:

```bash
echo "Ali: Loops practice" > data/mixed/homework-ali.txt
touch data/mixed/homework-empty.txt
```

Create a list containing blank lines:

```bash
echo "Ali" > data/students-with-blanks.txt
echo "" >> data/students-with-blanks.txt
echo "Sara" >> data/students-with-blanks.txt
echo "" >> data/students-with-blanks.txt
echo "Omar" >> data/students-with-blanks.txt
```

Verify the starter data:

```bash
find data -type f -maxdepth 3
```

---

# Step 1 — Loop Foundations

# Task 1 — Display Fruits with a `for` Loop

## Create

```text
01-for-fruits.sh
```

## Run

```bash
bash 01-for-fruits.sh apple banana cherry
```

## Requirements

1. Require at least one argument.
2. Display a usage error and return `1` when no fruit is supplied.
3. Use a `for` loop with `"$@"`.
4. Display each fruit on a separate line.
5. Display `Fruit: VALUE` for every argument.
6. Return `0` after the loop completes.

## Expected output

```text
Fruit: apple
Fruit: banana
Fruit: cherry
```

## Failure test

```bash
bash 01-for-fruits.sh
echo "$?"
```

---

# Task 2 — Count with a `while` Loop

## Create

```text
02-while-counter.sh
```

## Argument

```text
$1 = Final positive whole number
```

## Requirements

1. Require exactly one argument.
2. Store it in `limit`.
3. Start a variable named `count` at `1`.
4. Use `while` to continue while `count` is less than or equal to `limit`.
5. Display `Count: NUMBER` during each iteration.
6. Increase the counter with arithmetic expansion.
7. Display `Counting completed` after the loop.

For this beginner task, supply a positive whole number.

## Test

```bash
bash 02-while-counter.sh 5
```

## Expected output

```text
Count: 1
Count: 2
Count: 3
Count: 4
Count: 5
Counting completed
```

---

# Task 3 — Read Students from a File

## Create

```text
03-read-students.sh
```

## Argument

```text
$1 = Student-list file
```

## Requirements

1. Require exactly one argument.
2. Confirm it is a regular file.
3. Start `student_count` at `0`.
4. Read the file with:

   ```bash
   while IFS= read -r student
   ```

5. Display each student.
6. Increase `student_count` for each line.
7. Display the final total after the loop.

## Test

```bash
bash 03-read-students.sh data/students.txt
```

## Expected total

```text
Total students: 3
```

---

# Step 2 — Control Loop Behavior

# Task 4 — Skip Empty Lines with `continue`

## Create

```text
04-skip-empty-lines.sh
```

## Argument

```text
$1 = Student-list file
```

## Requirements

1. Validate the argument count and file.
2. Start `student_count` at `0`.
3. Read every line with `while IFS= read -r`.
4. Use `-z` to detect an empty line.
5. Use `continue` to skip the empty line.
6. Display only non-empty student names.
7. Count only non-empty lines.
8. Display the final count.

## Test

```bash
bash 04-skip-empty-lines.sh data/students-with-blanks.txt
```

## Expected total

```text
Non-empty students: 3
```

---

# Task 5 — Find a Student with `break`

## Create

```text
05-find-student.sh
```

## Arguments

```text
$1 = Student name to find
$2 = Student-list file
```

## Requirements

1. Require exactly two arguments.
2. Validate the list file.
3. Store the target name and file.
4. Set `found="no"` before the loop.
5. Read the list one line at a time.
6. Display each checked name.
7. If the line matches the target:
   - Set `found="yes"`.
   - Display `Student found`.
   - Use `break` to stop reading.
8. After the loop, return `0` when found.
9. Display an error and return `1` when not found.

## Success test

```bash
bash 05-find-student.sh Sara data/students.txt
echo "$?"
```

## Failure test

```bash
bash 05-find-student.sh Ahmed data/students.txt
echo "$?"
```

---

# Task 6 — Create a Homework Directory Report

## Create

```text
06-homework-report.sh
```

## Argument

```text
$1 = Directory containing homework .txt files
```

## Requirements

1. Require exactly one argument.
2. Confirm the path is a directory with `-d`.
3. Start these counters at `0`:
   - `total_files`
   - `valid_files`
   - `empty_files`
4. Loop over `"$input_directory"/*.txt`.
5. Use `[ -e "$homework_file" ] || continue` to handle no matches.
6. Increase the total for every matching file.
7. Use `-s` to classify each file as valid or empty.
8. Display every filename and classification.
9. Display all three totals after the loop.

## Valid-directory test

```bash
bash 06-homework-report.sh data/valid
```

Expected:

```text
Total files: 3
Valid files: 3
Empty files: 0
```

## Mixed-directory test

```bash
bash 06-homework-report.sh data/mixed
```

Expected:

```text
Total files: 2
Valid files: 1
Empty files: 1
```

---

# Step 3 — Connected Batch Project

```text
Batch preflight -> Batch processor -> Batch controller and audit log
```

# Task 7 — Batch Preflight

## Create

```text
07-batch-preflight.sh
```

## Argument

```text
$1 = Input directory
```

## Requirements

1. Require exactly one argument.
2. Confirm the input is a directory.
3. Loop over all `.txt` files.
4. Count total and empty files.
5. Handle a directory with no matching files.
6. Display a preflight summary.
7. Fail when no `.txt` files exist.
8. Fail when any matching file is empty.
9. Display `Batch preflight passed` only when every file is non-empty.
10. Return `0` only for a fully valid batch.

## Success test

```bash
bash 07-batch-preflight.sh data/valid
echo "$?"
```

## Failure test

```bash
bash 07-batch-preflight.sh data/mixed
echo "$?"
```

---

# Task 8 — Batch Processor

## Create

```text
08-batch-processor.sh
```

## Arguments

```text
$1 = Input directory
$2 = Output directory
```

## Requirements

1. Require exactly two arguments.
2. Run `07-batch-preflight.sh` with the input directory.
3. Stop when preflight fails.
4. Create the output directory only after approval.
5. Loop over all `.txt` files in the input directory.
6. Copy every file into the output directory.
7. Count successful copies.
8. Stop and return non-zero if a copy fails.
9. Display the final processed count.
10. Return `0` only when the batch completes.

## Success test

```bash
bash 08-batch-processor.sh data/valid processed-homework
echo "$?"
find processed-homework -type f
```

## Failure test

```bash
bash 08-batch-processor.sh data/mixed rejected-output
echo "$?"
```

The failed batch must not copy the empty batch into `rejected-output`.

---

# Task 9 — Batch Controller and Audit Log

## Create

```text
09-batch-controller.sh
```

## Arguments

```text
$1 = Input directory
$2 = Output directory
```

## Requirements

1. Require exactly two arguments.
2. Store the current date/time and current user.
3. Run `08-batch-processor.sh`.
4. Record `SUCCESS` when the processor succeeds.
5. Record `FAILED` when the processor fails.
6. Create the `logs/` directory.
7. Append every attempt to:

   ```text
   logs/batch-audit.log
   ```

8. Include:
   - Date and time
   - Current user
   - Input directory
   - Output directory
   - Final status
9. Use `>>` to preserve old entries.
10. Return `0` only for a successful batch.

## Success test

```bash
bash 09-batch-controller.sh data/valid final-homework
echo "$?"
```

## Failure test

```bash
bash 09-batch-controller.sh data/mixed failed-homework
echo "$?"
```

## Verify

```bash
find final-homework -type f
cat logs/batch-audit.log
```

---

# Final Verification

## Check all scripts

```bash
bash -n 01-for-fruits.sh
bash -n 02-while-counter.sh
bash -n 03-read-students.sh
bash -n 04-skip-empty-lines.sh
bash -n 05-find-student.sh
bash -n 06-homework-report.sh
bash -n 07-batch-preflight.sh
bash -n 08-batch-processor.sh
bash -n 09-batch-controller.sh
```

## Add executable permission

```bash
chmod u+x *.sh
```

## Demonstrate loop control

Show:

- A `for` loop processing three arguments
- A `while` loop counting to five
- `continue` skipping blank lines
- `break` stopping after a match

## Demonstrate batch control

Show:

- A valid batch returning `0`
- A mixed batch returning non-zero
- A successful output directory containing copied files
- An audit log containing both `SUCCESS` and `FAILED`

# Required Deliverables

```text
bash-level-3-lab/
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
├── data/
├── final-homework/
└── logs/
    └── batch-audit.log
```

# Student README Requirements

Explain:

- Difference between `for` and `while`
- Purpose of `do` and `done`
- Meaning of arithmetic expansion
- Why `IFS= read -r` is used
- Difference between `break` and `continue`
- How counters are increased
- How a no-match glob is handled
- How Tasks 7, 8, and 9 connect
- One successful batch and one failed batch

# Evaluation

| Requirement | Marks |
|---|---:|
| Tasks 1-3: Loop foundations | 25 |
| Tasks 4-6: Loop control and reporting | 30 |
| Task 7: Batch preflight | 15 |
| Task 8: Batch processor | 15 |
| Task 9: Controller and audit log | 10 |
| Syntax, quoting, counters, exit statuses, and README | 5 |
| **Total** | **100** |

# Recommended Pace

| Lesson | Work |
|---|---|
| Lesson 1 | Tasks 1-2 |
| Lesson 2 | Tasks 3-4 |
| Lesson 3 | Tasks 5-6 |
| Lesson 4 | Task 7 |
| Lesson 5 | Tasks 8-9 |
| Assessment | Project demonstration and MCQ quiz |

# Safety

All students, homework files, input batches, outputs, and logs are fictional local practice data. Do not add `sudo`, real student records, remote systems, cloud resources, or production paths.
