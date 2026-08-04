# Bash Scripting Challenge Tasks 1 — Solutions

## Summary

This guide contains complete solutions for all seven scripts in:

```text
Bash-Scripting-Challenge-Tasks-1.md
```

The solutions demonstrate:

- `for` and `while` loops
- Arrays
- Safe command-line argument handling
- Input validation
- Root-user validation
- Debian/Ubuntu and RHEL-family package checks
- Exit statuses
- `set -e`
- Explicit error handling with `||`
- Error messages sent to `stderr`

---

## Table of Contents

1. [Prepare the Lab Directory](#1-prepare-the-lab-directory)
2. [Solution 1A — Fruit List](#2-solution-1a--fruit-list)
3. [Solution 1B — Count from 1 to 10](#3-solution-1b--count-from-1-to-10)
4. [Solution 2 — Countdown](#4-solution-2--countdown)
5. [Solution 3A — Greeting Script](#5-solution-3a--greeting-script)
6. [Solution 3B — Argument Information](#6-solution-3b--argument-information)
7. [Solution 4 — Package Installer](#7-solution-4--package-installer)
8. [Solution 5A — Safe File-Creation Workflow](#8-solution-5a--safe-file-creation-workflow)
9. [Solution 5B — Package-Installer Error Handling](#9-solution-5b--package-installer-error-handling)
10. [Syntax and Behavior Tests](#10-syntax-and-behavior-tests)
11. [Exit-Status Revision](#11-exit-status-revision)
12. [Final Checklist](#12-final-checklist)

---

# 1. Prepare the Lab Directory

Create and enter the working directory:

```bash
mkdir -p bash-challenges
cd bash-challenges
```

The completed directory should contain:

```text
bash-challenges/
├── for_loop.sh
├── count.sh
├── countdown.sh
├── greet.sh
├── args_demo.sh
├── install_packages.sh
└── safe_script.sh
```

[Back to Table of Contents](#table-of-contents)

---

# 2. Solution 1A — Fruit List

## Filename

```text
for_loop.sh
```

## Complete solution

```bash
#!/bin/bash

# Title: Fruit List
# Purpose: Print five fruits with item numbers.

fruits=("apple" "banana" "mango" "orange" "red cherry")
item_number=1

for fruit in "${fruits[@]}"
do
    echo "Item $item_number: $fruit"
    item_number=$((item_number + 1))
done

exit 0
```

## Explanation

### Create an array

```bash
fruits=("apple" "banana" "mango" "orange" "red cherry")
```

The quotation marks keep `red cherry` together as one array element.

### Process every array element

```bash
for fruit in "${fruits[@]}"
```

Quoted `"${fruits[@]}"` expands every array item separately and safely.

## Meaning of each symbol
```bash
"${fruits[@]}"
```

| Part     | Meaning                       |
| -------- | ----------------------------- |
| `$`      | Request the value             |
| `{ }`    | Mark the variable expression  |
| `fruits` | Array name                    |
| `[@]`    | Select all array elements     |
| `" "`    | Preserve each element exactly |

[More Details Click Here in roman Urdu](./md/Bash-Array-At-Symbol-Roman-Urdu-Study-Notes.md)

[More Details Click Here](./md/Bash-Array-At-Symbol-Study-Notes.md)

### Increase the item number

```bash
item_number=$((item_number + 1))
```

This adds `1` after each loop iteration.

## Expected output

```text
Item 1: apple
Item 2: banana
Item 3: mango
Item 4: orange
Item 5: red cherry
```

[Back to Table of Contents](#table-of-contents)

---

# 3. Solution 1B — Count from 1 to 10

## Filename

```text
count.sh
```

## Complete solution

```bash
#!/bin/bash

# Title: Number Counter
# Purpose: Print numbers 1 through 10.

for number in {1..10}
do
    echo "$number"
done

exit 0
```

## Explanation

```bash
{1..10}
```

Brace expansion generates:

```text
1 2 3 4 5 6 7 8 9 10
```

The `for` loop stores one number at a time in `number`.

[Back to Table of Contents](#table-of-contents)

---

# 4. Solution 2 — Countdown

## Filename

```text
countdown.sh
```

## Complete solution

```bash
#!/bin/bash

# Title: Countdown
# Purpose: Count from a user-supplied whole number down to zero.

if ! read -r -p "Enter a starting number: " starting_number; then
    echo "Error: could not read the input." >&2
    exit 1
fi

if [[ ! "$starting_number" =~ ^[0-9]+$ ]]; then
    echo "Error: enter a non-negative whole number." >&2
    exit 1
fi

# The 10# prefix treats values such as 08 as decimal numbers.
count=$((10#$starting_number))

while (( count >= 0 ))
do
    echo "$count"
    count=$((count - 1))
done

echo "Done!"
exit 0
```

## Explanation

### Check whether `read` succeeds

```bash
if ! read -r -p "Enter a starting number: " starting_number
```

The `!` reverses the result. The error block runs if `read` fails.

### Validate the input

```bash
[[ "$starting_number" =~ ^[0-9]+$ ]]
```

The regex requires one or more digits from the beginning to the end.

| Regex part | Meaning |
|---|---|
| `^` | Beginning |
| `[0-9]` | One digit |
| `+` | One or more |
| `$` | End |

### Count down

```bash
while (( count >= 0 ))
```

The loop continues while `count` is at least zero.

## Example

```text
Enter a starting number: 5
5
4
3
2
1
0
Done!
```

Invalid input:

```text
Enter a starting number: apple
Error: enter a non-negative whole number.
```

[Detailed Explanation](./md/Bash-Positive-Negative-Countdown-Roman-Urdu-Study-Notes.md)

[Back to Table of Contents](#table-of-contents)

---

# 5. Solution 3A — Greeting Script

## Filename

```text
greet.sh
```

## Complete solution

```bash
#!/bin/bash

# Title: Greeting Script
# Purpose: Greet the name supplied as the first argument.
# Usage: ./greet.sh NAME

if [[ "$#" -lt 1 ]]; then
    echo "Usage: $0 NAME" >&2
    exit 1
fi

name="$1"

echo "Hello, $name!"
exit 0
```

## Explanation

### Count the arguments

```bash
"$#"
```

`$#` contains the number of arguments supplied to the script.

### Access the first argument

```bash
name="$1"
```

`$1` contains the first command-line argument.

### Display a useful usage message

```bash
echo "Usage: $0 NAME" >&2
```

- `$0` contains the script name.
- `>&2` sends the message to `stderr`.

## Example

```bash
./greet.sh Ali
```

```text
Hello, Ali!
```

Missing argument:

```bash
./greet.sh
```

```text
Usage: ./greet.sh NAME
```

[Back to Table of Contents](#table-of-contents)

---

# 6. Solution 3B — Argument Information

## Filename

```text
args_demo.sh
```

## Complete solution

```bash
#!/bin/bash

# Title: Argument Demonstration
# Purpose: Display the script name and supplied arguments.

echo "Script name: $0"
echo "Arguments count: $#"
echo "All arguments:"

item_number=1

for argument in "$@"
do
    echo "Item $item_number: $argument"
    item_number=$((item_number + 1))
done

exit 0
```

## Explanation

| Parameter | Meaning |
|---|---|
| `$0` | Script name |
| `$#` | Number of arguments |
| `"$@"` | All arguments preserved separately |

This loop:

```bash
for argument in "$@"
```

keeps `"red cherry"` as one argument.

## Example

```bash
./args_demo.sh apple banana "red cherry"
```

```text
Script name: ./args_demo.sh
Arguments count: 3
All arguments:
Item 1: apple
Item 2: banana
Item 3: red cherry
```

[Back to Table of Contents](#table-of-contents)

---

# 7. Solution 4 — Package Installer

## Filename

```text
install_packages.sh
```

## Complete solution

```bash
#!/bin/bash

# Title: Cross-Distribution Package Installer
# Purpose: Install nginx, curl, and wget when they are missing.
# Usage: sudo ./install_packages.sh

if (( EUID != 0 )); then
    echo "Error: run this script with sudo." >&2
    echo "Usage: sudo $0" >&2
    exit 1
fi

packages=("nginx" "curl" "wget")
installation_failed=0

if command -v dpkg >/dev/null 2>&1 &&
   command -v apt-get >/dev/null 2>&1; then

    distribution_family="Debian/Ubuntu"

    is_installed()
    {
        dpkg -s "$1" >/dev/null 2>&1
    }

    install_package()
    {
        DEBIAN_FRONTEND=noninteractive apt-get install -y -- "$1"
    }

elif command -v rpm >/dev/null 2>&1; then

    distribution_family="RHEL"

    if command -v dnf >/dev/null 2>&1; then
        install_command=("dnf" "install" "-y")
    elif command -v yum >/dev/null 2>&1; then
        install_command=("yum" "install" "-y")
    else
        echo "Error: neither dnf nor yum is available." >&2
        exit 1
    fi

    is_installed()
    {
        rpm -q "$1" >/dev/null 2>&1
    }

    install_package()
    {
        "${install_command[@]}" "$1"
    }

else
    echo "Error: supported package-management tools were not found." >&2
    exit 1
fi

echo "Detected system family: $distribution_family"

for package in "${packages[@]}"
do
    if is_installed "$package"; then
        echo "[INSTALLED] $package is already installed."
        continue
    fi

    echo "[MISSING] Installing $package..."

    if install_package "$package"; then
        echo "[SUCCESS] $package was installed."
    else
        echo "[ERROR] $package installation failed." >&2
        installation_failed=1
    fi
done

if (( installation_failed != 0 )); then
    echo "Error: one or more packages could not be installed." >&2
    exit 1
fi

echo "All packages are installed or were already present."
exit 0
```

## Explanation

### Verify root privileges

```bash
if (( EUID != 0 )); then
```

`EUID` contains the effective user ID. Root uses ID `0`.

### Detect the package system

```bash
command -v dpkg
command -v rpm
```

`command -v` checks whether a command is available.

### Define common function names

Each operating-system branch defines:

```text
is_installed
install_package
```

The main loop can therefore use the same logic on both distribution families.

### Continue after one package fails

```bash
installation_failed=1
```

The script records the failure but continues checking the remaining packages. It returns `exit 1` at the end if any installation failed.

### Why use `continue`?

```bash
continue
```

When a package is already installed, `continue` skips directly to the next package.

## Run the script

First, make it executable:

```bash
chmod +x install_packages.sh
```

Verify the root check:

```bash
./install_packages.sh
```

Expected result:

```text
Error: run this script with sudo.
Usage: sudo ./install_packages.sh
```

Run the real installation only after reviewing the script:

```bash
sudo ./install_packages.sh
```

> This script changes installed software. Use it only on a practice system where package installation is authorized.

[Back to Table of Contents](#table-of-contents)

---

# 8. Solution 5A — Safe File-Creation Workflow

## Filename

```text
safe_script.sh
```

## Complete solution

```bash
#!/bin/bash

# Title: Safe File-Creation Workflow
# Purpose: Create a directory and file with explicit failure handling.

set -e

target_directory="/tmp/devops-test"
target_file="$target_directory/challenge.txt"

mkdir -p -- "$target_directory" || {
    echo "Error: could not create or verify $target_directory." >&2
    exit 1
}

echo "Directory created or verified: $target_directory"

cd -- "$target_directory" || {
    echo "Error: could not enter $target_directory." >&2
    exit 1
}

echo "Entered directory: $target_directory"

touch -- "$target_file" || {
    echo "Error: could not create $target_file." >&2
    exit 1
}

echo "File created successfully: $target_file"
echo "Workflow completed"
exit 0
```

## Explanation

### Enable exit-on-error

```bash
set -e
```

This asks Bash to exit after many unhandled command failures.

It is not a replacement for clear error handling.

### Make directory creation repeatable

```bash
mkdir -p -- "$target_directory"
```

- `-p` succeeds when the directory already exists.
- `--` marks the end of command options.
- Quoting protects paths containing spaces.

### Handle each important failure

```bash
command || {
    echo "Error: command failed." >&2
    exit 1
}
```

A command directly before `||` is considered handled, so `set -e` does not automatically terminate at that point. The explicit `exit 1` guarantees that the workflow stops.

### Avoid a false success message

The success messages occur only after their associated commands complete successfully.

## Expected output

```text
Directory created or verified: /tmp/devops-test
Entered directory: /tmp/devops-test
File created successfully: /tmp/devops-test/challenge.txt
Workflow completed
```

Verify the result:

```bash
ls -l /tmp/devops-test/challenge.txt
```

[Back to Table of Contents](#table-of-contents)

---

# 9. Solution 5B — Package-Installer Error Handling

The final `install_packages.sh` solution in [Solution 4](#7-solution-4--package-installer) already includes the required improvements:

| Requirement | Implementation |
|---|---|
| Root-user validation | `(( EUID != 0 ))` |
| Package-manager detection | `command -v dpkg`, `rpm`, `dnf`, and `yum` |
| Installation failure check | `if install_package "$package"` |
| Error sent to `stderr` | `>&2` |
| Failure exit status | `exit 1` |
| Final success only when appropriate | Checked with `installation_failed` |

This pattern:

```bash
if install_package "$package"; then
    echo "[SUCCESS] $package was installed."
else
    echo "[ERROR] $package installation failed." >&2
    installation_failed=1
fi
```

checks the installation command directly. There is no need to save `$?` separately.

[Back to Table of Contents](#table-of-contents)

---

# 10. Syntax and Behavior Tests

## Make the scripts executable

```bash
chmod +x for_loop.sh
chmod +x count.sh
chmod +x countdown.sh
chmod +x greet.sh
chmod +x args_demo.sh
chmod +x install_packages.sh
chmod +x safe_script.sh
```

## Check all scripts for syntax errors

```bash
bash -n for_loop.sh
bash -n count.sh
bash -n countdown.sh
bash -n greet.sh
bash -n args_demo.sh
bash -n install_packages.sh
bash -n safe_script.sh
```

No output normally means that Bash found no syntax errors.

## Test the loop scripts

```bash
./for_loop.sh
./count.sh
./countdown.sh
```

## Test valid arguments

```bash
./greet.sh Ali
./args_demo.sh apple banana "red cherry"
```

## Test missing arguments

```bash
./greet.sh
echo $?
```

Expected exit status:

```text
1
```

## Test the package installer's root check

Run without `sudo`:

```bash
./install_packages.sh
echo $?
```

It should refuse to install packages and return a nonzero status.

Do not run the real installation until the script has been reviewed:

```bash
sudo ./install_packages.sh
```

## Test the safe workflow

```bash
./safe_script.sh
echo $?
```

Verify the file:

```bash
ls -l /tmp/devops-test/challenge.txt
```

## Trace a script

```bash
bash -x countdown.sh
```

> Avoid tracing scripts that handle passwords, tokens, or other secrets.

[Back to Table of Contents](#table-of-contents)

---

# 11. Exit-Status Revision

| Status | Meaning |
|---:|---|
| `0` | Success |
| Nonzero | Failure or another exceptional result |

Check the status immediately:

```bash
./greet.sh
echo $?
```

If another command runs first, `$?` will contain that newer command's status.

## Direct checking is normally clearer

Preferred:

```bash
if cp -- "$source" "$destination"; then
    echo "Copy completed"
else
    echo "Error: copy failed." >&2
    exit 1
fi
```

This avoids accidentally overwriting `$?` before it is checked.

[Back to Table of Contents](#table-of-contents)

---

# 12. Final Checklist

- [x] `for_loop.sh` uses a quoted array expansion.
- [x] `count.sh` prints `1` through `10`.
- [x] `countdown.sh` validates input before arithmetic.
- [x] `greet.sh` validates `$#` and uses `$1`.
- [x] `args_demo.sh` safely processes `"$@"`.
- [x] `install_packages.sh` checks root privileges.
- [x] The package installer supports Debian/Ubuntu and RHEL-family systems.
- [x] Installed packages are skipped.
- [x] Installation failures are recorded and reported.
- [x] `safe_script.sh` uses `set -e` and explicit error handlers.
- [x] Error messages are sent to `stderr`.
- [x] Failure paths return a nonzero exit status.
- [x] Success messages appear only after successful operations.

[Back to Table of Contents](#table-of-contents)

