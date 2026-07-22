# Bash Conditionals — `if`, `elif`, and `else`

## Beginner Study Notes

## Learning objectives

After completing this lesson, you should be able to:

- Explain why conditionals are used.
- Write `if`, `if...else`, and `if...elif...else` statements.
- Compare numbers and strings.
- Check files and directories.
- Use command exit statuses as conditions.
- Combine arguments with conditions.
- Recognize common conditional syntax mistakes.

---

## 1. What are conditionals?

Conditionals allow a shell script to make decisions.

Examples:

- If a user exists, display the user's information.
- Else, display `User not found`.
- If marks are 80 or higher, assign Grade A.
- Else if marks are 60 or higher, assign Grade B.
- Else, assign Grade C.

A conditional checks whether something is true or false and then runs the appropriate commands.

---

## Essential numeric operators — learn these first

Before writing conditions, memorize these six numeric comparison operators:

| Operator | Meaning |
|---|---|
| `-eq` | Equal |
| `-ne` | Not equal |
| `-gt` | Greater than |
| `-ge` | Greater than or equal |
| `-lt` | Less than |
| `-le` | Less than or equal |

Examples:

```bash
[[ "$a" -eq "$b" ]]  # a is equal to b
[[ "$a" -ne "$b" ]]  # a is not equal to b
[[ "$a" -gt "$b" ]]  # a is greater than b
[[ "$a" -ge "$b" ]]  # a is greater than or equal to b
[[ "$a" -lt "$b" ]]  # a is less than b
[[ "$a" -le "$b" ]]  # a is less than or equal to b
```

The same operators also work with traditional single brackets:

```bash
[ "$a" -eq "$b" ]
```

> **Memory tip:** `e` means equal, `n` means not, `g` means greater, and `l` means less. The final `e` in `-ge` and `-le` means “or equal.”

---

## 2. Basic `if` statement

Syntax:

```bash
if [ condition ]
then
    commands
fi
```

Example:

```bash
#!/bin/bash

age=20

if [ "$age" -ge 18 ]
then
    echo "You are an adult."
fi
```

Output:

```text
You are an adult.
```

Important keywords:

| Keyword | Purpose |
|---|---|
| `if` | Starts the decision |
| `then` | Starts the commands for a true condition |
| `fi` | Closes the `if` statement |

`fi` is `if` written backward.

### Alternative layout

You can put `then` on the same line by adding a semicolon:

```bash
if [ "$age" -ge 18 ]; then
    echo "You are an adult."
fi
```

Both styles are correct.

---

## Double brackets: `[[ condition ]]`

Double brackets are Bash's improved conditional syntax:

```bash
if [[ condition ]]; then
    commands
fi
```

Example:

```bash
#!/bin/bash

read -r -p "Enter your age: " age

if [[ "$age" -ge 18 ]]; then
    echo "You are an adult."
else
    echo "You are under 18."
fi
```

### Why is there a semicolon before `then`?

When `then` appears on the same line, the semicolon separates the condition from `then`:

```bash
if [[ "$age" -ge 18 ]]; then
```

When `then` is placed on the next line, the semicolon is not required:

```bash
if [[ "$age" -ge 18 ]]
then
    echo "You are an adult."
fi
```

Both forms are correct.

### Single brackets compared with double brackets

| Feature | `[ condition ]` | `[[ condition ]]` |
|---|---|---|
| Traditional test syntax | Yes | No |
| Works in POSIX `sh` | Yes | No |
| Works in Bash | Yes | Yes |
| Protects against word splitting | No | Yes |
| Supports wildcard pattern matching | Limited | Yes |
| Supports regular expressions | No | Yes |
| Good choice for a new Bash script | Acceptable | Recommended |

Single-bracket example:

```bash
if [ "$name" = "Khalid" ]; then
    echo "Name matched."
fi
```

Double-bracket example:

```bash
if [[ "$name" == "Khalid" ]]; then
    echo "Name matched."
fi
```

You should still quote variable expansions as a good habit:

```bash
[[ "$name" == "Khalid" ]]
```

### Numeric comparisons with double brackets

```bash
if [[ "$number" -eq 10 ]]; then
    echo "The number is 10."
fi
```

All six numeric operators work inside double brackets:

| Operator | Meaning |
|---|---|
| `-eq` | Equal |
| `-ne` | Not equal |
| `-gt` | Greater than |
| `-ge` | Greater than or equal |
| `-lt` | Less than |
| `-le` | Less than or equal |

### String comparisons with double brackets

