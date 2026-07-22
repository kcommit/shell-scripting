# Bash Scripting Day 2 — Beginner Solution

This solution uses only the commands and ideas demonstrated during the lecture.

## Topics Used

- Shebang: `#!/bin/bash`
- Single-line comments
- Multiline description
- `echo`
- Simple variables
- `read`
- Exit status: `$?`
- Standard output and standard error
- `&&` and `||`
- `useradd`
- `id`
- `getent passwd`

The solution does not use functions, `if`, `elif`, `else`, `[[ ]]`, arguments, arrays, regex, `set`, `readonly`, or advanced input validation.

---

## Files

```text
day-02-beginner-solution/
├── README.md
├── hello.sh
├── output_error.sh
├── command_logic.sh
└── create_user.sh
```

---

## 1. Give Execute Permission

```bash
chmod u+x hello.sh
chmod u+x output_error.sh
chmod u+x command_logic.sh
chmod u+x create_user.sh
```

Check permissions:

```bash
ls -l
```

---

## 2. Run `hello.sh`

```bash
./hello.sh
```

Example:

```text
NIT: Hello Doston
Name is ali
Name is omar
Enter your name:
Ali
You entered Ali
```

The important variable examples are:

```bash
name=ali
echo "Name is $name"
```

Do not add spaces around `=`.

Correct:

```bash
name=ali
```

Incorrect:

```bash
name = ali
```

The incorrect version makes Bash treat `name` like a command.

---

## 3. Run `output_error.sh`

```bash
./output_error.sh
```

The script performs:

```bash
ls
echo "Exit status is $?"
```

The successful `ls` command normally returns:

```text
0
```

It also performs:

```bash
cd /missing
echo "Exit status is $?"
```

The failed `cd` command normally returns a nonzero status.

The script saves normal output and an error separately:

```bash
ls > standard-output.txt
cd /missing 2> standard-error.txt
```

Read the files:

```bash
cat standard-output.txt
cat standard-error.txt
```

---

## 4. Run `command_logic.sh`

```bash
./command_logic.sh
```

The `&&` example is:

```bash
mkdir -p d1 && cd d1
```

The second command runs when the first command succeeds.

The `||` example is:

```bash
cd /missing || cd d1
```

The second command runs when the first command fails.

---

## 5. Run `create_user.sh`

> Run this script only on WSL or a Linux practice machine because it can create a real Linux user.

```bash
./create_user.sh
```

Enter a practice username:

```text
student02
```

This line checks the user and creates it only when it does not already exist:

```bash
getent passwd "$username" >/dev/null || sudo useradd -m "$username"
```

This line checks whether the user is ready:

```bash
getent passwd "$username" >/dev/null && echo "User is ready: $username" || echo "User could not be created: $username"
```

The final commands display the account:

```bash
id "$username"
getent passwd "$username"
```

---

## 6. Check Script Syntax

```bash
bash -n hello.sh
bash -n output_error.sh
bash -n command_logic.sh
bash -n create_user.sh
```

No output means Bash did not find a syntax error.

---

## 7. Check Exit Status

```bash
./hello.sh
echo $?
```

Status `0` normally means success. A nonzero status normally means failure.

---

## Suggested Git Commit

```bash
git add day-02-beginner-solution/
git commit -m "Add Bash Day 2 beginner solution"
```
