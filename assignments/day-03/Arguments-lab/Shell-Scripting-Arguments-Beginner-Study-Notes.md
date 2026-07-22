# Shell Scripting Arguments — Beginner Study Notes

## Learning objectives

After completing this lesson, you should be able to:

- Explain what shell-script arguments are.
- Pass arguments to a Bash script.
- Use `$0`, `$1`, `$2`, and other positional parameters.
- Count arguments with `$#`.
- Use `"$@"` and `"$*"` correctly.
- Pass arguments containing spaces.
- Understand the difference between arguments and `read` input.
- Use arguments in simple administrative scripts.

---

## 1. What are shell-script arguments?

Arguments are values supplied to a shell script when the script is started.

Example:

```bash
./student.sh Ali Linux Chicago
```

In this command:

- `./student.sh` is the script name.
- `Ali` is the first argument.
- `Linux` is the second argument.
- `Chicago` is the third argument.

Bash automatically stores these values in special variables called **positional parameters**.

---

## 2. Positional parameters

| Variable | Meaning |
|---|---|
| `$0` | Name used to start the script |
| `$1` | First argument |
| `$2` | Second argument |
| `$3` | Third argument |
| `$4` to `$9` | Fourth through ninth arguments |
| `${10}` | Tenth argument |
| `${11}` | Eleventh argument |
| `$#` | Number of arguments supplied |
| `"$@"` | All arguments, preserved as separate values |
| `"$*"` | All arguments combined into one value |

Other useful special variables include:

| Variable | Meaning |
|---|---|
| `$?` | Exit status of the previous command |
| `$$` | Process ID of the current shell |

`$?` and `$$` are special shell variables, but they are not script arguments.

---

## 3. Your first argument script

Create a file:

```bash
nano arguments.sh
```

Add:

```bash
#!/bin/bash

# Basic shell-script argument practice

echo "Script name: $0"
echo "First argument: $1"
echo "Second argument: $2"
echo "Third argument: $3"
echo "Number of arguments: $#"
echo "All arguments: $@"
```

Check the syntax:

```bash
bash -n arguments.sh
```

Add execute permission:

```bash
chmod u+x arguments.sh
```

Run it:

```bash
./arguments.sh Ali Linux Chicago
```

Expected output:

```text
Script name: ./arguments.sh
First argument: Ali
Second argument: Linux
Third argument: Chicago
Number of arguments: 3
All arguments: Ali Linux Chicago
```

The script name in `$0` is not included in `$#`.

---

## 4. Understanding `$0`

`$0` contains the name or path used to start the script.

Run:

```bash
./arguments.sh Ali
```

Possible value:

```text
$0 = ./arguments.sh
```

Run:

```bash
bash arguments.sh Ali
```

Possible value:

```text
$0 = arguments.sh
```

Therefore, `$0` can look slightly different depending on how the script was started.

---

## 5. Understanding `$1`, `$2`, and `$3`

Consider:

```bash
./arguments.sh Khalid Bash Chicago
```

Bash assigns:

```text
$1 = Khalid
$2 = Bash
$3 = Chicago
```

These variables follow the position of each argument.

If an expected argument is not supplied, its positional parameter is empty.

Example:

```bash
./arguments.sh Khalid
```

Results:

```text
$1 = Khalid
$2 = empty
$3 = empty
```

---

## 6. Count arguments with `$#`

`$#` contains the number of arguments supplied to the script.

Example script:

```bash
#!/bin/bash

echo "You supplied $# arguments."
```

Run:

```bash
./count.sh Ali Linux Chicago
```

Output:

```text
You supplied 3 arguments.
```

The script name is not counted as an argument.

---

## 7. Arguments containing spaces

Place quotation marks around a single argument that contains spaces.

Correct:

```bash
./arguments.sh "Muhammad Ali" Linux "New York"
```

Bash receives three arguments:

```text
$1 = Muhammad Ali
$2 = Linux
$3 = New York
$# = 3
```

Without quotation marks:

```bash
./arguments.sh Muhammad Ali Linux New York
```

Bash receives five arguments:

```text
$1 = Muhammad
$2 = Ali
$3 = Linux
$4 = New
$5 = York
$# = 5
```

Quotation marks tell Bash that words separated by spaces belong to one argument.

---

## 8. Understanding `"$@"`

`"$@"` represents all supplied arguments while preserving each argument as a separate value.

Suppose you run:

```bash
./arguments.sh "Muhammad Ali" Linux "New York"
```

Conceptually, `"$@"` represents:

```text
"Muhammad Ali" "Linux" "New York"
```

This makes `"$@"` the recommended form when passing all received arguments to another command or script:

```bash
another_command "$@"
```

Each original argument remains separate, including arguments containing spaces.

---

## 9. Understanding `"$*"`

`"$*"` also represents all arguments, but when quoted it combines them into one string.

For the same command:

```bash
./arguments.sh "Muhammad Ali" Linux "New York"
```

Conceptually, `"$*"` represents:

```text
"Muhammad Ali Linux New York"
```

The three original arguments become one combined value.

---

## 10. Difference between `"$@"` and `"$*"`

| Expression | Result when quoted | Recommended use |
|---|---|---|
| `"$@"` | Keeps every argument separate | Passing all arguments safely |
| `"$*"` | Combines all arguments into one string | When one combined string is intentionally needed |

Main rule:

```bash
"$@"  # Recommended for safely forwarding all arguments
```

