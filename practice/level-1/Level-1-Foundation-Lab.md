# Bash Baby-Steps Foundation Lab

## From First Script to Simple Decisions

## Lab type

Zero-level student assignment — solutions are not included.

## Objective

Practise all previously learned Bash topics through small and familiar real-life examples.

Each task adds one main idea. Students should complete the tasks in order.

## Topics covered

- Shebang line
- Comments
- `echo`
- Variables
- User input with `read -r -p`
- Command substitution with `$(command)`
- Standard output and standard error
- Script arguments
- `$0`, `$1`, `$2`, `$#`, and `"$@"`
- `if`, `elif`, `else`, and `fi`
- String comparisons
- Numeric comparisons
- File test with `-f`
- Syntax checking with `bash -n`
- Executable permissions

## Beginner rules

Use only the concepts listed above.

Do not use:

- Functions
- Loops
- Arrays
- `case`
- `getopts`
- `sudo`
- Remote machines

Use `echo` for displaying output.

---

# Lab Setup

Create the lab directory:

```bash
mkdir -p bash-baby-steps-foundation-lab
cd bash-baby-steps-foundation-lab
```

Check your current location:

```bash
pwd
```

---

# Task 1 — Welcome Script

## Topic

Shebang, comments, and `echo`.

## Create

```text
01-welcome.sh
```

## Requirements

1. Start with:

   ```bash
   #!/bin/bash
   ```

2. Add the comment:

   ```bash
   # My first Bash lab script
   ```

3. Display these three messages:

   ```text
   Hello students
   Welcome to Bash scripting
   We are learning one step at a time
   ```

## Run

```bash
bash 01-welcome.sh
```

## Learning check

- What is the purpose of `#!/bin/bash`?
- Why does Bash ignore a comment?

---

# Task 2 — Class Information

## Topic

Simple variables.

## Create

```text
02-class-info.sh
```

## Requirements

Create these variables:

```text
teacher_name
course_name
class_day
```

Store simple values in them, then display:

```text
Teacher: your value
Course: your value
Class: your value
```

## Run

```bash
bash 02-class-info.sh
```

## Practice

Change the variable values and run the script again.

## Learning check

Which one is correct?

```bash
course_name="Bash Scripting"
```

```bash
course_name = "Bash Scripting"
```

Explain why.

---

# Task 3 — Student Introduction

## Topic

User input with `read -r -p`.

## Create

```text
03-student-introduction.sh
```

## Requirements

1. Ask the student to enter a name.
2. Store the answer in `student_name`.
3. Ask the student to enter a city.
4. Store the answer in `city`.
5. Display:

   ```text
   Hello STUDENT_NAME
   You live in CITY
   ```

## Prompt examples

```text
Enter your name:
Enter your city:
```

## Run

```bash
bash 03-student-introduction.sh
```

## Learning check

Explain each part of:

```bash
read -r -p "Enter your name: " student_name
```

---

# Task 4 — Session Information

## Topic

Command substitution.

## Create

```text
04-session-info.sh
```

## Requirements

Use command substitution to store:

| Variable | Command |
|---|---|
| `current_user` | `whoami` |
| `today` | `date +%F` |
| `current_directory` | `pwd` |

Display:

```text
User:
Date:
Directory:
```

## Run

```bash
bash 04-session-info.sh
```

## Practice

Change to another directory and run the script again.

## Learning check

What is stored by this line?

```bash
today="$(date +%F)"
```

---

# Task 5 — Normal Message and Error Message

## Topic

Standard output and standard error.

## Create

```text
05-output-error.sh
```

## Requirements

1. Send this normal message to standard output:

   ```text
   Class started successfully
   ```

2. Send this practice error to standard error using `>&2`:

   ```text
   Practice error: homework file is missing
   ```

## Run normally

```bash
bash 05-output-error.sh
```

## Separate both outputs

```bash
bash 05-output-error.sh > normal.txt 2> error.txt
```

## Check the files

```bash
cat normal.txt
cat error.txt
```

## Expected result