```bash
if [[ "$name" == "Khalid" ]]; then
    echo "Welcome, Khalid."
fi
```

```bash
if [[ -z "$username" ]]; then
    echo "Username cannot be empty."
fi
```

### Wildcard pattern matching

Double brackets support wildcard patterns:

```bash
if [[ "$name" == K* ]]; then
    echo "The name starts with K."
fi
```

Common patterns:

| Pattern | Meaning |
|---|---|
| `K*` | Starts with `K` |
| `*.sh` | Ends with `.sh` |
| `*admin*` | Contains `admin` |
| `?li` | Any one character followed by `li` |

Do not quote a wildcard when you want pattern matching:

```bash
[[ "$name" == K* ]]    # K* is treated as a pattern
[[ "$name" == "K*" ]]  # K* is treated as literal text
```

### File tests with double brackets

```bash
if [[ -f "$filename" ]]; then
    echo "The file exists."
else
    echo "The file does not exist."
fi
```

```bash
if [[ -d "$directory" ]]; then
    echo "The directory exists."
fi
```

```bash
if [[ -x "$script" ]]; then
    echo "The script is executable."
fi
```

### Multiple conditions

Use `&&` when both conditions must be true:

```bash
age=25
country="USA"

if [[ "$age" -ge 18 && "$country" == "USA" ]]; then
    echo "Both conditions are true."
fi
```

Use `||` when at least one condition must be true:

```bash
day="Saturday"

if [[ "$day" == "Saturday" || "$day" == "Sunday" ]]; then
    echo "It is the weekend."
fi
```

Use `!` to reverse a condition:

```bash
if [[ ! -f "hello.sh" ]]; then
    echo "hello.sh does not exist."
fi
```

### Important portability rule

Double brackets are supported by Bash, Zsh, and Korn shell, but they are not standard POSIX `sh` syntax.

Use double brackets in a Bash script with:

```bash
#!/bin/bash
```

Do not use them in a script intended specifically for:

```bash
#!/bin/sh
```

For this Bash course, learn both forms:

```bash
[ condition ]       # Traditional and portable
[[ condition ]]     # Safer and more capable in Bash
```

For new Bash scripts, `[[ condition ]]` is generally the better choice. You should still understand `[ condition ]` because it is common in existing scripts, RHCSA exercises, and interviews.

---

## 3. `if` and `else`

Use `else` when you need an alternative action for a false condition.

Syntax:

```bash
if [ condition ]
then
    commands_if_true
else
    commands_if_false
fi
```

Example:

```bash
#!/bin/bash

read -r -p "Enter your age: " age

if [ "$age" -ge 18 ]
then
    echo "You are an adult."
else
    echo "You are under 18."
fi
```

If the user enters `20`, the output is:

```text
You are an adult.
```

If the user enters `15`, the output is:

```text
You are under 18.
```

---

## 4. `if`, `elif`, and `else`

`elif` means **else if**. It allows a script to check another condition when the previous condition is false.

Syntax:

```bash
if [ condition1 ]
then
    commands
elif [ condition2 ]
then
    commands
else
    commands
fi
```

Example:

```bash
#!/bin/bash

read -r -p "Enter your marks: " marks

if [ "$marks" -ge 80 ]
then
    echo "Grade A"
elif [ "$marks" -ge 60 ]
then
    echo "Grade B"
elif [ "$marks" -ge 40 ]
then
    echo "Grade C"
else
    echo "Fail"
fi
```

Bash checks the conditions from top to bottom. It stops after finding the first true condition.

For `marks=75`:

1. `75 -ge 80` is false.
2. `75 -ge 60` is true.
3. Bash displays `Grade B`.
4. Bash does not check the remaining conditions.

---

## 5. Numeric comparison operators

Use these operators when comparing numbers:

| Operator | Meaning | Example |
|---|---|---|
| `-eq` | Equal to | `[ "$a" -eq "$b" ]` |
| `-ne` | Not equal to | `[ "$a" -ne "$b" ]` |
| `-gt` | Greater than | `[ "$a" -gt "$b" ]` |
| `-ge` | Greater than or equal to | `[ "$a" -ge "$b" ]` |
| `-lt` | Less than | `[ "$a" -lt "$b" ]` |
| `-le` | Less than or equal to | `[ "$a" -le "$b" ]` |

Example:

```bash
#!/bin/bash

number=10

if [ "$number" -eq 10 ]
then
    echo "The number is 10."
fi
```

### Positive, negative, or zero