Although `echo "$@"` and `echo "$*"` may display similar text, they behave differently when passed to another command.

---

## 11. Arguments above number nine

Use braces for the tenth argument and higher:

```bash
echo "Ninth argument: $9"
echo "Tenth argument: ${10}"
echo "Eleventh argument: ${11}"
```

Do not write this for the tenth argument:

```bash
echo "$10"
```

Bash can interpret `$10` as `$1` followed by the character `0`. Braces clearly identify the argument number:

```bash
echo "${10}"
```

---

## 12. Copy an argument into a descriptive variable

Instead of using `$1` repeatedly, copy it into a meaningful variable:

```bash
#!/bin/bash

username="$1"

echo "Requested username: $username"
```

Run:

```bash
./user_info.sh student1
```

The assignment:

```bash
username="$1"
```

means that the value of the first argument is stored in the variable named `username`.

This makes the rest of the script easier to understand.

---

## 13. Arguments versus `read`

Arguments are supplied when the script is started:

```bash
./greeting.sh Khalid
```

Argument example:

```bash
#!/bin/bash

echo "Hello, $1"
```

The `read` command requests input while the script is already running:

```bash
#!/bin/bash

read -r -p "Enter your name: " name

echo "Hello, $name"
```

| Input method | When the value is supplied |
|---|---|
| Argument | When starting the script |
| `read` | While the script is running |

Arguments are useful for automation because a script can receive values without stopping to ask questions.

---

## 14. Beginner user-information script

Create `user_info.sh`:

```bash
#!/bin/bash

# Display information about a user supplied as an argument

username="$1"

echo "Requested username: $username"
id "$username"
getent passwd "$username"
```

Run:

```bash
./user_info.sh khalid
```

Here:

```text
$1 = khalid
```

---

## 15. Beginner user-creation script using an argument

```bash
#!/bin/bash

# Create a user whose name is supplied as the first argument

username="$1"

echo "Requested username: $username"

sudo useradd -m -s /bin/bash "$username" &&
id "$username" &&
getent passwd "$username" &&
echo "User created successfully: $username" ||
echo "User creation failed: $username"
```

Run:

```bash
./create_user.sh student1
```

This script expects the username as its first argument.

> **Lab safety:** Practise user creation only in a disposable WSL, virtual machine, or classroom lab—not on a production or shared system.

---

## 16. Argument practice script

```bash
#!/bin/bash

# Complete beginner argument demonstration

echo "Argument Practice"
echo "-----------------"
echo "Script name: $0"
echo "First argument: $1"
echo "Second argument: $2"
echo "Third argument: $3"
echo "Number of arguments: $#"
echo "All arguments using \$@: $@"
echo "All arguments using \$*: $*"
```

Test it:

```bash
bash -n arguments.sh
chmod u+x arguments.sh
./arguments.sh Khalid Bash "Shell Scripting"
```

Expected important values:

```text
$1 = Khalid
$2 = Bash
$3 = Shell Scripting
$# = 3
```

The backslash in `\$@` and `\$*` makes `echo` display their names as text. The final `$@` and `$*` are expanded normally.

---

## 17. Common mistakes

### Mistake 1: Forgetting quotation marks around an argument with spaces

Incorrect:

```bash
./greeting.sh Muhammad Ali
```

If the complete name is one argument, use:

```bash
./greeting.sh "Muhammad Ali"
```

### Mistake 2: Forgetting quotation marks around a variable

Less safe:

```bash
echo $1
```

Recommended:

```bash
echo "$1"
```

### Mistake 3: Using `$10` for the tenth argument

Incorrect:

```bash
echo "$10"
```

Correct:

```bash
echo "${10}"
```

### Mistake 4: Counting the script name as an argument

`$0` contains the script name, but `$#` counts only the supplied arguments.

### Mistake 5: Assuming `"$@"` and `"$*"` are identical

They can look similar when printed, but `"$@"` preserves separate arguments while `"$*"` creates one combined value.

---

## 18. Practice tasks

1. Create `arguments.sh` and display `$0`, `$1`, `$2`, and `$3`.
2. Display the number of supplied arguments with `$#`.
3. Display all arguments with `$@`.
4. Run the script with three normal arguments.
5. Run it again with one argument containing spaces.
6. Compare the value of `$#` in both tests.
7. Store `$1` in a variable named `username`.
8. Use that variable with `id` and `getent passwd`.
9. Display `${10}` after passing at least ten arguments.
10. Explain the difference between `"$@"` and `"$*"` in your own words.

---

## 19. Quick-reference table

| Requirement | Syntax |
|---|---|
| Script name | `$0` |
| First argument | `$1` |
| Second argument | `$2` |
| Third argument | `$3` |
| Tenth argument | `${10}` |
| Number of arguments | `$#` |
| All arguments kept separately | `"$@"` |
| All arguments as one string | `"$*"` |
| Previous command's status | `$?` |
| Current shell's process ID | `$$` |

---

## Final summary

Arguments allow you to provide information when starting a script:

```bash
./script.sh value1 value2 value3
```

Bash stores the values according to their positions:

```text
$1 = value1
$2 = value2
$3 = value3
```

Remember these three important forms:

```bash
$#     # Number of arguments
"$@"   # All arguments, kept separately
"$*"   # All arguments combined into one string
```

For safely passing all received arguments to another command, prefer:

```bash
"$@"
```

