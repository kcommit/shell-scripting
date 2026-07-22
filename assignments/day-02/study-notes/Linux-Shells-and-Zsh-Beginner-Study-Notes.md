# Linux Shells and Zsh — Beginner Study Notes

## Learning objectives

By the end of this lesson, you should be able to:

- Explain what a shell is.
- Check your current and login shells.
- List the shells available on Linux.
- Enter and leave another shell temporarily.
- Change a user's login shell.
- Write and execute a Zsh script.
- Assign a shell while creating a user.
- Understand when the shebang is used.

---

## 1. What is a shell?

A shell is a program that accepts commands from a user and asks the operating system to execute them.

Common Linux shells include:

| Shell | Common path | Description |
|---|---|---|
| Bash | `/bin/bash` | Commonly used for Linux administration and scripting |
| Zsh | `/usr/bin/zsh` or `/bin/zsh` | Interactive shell with useful customization features |
| Dash | `/bin/dash` | Small and fast shell commonly used for system scripts |
| Sh | `/bin/sh` | Standard shell path; it may point to another shell |

---

## 2. List the available login shells

Linux records approved login shells in `/etc/shells`.

```bash
cat /etc/shells
```

Example output:

```text
/bin/sh
/bin/bash
/usr/bin/bash
/bin/dash
/usr/bin/zsh
```

This file does not necessarily list every executable shell on the system. It lists shells approved for use as login shells.

---

## 3. Find the path of a shell

Use `command -v` to find a command through your `PATH`:

```bash
command -v bash
command -v zsh
command -v dash
```

Example:

```text
/usr/bin/zsh
```

If `command -v zsh` produces no output, Zsh may not be installed.

Install it on Ubuntu or WSL Ubuntu:

```bash
sudo apt update
sudo apt install zsh
```

---

## 4. Check your shells

### Check your configured login shell

```bash
echo "$SHELL"
```

`$SHELL` normally contains the shell configured for your account. It does not always change when you temporarily start another shell.

### Check the currently running shell process

```bash
echo "$0"
```

### Check the account database

```bash
getent passwd "$USER"
```

Example:

```text
khalid:x:1000:1000:Khalid:/home/khalid:/bin/bash
```

The last field, `/bin/bash`, is the user's configured login shell.

---

## 5. Enter another shell temporarily

To start Zsh from Bash:

```bash
zsh
```

Check it:

```bash
echo "$0"
echo "$ZSH_VERSION"
```

Leave Zsh and return to the previous shell:

```bash
exit
```

Starting `zsh` this way does not permanently change your login shell.

---

## 6. Change your login shell permanently

First, find the Zsh path:

```bash
command -v zsh
```

Change your login shell:

```bash
chsh -s "$(command -v zsh)"
```

Log out and log back in. In WSL, close the WSL session and open it again.

Verify the change:

```bash
echo "$SHELL"
getent passwd "$USER"
```

Return to Bash later if needed:

```bash
chsh -s /bin/bash
```

The selected shell should be installed and normally listed in `/etc/shells`.

---

## 7. Create a basic Zsh script

Create a file:

```bash
nano hello.zsh
```

Add:

```zsh
#!/usr/bin/env zsh

# My first Zsh script

name="Khalid"

echo "Hello, $name"
echo "Zsh version: $ZSH_VERSION"
echo "Current shell process: $0"
```

Save the file and check its syntax:

```bash
zsh -n hello.zsh
```

No output normally means that no syntax error was found.

Add execute permission:

```bash
chmod u+x hello.zsh
```

Run it through its shebang:

```bash
./hello.zsh
```

Or explicitly give it to Zsh:

```bash
zsh hello.zsh
```

---

## 8. Understanding the shebang

The first line of a script is called the shebang:

```zsh
#!/usr/bin/env zsh
```

It tells Linux to find Zsh through `PATH` and use it to interpret the script.

Another valid form is:

