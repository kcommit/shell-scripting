# Linux Shells and No-Login Users 

This combined guide covers Login Shells, Non-Login Shells, and No-Login Users for Linux, RHCSA, and DevOps studies.

## Shell Startup Files or Shell Initialization Files.

| File              | Called                               |
| ----------------- | ------------------------------------ |
| `/etc/profile`    | System-wide Login Shell Startup File |
| `~/.bash_profile` | User Login Shell Startup File        |
| `~/.bash_login`   | User Login Shell Startup File        |
| `~/.profile`      | User Login Shell Startup File        |
| `~/.bashrc`       | User Non-Login Shell Startup File    |


## Definition
Shell Startup Files are configuration files that are executed automatically when a shell starts.

## Two Main Categories
1. Login Shell Startup Files

Executed when a user logs in:
```text
/etc/profile
~/.bash_profile
~/.bash_login
~/.profile
```

2. Non-Login Shell Startup Files

Executed when a new shell starts after login:
```text
~/.bashrc
```

## Order Bash Checks During Login
```text
1. /etc/profile
        ↓
2. ~/.bash_profile
        OR
   ~/.bash_login
        OR
   ~/.profile
```
Bash stops at the first file it finds among:
```text
~/.bash_profile → ~/.bash_login → ~/.profile
```

## Login Shell
A login shell starts when a user logs into the system (SSH, console login, su - user).

Files read:
- /etc/profile
- ~/.bash_profile
- ~/.bash_login
- ~/.profile

## Non-Login Shell
A non-login shell starts after login (bash, sh, new terminal sessions).

Files read:
- ~/.bashrc

## Comparison
- Login Shell: Reads profile files.
- Non-Login Shell: Reads ~/.bashrc.


# No Login User in Linux

## Introduction

A No Login User is a Linux user account that exists on the system but cannot log in interactively through SSH, console, or terminal sessions.

These accounts are commonly used for:

- System services
- Applications
- Daemons
- Security purposes

---

# What is a No Login Shell?

A No Login Shell prevents a user from obtaining an interactive shell session.

Common no-login shells:

```text
/usr/sbin/nologin
/sbin/nologin
```

---

# Create a User with No Login Shell

Ubuntu:

```bash
sudo useradd -s /usr/sbin/nologin appuser
```

RHEL/Rocky Linux:

```bash
sudo useradd -s /sbin/nologin appuser
```

---

# Command Breakdown

| Option | Meaning |
|----------|----------|
| useradd | Create a new user |
| -s | Specify login shell |
| /usr/sbin/nologin | Disable interactive login |
| appuser | Username |

---

# Verify the User

Check the user entry:

```bash
grep appuser /etc/passwd
```

Example:

```text
appuser:x:1001:1001::/home/appuser:/usr/sbin/nologin
```

Notice:

```text
/usr/sbin/nologin
```

This is the assigned shell.

---

# Test Login

Attempt to switch users:

```bash
su - appuser
```

Output:

```text
This account is currently not available.
```

---

# SSH Login Attempt

```bash
ssh appuser@server
```

Possible output:

```text
This account is currently not available.
```

or

```text
Connection closed.
```

---

# What Can the User Do?

A no-login user can:

- Own files
- Run services
- Have a UID and GID
- Be used by applications

A no-login user cannot:

- SSH login
- Interactive shell login
- Run commands through a shell session

---

# Real World Examples

View service accounts:

```bash
grep nologin /etc/passwd
```

Example:

```text
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
mysql:x:110:115:MySQL Server:/nonexistent:/usr/sbin/nologin
```

These accounts run services but are not meant for human login.

---

# No Login vs Normal User

| Feature | Normal User | No Login User |
|----------|------------|---------------|
| SSH Login | Yes | No |
| Interactive Shell | Yes | No |
| Own Files | Yes | Yes |
| Run Services | Yes | Yes |
| Used by Applications | Yes | Yes |

---

# RHCSA Example

Create user sarah with no login shell:

```bash
sudo useradd -s /sbin/nologin sarah
```

Verify:

```bash
grep sarah /etc/passwd
```

Output:

```text
sarah:x:1005:1005::/home/sarah:/sbin/nologin
```

---

# Related Commands

Check available shells:

```bash
cat /etc/shells
```

Check user information:

```bash
id appuser
```

Check user entry:

```bash
grep appuser /etc/passwd
```

---

# Interview Questions

## What is a no-login user?

A no-login user is an account that exists on the system but cannot obtain an interactive shell because its login shell is set to nologin.

## Why are no-login users used?

They are used for services and applications to improve security by preventing direct user logins.

---

# Roman Urdu Summary

- No login user system mein mojood hota hai.
- User files own kar sakta hai.
- Services chala sakta hai.
- SSH login nahi kar sakta.
- Terminal shell access nahi milti.
- Security ke liye use kiya jata hai.

---

# Quick Memory Trick

```text
/bin/bash = Login Allowed

/usr/sbin/nologin = Login Not Allowed
```

---

# Conclusion

No-login users are commonly used for services, applications, and system accounts. They improve security by preventing interactive logins while still allowing the account to own files and run processes.
