# Bash Baby-Steps Foundation Lab — Solution

This solution matches all ten required tasks and the optional final challenge.

## Important beginner rules

- Start every script with `#!/bin/bash`.
- Do not put spaces around `=` in variable assignments.
- Put variable expansions inside double quotes.
- Put spaces inside `[ condition ]`.
- Close every conditional with `fi`.
- Use whole numbers for numeric practice.

---

# Task 1 — Welcome Script

```bash
#!/bin/bash

# My first Bash lab script

echo "Hello students"
echo "Welcome to Bash scripting"
echo "We are learning one step at a time"
```

Run:

```bash
bash 01-welcome.sh
```

---

# Task 2 — Class Information

```bash
#!/bin/bash

# Display class information using variables

teacher_name="Khalid Khan"
course_name="Bash Scripting"
class_day="Day 1"

echo "Teacher: $teacher_name"
echo "Course: $course_name"
echo "Class: $class_day"
```

Run:

```bash
bash 02-class-info.sh
```

Variable assignments do not have spaces around `=`.

---

# Task 3 — Student Introduction

```bash
#!/bin/bash

# Read and display student information

read -r -p "Enter your name: " student_name
read -r -p "Enter your city: " city

echo "Hello $student_name"
echo "You live in $city"
```

Run:

```bash
bash 03-student-introduction.sh
```

`read` accepts input, `-r` keeps backslashes unchanged, and `-p` displays a prompt.

---

# Task 4 — Session Information

```bash
#!/bin/bash

# Save command output in variables

current_user="$(whoami)"
today="$(date +%F)"
current_directory="$(pwd)"

echo "User: $current_user"
echo "Date: $today"
echo "Directory: $current_directory"
```

Run:

```bash
bash 04-session-info.sh
```

`$(command)` runs a command and returns its output.

---

# Task 5 — Normal Message and Error Message

```bash
#!/bin/bash

# Display a normal message and an error message

echo "Class started successfully"
echo "Practice error: homework file is missing" >&2
```

Separate the outputs:

```bash
bash 05-output-error.sh > normal.txt 2> error.txt
```

Check them:

```bash
cat normal.txt
cat error.txt
```

- `>` redirects standard output.
- `2>` redirects standard error.
- `>&2` sends a message to standard error.

---

# Task 6 — Fruit Arguments

```bash
#!/bin/bash

# Display script arguments

echo "Script name: $0"
echo "First fruit: $1"
echo "Second fruit: $2"
echo "Number of fruits: $#"
echo "All fruits:" "$@"
```

Run:

```bash
bash 06-fruit-arguments.sh apple banana cherry
```

Quick meaning:

| Symbol | Meaning |
|---|---|
| `$0` | Script name |
| `$1` | First argument |
| `$2` | Second argument |
| `$#` | Number of arguments |
| `"$@"` | All arguments |

---

# Task 7 — Weather Helper

```bash
#!/bin/bash

# Decide whether an umbrella is needed

read -r -p "Is it raining? Enter yes or no: " weather

if [ "$weather" = "yes" ]
then
    echo "Take an umbrella"
else
    echo "You do not need an umbrella"
fi
```

Run and test both answers:

```bash
bash 07-weather-helper.sh
```

- Enter `yes` to get `Take an umbrella`.
- Enter `no` to get `You do not need an umbrella`.

---

# Task 8 — Traffic-Light Helper

```bash
#!/bin/bash

# Display an action for a traffic-light color

read -r -p "Enter traffic-light color (red/yellow/green): " light

if [ "$light" = "red" ]
then
    echo "Stop"
elif [ "$light" = "yellow" ]
then
    echo "Wait"
elif [ "$light" = "green" ]
then
    echo "Go"
else
    echo "Unknown color"
fi
```

Run:

```bash
bash 08-traffic-light.sh
```

Test `red`, `yellow`, `green`, and `blue`.

---

# Task 9 — Student Marks

```bash
#!/bin/bash

# Classify student marks
# Enter marks as a whole number.

read -r -p "Enter your marks: " marks

if [ "$marks" -ge 80 ]
then
    echo "Result: Excellent"
elif [ "$marks" -ge 50 ]
then
    echo "Result: Pass"
else
    echo "Result: Keep practising"
fi
```

Run:

```bash
bash 09-marks-result.sh
```

Tests:

| Marks | Result |
|---:|---|
| `90` | Excellent |
| `65` | Pass |
| `30` | Keep practising |

`-ge` means greater than or equal.

---

# Task 10 — Homework File Check

```bash
#!/bin/bash

# Check whether a homework file exists

read -r -p "Enter a filename: " filename

if [ -f "$filename" ]
then
    echo "Homework file found: $filename"
else
    echo "Homework file not found: $filename" >&2
fi
```

Run:

```bash
bash 10-homework-check.sh
```

Test `homework.txt` and `missing.txt`.

`-f` is true when the path is an existing regular file.

---

# Task 11 — Simple Class Assistant

```bash
#!/bin/bash

# Combine arguments, input, command substitution, and conditions

student_name="$1"
homework_file="$2"
today="$(date +%F)"

echo "Student: $student_name"
echo "Date: $today"

read -r -p "Is the student present? Enter yes or no: " attendance

if [ "$attendance" = "yes" ]
then
    echo "Attendance: Present"
else
    echo "Attendance: Absent"
fi

if [ -f "$homework_file" ]
then
    echo "Homework: Found"
else
    echo "Homework: Missing" >&2
fi

echo "Arguments received: $#"
```

Success test:

```bash
bash 11-class-assistant.sh Ali homework.txt
```

Enter `yes` when asked about attendance.

Missing-homework test:

```bash
bash 11-class-assistant.sh Sara missing.txt
```

Enter `no` when asked about attendance.

---

# Check Every Script

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

# Add Executable Permission

```bash
chmod u+x *.sh
```

# Final Learning Summary

Students have now practised:

- Script structure
- Variables
- User input
- Command substitution
- Standard output and error
- Positional arguments
- String decisions
- Numeric decisions
- File conditions
- Combining basic topics in one script