```bash
#!/bin/bash

read -r -p "Enter a number: " number

if [ "$number" -gt 0 ]
then
    echo "The number is positive."
elif [ "$number" -eq 0 ]
then
    echo "The number is zero."
else
    echo "The number is negative."
fi
```

---

## 6. String comparison operators

Use these operators when comparing text:

| Operator | Meaning | Example |
|---|---|---|
| `=` | Strings are equal | `[ "$name" = "Khalid" ]` |
| `!=` | Strings are different | `[ "$name" != "Khalid" ]` |
| `-z` | String is empty | `[ -z "$name" ]` |
| `-n` | String is not empty | `[ -n "$name" ]` |

Example:

```bash
#!/bin/bash

read -r -p "Enter your name: " name

if [ "$name" = "Khalid" ]
then
    echo "Welcome, Khalid."
else
    echo "Welcome, $name."
fi
```

### Check for empty input

```bash
#!/bin/bash

read -r -p "Enter a username: " username

if [ -z "$username" ]
then
    echo "Username cannot be empty."
else
    echo "You entered: $username"
fi
```

---

## 7. File and directory tests

| Test | Meaning |
|---|---|
| `-e` | The path exists |
| `-f` | A regular file exists |
| `-d` | A directory exists |
| `-r` | The path is readable |
| `-w` | The path is writable |
| `-x` | The path is executable |
| `-s` | The file exists and is not empty |

### Check whether a file exists

```bash
#!/bin/bash

read -r -p "Enter a filename: " filename

if [ -f "$filename" ]
then
    echo "The file exists."
else
    echo "The file does not exist."
fi
```

### Check whether a directory exists

```bash
#!/bin/bash

read -r -p "Enter a directory: " directory

if [ -d "$directory" ]
then
    echo "The directory exists."
else
    echo "The directory does not exist."
fi
```

### Check whether a script is executable

```bash
#!/bin/bash

if [ -x "hello.sh" ]
then
    echo "hello.sh is executable."
else
    echo "hello.sh is not executable."
fi
```

---

## 8. Conditionals and exit statuses

Bash conditionals are based on command exit statuses:

| Exit status | Meaning in a conditional |
|---|---|
| `0` | True or successful |
| Non-zero | False or unsuccessful |

You can place a command directly after `if`:

```bash
#!/bin/bash

if id ali
then
    echo "The user exists."
else
    echo "The user does not exist."
fi
```

The `id` command displays its normal output. To make the check quiet:

```bash
#!/bin/bash

if id ali > /dev/null 2>&1
then
    echo "The user exists."
else
    echo "The user does not exist."
fi
```

Here:

- `> /dev/null` hides standard output.
- `2>&1` sends standard error to the same place.

---

## 9. Beginner user-checking script

```bash
#!/bin/bash

# Check whether a user exists

read -r -p "Enter username: " username

if getent passwd "$username" > /dev/null
then
    echo "User exists: $username"
    id "$username"
    getent passwd "$username"
else
    echo "User does not exist: $username"
fi
```

How it works:

1. The script asks for a username.
2. `getent passwd` checks the account database.
3. An exit status of `0` makes the `then` section run.
4. A non-zero exit status makes the `else` section run.

---

## 10. User-creation script with conditions

```bash
#!/bin/bash

# Create a user only if the username does not already exist

read -r -p "Enter username: " username

if getent passwd "$username" > /dev/null
then
    echo "User already exists: $username"
else
    sudo useradd -m -s /bin/bash "$username"

    if [ "$?" -eq 0 ]
    then
        echo "$username:$username@123" | sudo chpasswd
        sudo chage -d 0 "$username"
        echo "User created successfully: $username"
        id "$username"
        getent passwd "$username"
    else
        echo "User creation failed: $username"
    fi
fi
```

This example contains a **nested conditional**: one `if` statement inside another.

> **Lab safety:** The temporary password is predictable and visible inside the script. Use this example only in a disposable WSL, virtual machine, or classroom lab—not on a production or shared system.

---

## 11. Conditions using script arguments

```bash
#!/bin/bash

username="$1"

if [ -z "$username" ]
then
    echo "No username was provided."
    echo "Usage: $0 username"
elif getent passwd "$username" > /dev/null
then
    echo "User exists: $username"
else
    echo "User does not exist: $username"
fi
```

Run without an argument:

```bash
./check_user.sh
```

Output:

```text
No username was provided.
Usage: ./check_user.sh username
```

Run with an argument:

```bash
./check_user.sh ali
```

---

## 12. Check the number of arguments