- `normal.txt` contains the normal message.
- `error.txt` contains the practice error.

---

# Task 6 — Fruit Arguments

## Topic

Script arguments.

## Create

```text
06-fruit-arguments.sh
```

## Run

```bash
bash 06-fruit-arguments.sh apple banana cherry
```

## Requirements

Display:

1. Script name using `$0`.
2. First fruit using `$1`.
3. Second fruit using `$2`.
4. Number of fruits using `$#`.
5. All fruits using `"$@"`.

## Expected output

```text
Script name: 06-fruit-arguments.sh
First fruit: apple
Second fruit: banana
Number of fruits: 3
All fruits: apple banana cherry
```

The script name may include a path.

## Practice

```bash
bash 06-fruit-arguments.sh mango orange grapes apple
```

What is the new argument count?

---

# Task 7 — Weather Helper

## Topic

`if` and `else`.

## Create

```text
07-weather-helper.sh
```

## Requirements

1. Ask:

   ```text
   Is it raining? Enter yes or no:
   ```

2. Store the answer in `weather`.
3. If the answer is `yes`, display:

   ```text
   Take an umbrella
   ```

4. Otherwise, display:

   ```text
   You do not need an umbrella
   ```

## Run

```bash
bash 07-weather-helper.sh
```

## Required tests

- Test with `yes`.
- Test with `no`.

## Learning check

What closes an `if` block in Bash?

---

# Task 8 — Traffic-Light Helper

## Topic

`if`, `elif`, and `else`.

## Create

```text
08-traffic-light.sh
```

## Requirements

Ask the user for a traffic-light color.

| Input | Output |
|---|---|
| `red` | `Stop` |
| `yellow` | `Wait` |
| `green` | `Go` |
| Anything else | `Unknown color` |

## Run

```bash
bash 08-traffic-light.sh
```

## Required tests

Test with:

```text
red
yellow
green
blue
```

## Learning check

Why is `elif` useful here?

---

# Task 9 — Student Marks

## Topic

Numeric comparisons.

## Create

```text
09-marks-result.sh
```

## Requirements

Ask the student to enter marks as a whole number.

| Condition | Output |
|---|---|
| Marks are `80` or higher | `Result: Excellent` |
| Marks are `50` or higher | `Result: Pass` |
| Marks are below `50` | `Result: Keep practising` |

Use `-ge` for greater than or equal.

## Run

```bash
bash 09-marks-result.sh
```

## Required tests

| Test value | Expected result |
|---:|---|
| `90` | Excellent |
| `65` | Pass |
| `30` | Keep practising |

## Learning check

Why do numbers use `-ge` instead of string `=` in this task?

---

# Task 10 — Homework File Check

## Topic

File condition with `-f`.

## Create

```text
10-homework-check.sh
```

## Prepare a practice file

```bash
echo "My Bash homework" > homework.txt
```

## Requirements

1. Ask the user to enter a filename.
2. Store it in `filename`.
3. Use `-f` to check whether the file exists.
4. If it exists, display:

   ```text
   Homework file found: FILENAME
   ```

5. Otherwise, send this message to standard error:

   ```text
   Homework file not found: FILENAME
   ```

## Run

```bash
bash 10-homework-check.sh
```

## Required tests

Test with:

```text
homework.txt
missing.txt
```

---

# Task 11 — Optional Final Challenge

## Simple Class Assistant

This task gently combines earlier topics. Complete it only after Tasks 1-10.

## Create

```text
11-class-assistant.sh
```

## Arguments

```text
$1 = Student name
$2 = Homework filename
```

## Run

```bash
bash 11-class-assistant.sh Ali homework.txt
```

## Requirements

1. Store `$1` in `student_name`.
2. Store `$2` in `homework_file`.
3. Store the current date in `today` using `date +%F`.
4. Display the student name and date.
5. Ask whether the student is present: `yes` or `no`.
6. If the answer is `yes`, display `Attendance: Present`.
7. Otherwise, display `Attendance: Absent`.
8. Use `-f` to check the homework file.
9. Display a success message when it exists.
10. Send an error message to standard error when it does not exist.
11. Display the number of arguments using `$#`.