```zsh
#!/usr/bin/zsh
```

The exact direct path can differ between systems. `#!/usr/bin/env zsh` is therefore often more portable.

The shebang is used when you execute the file directly:

```bash
./hello.zsh
```

If you name an interpreter yourself, that interpreter is used instead:

```bash
zsh hello.zsh
bash hello.zsh
```

Therefore, `bash hello.zsh` asks Bash to read the script even if its shebang names Zsh. Zsh-specific syntax may then fail.

---

## 9. Assign a shell while creating a user

Create a user with Bash:

```bash
sudo useradd -m -s /bin/bash student1
```

Create a user with Zsh:

```bash
sudo useradd -m -s /usr/bin/zsh student2
```

Use the actual path produced by this command:

```bash
command -v zsh
```

Verify the users:

```bash
getent passwd student1
getent passwd student2
```

The final field of each result shows the assigned login shell.

---

## 10. Beginner user-creation example with Bash

```bash
#!/bin/bash

# Create a user with Bash as the login shell

read -r -p "Enter username: " username

sudo useradd -m -s /bin/bash "$username" &&
echo "$username:$username@123" | sudo chpasswd &&
sudo chage -d 0 "$username" &&
id "$username" &&
getent passwd "$username" &&
echo "New user added: $username" ||
echo "User creation failed: $username"
```

To assign Zsh instead, change:

```bash
-s /bin/bash
```

to the installed Zsh path, for example:

```bash
-s /usr/bin/zsh
```

> **Lab safety:** The password in this example is predictable and visible in the script. Use it only in a disposable classroom lab. In a real environment, do not store plain-text passwords in scripts.

---

## 11. Useful verification commands

```bash
# List approved login shells
cat /etc/shells

# Find installed shell paths
command -v bash
command -v zsh

# Display the configured login shell
echo "$SHELL"

# Display the current shell process
echo "$0"

# Check a user's account entry and login shell
getent passwd "$USER"
getent passwd student1

# Display the Bash version
bash --version

# Display the Zsh version
zsh --version

# Check script syntax
bash -n script.sh
zsh -n script.zsh
```

---

## 12. Bash or Zsh—which should beginners learn first?

Start with Bash because it is widely used in Linux administration, cloud servers, automation, CI/CD, and DevOps environments.

After learning Bash fundamentals, explore Zsh to understand:

- Different interactive shell features.
- Shell customization.
- Shell-specific syntax.
- Why choosing the correct interpreter matters.

Remember: Bash and Zsh are similar, but they are not identical. A script written for one shell is not guaranteed to work correctly in another.

---

## 13. Hands-on practice tasks

1. Display the contents of `/etc/shells`.
2. Find the paths of Bash, Dash, and Zsh.
3. Display `$SHELL`, `$0`, and your `getent passwd` entry.
4. Start Zsh temporarily and verify it with `$0` and `$ZSH_VERSION`.
5. Exit Zsh and confirm that you returned to Bash.
6. Create and run `hello.zsh`.
7. Check `hello.zsh` with `zsh -n`.
8. Create a temporary lab user with Zsh as its login shell.
9. Confirm the user's shell with `getent passwd`.
10. Explain the difference between `./hello.zsh`, `zsh hello.zsh`, and `bash hello.zsh`.

---

## Quick summary

| Goal | Command |
|---|---|
| List login shells | `cat /etc/shells` |
| Find Zsh | `command -v zsh` |
| Enter Zsh temporarily | `zsh` |
| Leave the temporary shell | `exit` |
| Check current shell process | `echo "$0"` |
| Check configured login shell | `echo "$SHELL"` |
| Check shell in account database | `getent passwd "$USER"` |
| Change login shell to Zsh | `chsh -s "$(command -v zsh)"` |
| Return to Bash | `chsh -s /bin/bash` |
| Run a Zsh script | `zsh hello.zsh` |
| Check Zsh script syntax | `zsh -n hello.zsh` |