```bash
#!/bin/bash

if [ "$#" -eq 0 ]
then
    echo "No arguments were supplied."
elif [ "$#" -eq 1 ]
then
    echo "One argument was supplied."
else
    echo "$# arguments were supplied."
fi
```

Test it:

```bash
./arguments.sh
./arguments.sh Ali
./arguments.sh Ali Linux Chicago
```

---

## 13. Nested conditionals

A nested conditional is an `if` statement inside another conditional.

```bash
#!/bin/bash

read -r -p "Enter your age: " age

if [ "$age" -ge 18 ]
then
    echo "You are an adult."

    if [ "$age" -ge 60 ]
    then
        echo "You are also a senior adult."
    fi
else
    echo "You are under 18."
fi
```

Each `if` requires its own closing `fi`.

---

## 14. Important spacing rules

Spaces around `[` and `]` are required.

Correct:

```bash
if [ "$age" -ge 18 ]
```

Incorrect:

```bash
if ["$age" -ge 18]
```

Variable assignments must not contain spaces around `=`.

Correct:

```bash
age=20
```

Incorrect:

```bash
age = 20
```

---

## 15. Common mistakes

### Missing `then`

Incorrect:

```bash
if [ "$age" -ge 18 ]
    echo "Adult"
fi
```

Correct:

```bash
if [ "$age" -ge 18 ]
then
    echo "Adult"
fi
```

### Missing `fi`

Every `if` statement must finish with:

```bash
fi
```

### Using a numeric operator for text

Incorrect:

```bash
[ "$name" -eq "Khalid" ]
```

Correct:

```bash
[ "$name" = "Khalid" ]
```

### Using a string operator for numbers

Avoid:

```bash
[ "$age" = 18 ]
```

Recommended:

```bash
[ "$age" -eq 18 ]
```

### Not quoting variables

Less safe:

```bash
[ $name = "Khalid" ]
```

Recommended:

```bash
[ "$name" = "Khalid" ]
```

### Incorrect spelling of `elif`

Correct Bash keyword:

```bash
elif
```

Not:

```text
elseif
else if
```

---

## 16. Syntax checking and execution

Check a Bash script without executing it:

```bash
bash -n conditions.sh
```

No output normally means that Bash found no syntax error.

Add execute permission:

```bash
chmod u+x conditions.sh
```

Run the script:

```bash
./conditions.sh
```

Remember that `bash -n` checks syntax; it does not guarantee that the script's logic or input values are correct.

---

## 17. Practice tasks

1. Ask for an age and display whether the user is an adult.
2. Ask for a number and identify whether it is positive, negative, or zero.
3. Ask for marks and display Grades A, B, C, or Fail.
4. Ask for a name and compare it with `Khalid`.
5. Detect whether the user submitted empty input.
6. Ask for a filename and check whether it exists.
7. Ask for a directory and check whether it exists.
8. Check whether `hello.sh` is executable.
9. Ask for a username and check it with `getent passwd`.
10. Accept a username as `$1` and display a usage message when it is missing.
11. Use `$#` to report how many arguments were supplied.
12. Run `bash -n` against every completed script.

---

## 18. Quick-reference tables

### Conditional structure

```bash
if [ condition ]
then
    echo "The first condition is true."
elif [ another_condition ]
then
    echo "The second condition is true."
else
    echo "All conditions are false."
fi
```

### Numeric tests

| Test | Meaning |
|---|---|
| `-eq` | Equal |
| `-ne` | Not equal |
| `-gt` | Greater than |
| `-ge` | Greater than or equal |
| `-lt` | Less than |
| `-le` | Less than or equal |

### String tests

| Test | Meaning |
|---|---|
| `=` | Equal strings |
| `!=` | Different strings |
| `-z` | Empty string |
| `-n` | Non-empty string |

### File tests

| Test | Meaning |
|---|---|
| `-e` | Exists |
| `-f` | Regular file |
| `-d` | Directory |
| `-r` | Readable |
| `-w` | Writable |
| `-x` | Executable |
| `-s` | Exists and is not empty |

---

## Final summary

- `if` starts a decision.
- `then` contains commands for a true condition.
- `elif` checks another condition.
- `else` handles all remaining cases.
- `fi` closes the conditional.
- Bash treats exit status `0` as true or successful.
- Bash treats a non-zero exit status as false or unsuccessful.
- Use numeric operators such as `-eq`, `-gt`, and `-le` for numbers.
- Use `=`, `!=`, `-z`, and `-n` for strings.
- Use tests such as `-f`, `-d`, and `-x` for filesystem objects.
- Always include spaces inside `[ condition ]`.
- Quote variable expansions such as `"$username"`.