## Expected information

```text
Student: Ali
Date: current date
Attendance: Present or Absent
Homework: Found or Missing
Arguments received: 2
```

## Required tests

```bash
bash 11-class-assistant.sh Ali homework.txt
bash 11-class-assistant.sh Sara missing.txt
```

---

# Final Verification

## Check syntax

```bash
bash -n 01-welcome.sh
bash -n 02-class-info.sh
bash -n 03-student-introduction.sh
bash -n 04-session-info.sh
bash -n 05-output-error.sh
bash -n 06-fruit-arguments.sh
bash -n 07-weather-helper.sh
bash -n 08-traffic-light.sh
bash -n 09-marks-result.sh
bash -n 10-homework-check.sh
bash -n 11-class-assistant.sh
```

No output means Bash found no syntax errors.

## Add executable permission

```bash
chmod u+x *.sh
```

## List the scripts

```bash
ls -l *.sh
```

---

# Required Deliverables

```text
bash-baby-steps-foundation-lab/
├── README.md
├── 01-welcome.sh
├── 02-class-info.sh
├── 03-student-introduction.sh
├── 04-session-info.sh
├── 05-output-error.sh
├── 06-fruit-arguments.sh
├── 07-weather-helper.sh
├── 08-traffic-light.sh
├── 09-marks-result.sh
├── 10-homework-check.sh
├── 11-class-assistant.sh
└── homework.txt
```

Task 11 is optional for students who finish early.

# Student README Requirements

The student `README.md` should briefly explain:

- What a shebang does
- What a variable is
- What `read -r -p` does
- What command substitution does
- Difference between standard output and standard error
- Meaning of `$0`, `$1`, `$2`, `$#`, and `"$@"`
- Meaning of `if`, `elif`, `else`, and `fi`
- Meaning of `-ge`
- Meaning of `-f`
- One thing the student found easy
- One thing the student wants to practise again

# Evaluation Checklist

| Requirement | Marks |
|---|---:|
| Tasks 1-2: Script basics and variables | 15 |
| Tasks 3-4: User input and command substitution | 15 |
| Task 5: Output and error | 10 |
| Task 6: Arguments | 15 |
| Tasks 7-8: String conditionals | 20 |
| Task 9: Numeric conditional | 10 |
| Task 10: File conditional | 10 |
| Syntax, comments, quoting, and README | 5 |
| **Total** | **100** |

Task 11 can be used for bonus marks.

---

# Recommended Next-Lab Roadmap

After this foundation lab, move toward advanced Bash in three controlled steps.

## Step 1 — Combine Two Concepts

Students will combine:

- Arguments with conditions
- User input with file tests
- Command substitution with output redirection
- Exit status with success and failure messages

The scripts will still remain short.

## Step 2 — Small Automation Flow

Students will create connected scripts for:

- Argument-count validation
- File and directory checks
- Exit statuses
- `&&` and `||`
- Simple logs
- Safe local copy operations

No remote server will be used.

## Step 3 — Advanced Beginner Project

Students will build one local automation project containing:

- Input validation
- Multiple conditional gates
- Arguments
- File checks
- Exit statuses
- Standard output and error
- Timestamped logging
- A final report

Functions and loops can be introduced only after students are comfortable with these three steps.

# Teaching Recommendation

Do not complete the whole lab in one class.

Suggested pace:

| Lesson | Tasks |
|---|---|
| Lesson 1 | Tasks 1-3 |
| Lesson 2 | Tasks 4-6 |
| Lesson 3 | Tasks 7-8 |
| Lesson 4 | Tasks 9-10 |
| Extra practice | Task 11 |

For every task:

1. Explain the idea.
2. Type the script together.
3. Run the first test.
4. Change one value.
5. Run it again.
6. Ask students to explain the output.

# Safety

This lab uses local learning files only. It does not require `sudo`, user creation, file deletion, remote access, cloud resources, or production systems.
