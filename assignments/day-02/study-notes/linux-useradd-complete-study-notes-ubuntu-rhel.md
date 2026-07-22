# Linux `useradd` Command Study Notes

## Complete Guide for Ubuntu and RHEL/Rocky Linux

These notes cover the `useradd` command with different options using the username **ali**.

This guide is useful for:

- Linux Administration
- RHCSA Preparation
- DevOps Practice
- Cloud Server Management
- Interview Preparation

---

# Table of Contents

1. What is `useradd`?
2. Difference Between `useradd` and `adduser`
3. Important User Files
4. Basic User Creation
5. Create User With Home Directory
6. Create User Without Home Directory
7. Create User With Custom Home Directory
8. Create User With Specific Shell
9. Create User With No-Login Shell
10. Create User With Expire Date
11. Create User With No Expiry
12. Force User to Change Password at First Login
13. Password Aging with `chage`
14. Create User With UID
15. Create User With Primary Group
16. Create User With Supplementary Groups
17. Lock and Unlock User
18. Verify User Information
19. Delete User
20. Ubuntu vs RHEL Differences
21. RHCSA-Style Practice Tasks
22. Interview Questions
23. Roman Urdu Summary
24. Quick Memory Tricks

---

# 1. What is `useradd`?

`useradd` is a Linux command used to create a new user account.

Basic syntax:

```bash
sudo useradd [options] username
```

Example:

```bash
sudo useradd ali
```

This creates a user named `ali`.

---

# 2. Difference Between `useradd` and `adduser`

## `useradd`

`useradd` is a low-level Linux command.

It usually needs options such as `-m`, `-s`, `-G`, etc.

Example:

```bash
sudo useradd -m ali
```

## `adduser`

`adduser` is more user-friendly and interactive, especially on Ubuntu.

Example:

```bash
sudo adduser ali
```

It asks for password and user information interactively.

| Command | Type | Common In |
|----------|------|-----------|
| `useradd` | Low-level command | Ubuntu, RHEL, Rocky, CentOS |
| `adduser` | Friendly interactive command | Ubuntu/Debian |

---

# 3. Important User Files

Linux stores user information in important files.

| File | Purpose |
|------|---------|
| `/etc/passwd` | Stores user account information |
| `/etc/shadow` | Stores encrypted password and password aging information |
| `/etc/group` | Stores group information |
| `/etc/gshadow` | Stores secure group information |
| `/etc/default/useradd` | Default settings for `useradd` |
| `/etc/login.defs` | Login and password policy settings |
| `/etc/skel/` | Default files copied to new user's home directory |

Check user entry:

```bash
grep ali /etc/passwd
```

Check password aging:

```bash
sudo grep ali /etc/shadow
```

Check group entry:

```bash
grep ali /etc/group
```

---

# 4. Basic User Creation

## Command

```bash
sudo useradd ali
```

## Explanation

This creates the user `ali`.

Depending on your Linux distribution and configuration, this may or may not create a home directory automatically.

## Verify

```bash
id ali
```

```bash
grep ali /etc/passwd
```

Example output:

```text
ali:x:1001:1001::/home/ali:/bin/sh
```

or:

```text
ali:x:1001:1001::/home/ali:/bin/bash
```

---

# 5. Create User With Home Directory

## Ubuntu and RHEL/Rocky

```bash
sudo useradd -m ali
```

## Meaning

`-m` means create the user's home directory.

Home directory:

```text
/home/ali
```

## Verify

```bash
ls -ld /home/ali
```

```bash
grep ali /etc/passwd
```

Expected:

```text
/home/ali
```

---

# 6. Create User Without Home Directory

## Command

```bash
sudo useradd -M ali
```

## Meaning

`-M` means do not create a home directory.

## Verify

```bash
ls -ld /home/ali
```

If no home directory exists, you may see:

```text
No such file or directory
```

Check `/etc/passwd`:

```bash
grep ali /etc/passwd
```

It may still show `/home/ali` as the home path, but the actual directory may not exist.

---

# 7. Create User With Custom Home Directory

## Command

```bash
sudo useradd -m -d /data/ali ali
```

## Meaning

| Option | Meaning |
|--------|---------|
| `-m` | Create home directory |
| `-d /data/ali` | Set custom home directory |
| `ali` | Username |

## Verify

```bash
grep ali /etc/passwd
```

```bash
ls -ld /data/ali
```

Expected:

```text
/data/ali
```

---

# 8. Create User With Specific Shell

## Bash Shell

```bash
sudo useradd -m -s /bin/bash ali
```

## Explanation

`-s` specifies the login shell.

## Verify

```bash
grep ali /etc/passwd
```

Example:

```text
ali:x:1001:1001::/home/ali:/bin/bash
```

---

# 9. Create User With No-Login Shell

A no-login shell creates a user account that exists, but the user cannot log in interactively.

This is common for service accounts.

---

## Ubuntu

```bash
sudo useradd -m -s /usr/sbin/nologin ali
```

## RHEL / Rocky Linux

```bash
sudo useradd -m -s /sbin/nologin ali
```

## Verify

```bash
grep ali /etc/passwd
```

Ubuntu example:

```text
ali:x:1001:1001::/home/ali:/usr/sbin/nologin
```

RHEL example:

```text
ali:x:1001:1001::/home/ali:/sbin/nologin
```

## Test Login

```bash
su - ali
```

Expected output:

```text
This account is currently not available.
```

## Important Note

The user can still:

- Own files
- Run services
- Have UID/GID
- Be used by applications

The user cannot:

- SSH login
- Open interactive shell
- Use terminal as normal user

---

# 10. Create User With Expire Date

## Command

```bash
sudo useradd -m -e 2026-12-31 ali
```

## Meaning

`-e` sets account expiration date.

After this date, the account becomes expired.

## Verify

```bash
sudo chage -l ali
```

Look for:

```text
Account expires : Dec 31, 2026
```

---

# 11. Create User With No Expiry

## Create user normally

```bash
sudo useradd -m ali
```

## Set account to never expire

```bash
sudo chage -E -1 ali
```

## Verify

```bash
sudo chage -l ali
```

Expected:

```text
Account expires : never
```

---

# 12. Force User to Change Password at First Login

This is very important in real-world administration.

## Step 1: Create user

```bash
sudo useradd -m -s /bin/bash ali
```

## Step 2: Set temporary password

```bash
sudo passwd ali
```

Enter temporary password.

## Step 3: Force password change at first login

```bash
sudo chage -d 0 ali
```

## Meaning

`-d 0` means last password change date is set to zero, so Linux forces the user to change password at first login.

## Verify

```bash
sudo chage -l ali
```

You should see password change required.

## Test

Login as `ali`:

```bash
su - ali
```

The system should ask the user to change password.

---

# 13. Password Aging With `chage`

The `chage` command manages password expiration and aging.

## Show password aging info

```bash
sudo chage -l ali
```

---

## Set Maximum Password Age

```bash
sudo chage -M 90 ali
```

Meaning:

```text
Password must be changed after 90 days.
```

---

## Set Minimum Password Age

```bash
sudo chage -m 7 ali
```

Meaning:

```text
User cannot change password again for 7 days.
```

---

## Set Warning Days

```bash
sudo chage -W 7 ali
```

Meaning:

```text
Warn user 7 days before password expires.
```

---

## Set Password Inactive Days

```bash
sudo chage -I 10 ali
```

Meaning:

```text
After password expires, account becomes inactive after 10 days.
```

---

## Disable Password Expiration

```bash
sudo chage -M -1 ali
```

Meaning:

```text
Password never expires.
```

---

## Set Account Expiry Date

```bash
sudo chage -E 2026-12-31 ali
```

---

## Remove Account Expiry

```bash
sudo chage -E -1 ali
```

---

# 14. Create User With Specific UID

## Command

```bash
sudo useradd -m -u 2001 ali
```

## Meaning

`-u 2001` sets UID to 2001.

## Verify

```bash
id ali
```

Expected:

```text
uid=2001(ali)
```

---

# 15. Create User With Primary Group

## Step 1: Create group

```bash
sudo groupadd developers
```

## Step 2: Create user with primary group

```bash
sudo useradd -m -g developers ali
```

## Verify

```bash
id ali
```

Expected:

```text
gid=...(developers)
```

---

# 16. Create User With Supplementary Groups

## Ubuntu admin group

Ubuntu uses the `sudo` group for admin privileges.

```bash
sudo useradd -m -G sudo ali
```

## RHEL/Rocky admin group

RHEL/Rocky uses the `wheel` group for sudo privileges.

```bash
sudo useradd -m -G wheel ali
```

## Multiple supplementary groups

```bash
sudo useradd -m -G developers,docker ali
```

## Verify

```bash
id ali
```

---

# 17. Lock and Unlock User

## Lock user

```bash
sudo usermod -L ali
```

This locks the password.

## Unlock user

```bash
sudo usermod -U ali
```

## Verify in `/etc/shadow`

```bash
sudo grep ali /etc/shadow
```

A locked password often has `!` before the password hash.

---

# 18. Verify User Information

Use these commands after creating or modifying users.

## Check UID, GID, and groups

```bash
id ali
```

## Check `/etc/passwd`

```bash
grep ali /etc/passwd
```

## Check `/etc/shadow`

```bash
sudo grep ali /etc/shadow
```

## Check password aging

```bash
sudo chage -l ali
```

## Check home directory

```bash
ls -ld /home/ali
```

## Check login shell

```bash
getent passwd ali
```

---

# 19. Delete User

## Delete user only

```bash
sudo userdel ali
```

This removes the user account but may leave the home directory.

## Delete user with home directory

```bash
sudo userdel -r ali
```

This removes:

- User account
- Home directory
- Mail spool if present

## Verify

```bash
id ali
```

Expected:

```text
no such user
```

---

# 20. Ubuntu vs RHEL/Rocky Differences

| Topic | Ubuntu | RHEL/Rocky |
|-------|--------|------------|
| Friendly user creation | `adduser ali` | Usually `useradd -m ali` |
| Low-level command | `useradd` | `useradd` |
| No-login shell | `/usr/sbin/nologin` | `/sbin/nologin` |
| Admin group | `sudo` | `wheel` |
| Package manager | `apt` | `dnf` / `yum` |
| Password aging command | `chage` | `chage` |
| User file | `/etc/passwd` | `/etc/passwd` |
| Shadow file | `/etc/shadow` | `/etc/shadow` |

---

# 21. RHCSA-Style Practice Tasks

## Task 1: Create Basic User

Create user `ali`.

```bash
sudo useradd ali
id ali
```

---

## Task 2: Create User With Home Directory

```bash
sudo useradd -m ali
ls -ld /home/ali
```

---

## Task 3: Create User Without Home Directory

```bash
sudo useradd -M ali
ls -ld /home/ali
```

---

## Task 4: Create User With Custom Home Directory

```bash
sudo useradd -m -d /data/ali ali
grep ali /etc/passwd
```

---

## Task 5: Create User With Bash Shell

```bash
sudo useradd -m -s /bin/bash ali
grep ali /etc/passwd
```

---

## Task 6: Create User With No-Login Shell

Ubuntu:

```bash
sudo useradd -m -s /usr/sbin/nologin ali
```

RHEL:

```bash
sudo useradd -m -s /sbin/nologin ali
```

Test:

```bash
su - ali
```

---

## Task 7: Create User With Expiry Date

```bash
sudo useradd -m -e 2026-12-31 ali
sudo chage -l ali
```

---

## Task 8: Force Password Change at First Login

```bash
sudo useradd -m ali
sudo passwd ali
sudo chage -d 0 ali
sudo chage -l ali
```

---

## Task 9: Set Password Policy

```bash
sudo chage -M 90 -m 7 -W 7 ali
sudo chage -l ali
```

---

## Task 10: Disable Password Expiry

```bash
sudo chage -M -1 ali
sudo chage -l ali
```

---

## Task 11: Create User With Specific UID

```bash
sudo useradd -m -u 2001 ali
id ali
```

---

## Task 12: Create User With Group

```bash
sudo groupadd developers
sudo useradd -m -g developers ali
id ali
```

---

## Task 13: Create User With Supplementary Groups

Ubuntu:

```bash
sudo useradd -m -G sudo ali
id ali
```

RHEL:

```bash
sudo useradd -m -G wheel ali
id ali
```

---

## Task 14: Lock and Unlock User

```bash
sudo usermod -L ali
sudo grep ali /etc/shadow

sudo usermod -U ali
sudo grep ali /etc/shadow
```

---

## Task 15: Delete User

```bash
sudo userdel -r ali
id ali
```

---

# 22. Interview Questions

## Q1: What is `useradd`?

`useradd` is a Linux command used to create user accounts.

---

## Q2: What is the difference between `useradd` and `adduser`?

`useradd` is a low-level command. `adduser` is a user-friendly interactive command commonly used in Ubuntu/Debian.

---

## Q3: How do you create user `ali` with home directory?

```bash
sudo useradd -m ali
```

---

## Q4: How do you create user `ali` without home directory?

```bash
sudo useradd -M ali
```

---

## Q5: How do you create user `ali` with no-login shell?

Ubuntu:

```bash
sudo useradd -s /usr/sbin/nologin ali
```

RHEL:

```bash
sudo useradd -s /sbin/nologin ali
```

---

## Q6: How do you force a user to change password at first login?

```bash
sudo chage -d 0 ali
```

---

## Q7: How do you set account expiry date?

```bash
sudo chage -E 2026-12-31 ali
```

or during creation:

```bash
sudo useradd -e 2026-12-31 ali
```

---

## Q8: How do you make account never expire?

```bash
sudo chage -E -1 ali
```

---

## Q9: How do you make password never expire?

```bash
sudo chage -M -1 ali
```

---

## Q10: How do you check user information?

```bash
id ali
grep ali /etc/passwd
sudo chage -l ali
```

---

# 23. Roman Urdu Summary

`useradd` Linux mein new user create karne ke liye use hota hai.

Basic command:

```bash
sudo useradd ali
```

Home directory ke sath user banana ho:

```bash
sudo useradd -m ali
```

Home directory ke baghair user banana ho:

```bash
sudo useradd -M ali
```

No-login shell ke sath user banana ho:

Ubuntu:

```bash
sudo useradd -s /usr/sbin/nologin ali
```

RHEL:

```bash
sudo useradd -s /sbin/nologin ali
```

Expire date set karni ho:

```bash
sudo useradd -e 2026-12-31 ali
```

First login par password change force karna ho:

```bash
sudo passwd ali
sudo chage -d 0 ali
```

Password kabhi expire na ho:

```bash
sudo chage -M -1 ali
```

Account kabhi expire na ho:

```bash
sudo chage -E -1 ali
```

User verify karne ke liye:

```bash
id ali
grep ali /etc/passwd
sudo chage -l ali
```

---

# 24. Quick Memory Tricks

```text
-m = Make home directory

-M = No home directory

-d = Define custom home directory

-s = Set shell

-e = Expire date

-u = UID

-g = Primary group

-G = Supplementary groups

chage -d 0 = Change password on first login

chage -M -1 = Password never expires

chage -E -1 = Account never expires
```

---

# 25. Recommended Practice Order

1. Create basic user
2. Create user with home directory
3. Create user without home directory
4. Create user with custom home directory
5. Create user with Bash shell
6. Create user with no-login shell
7. Create user with account expiry
8. Force first login password change
9. Set password aging
10. Disable password expiry
11. Add user to groups
12. Lock and unlock user
13. Delete user

---

# Conclusion

The `useradd` command is one of the most important Linux administration commands. It is frequently used in RHCSA exams, Linux admin tasks, DevOps server setup, and cloud server management.

Mastering `useradd`, `passwd`, `chage`, `usermod`, and `userdel` will make user management much easier in both Ubuntu and RHEL/Rocky Linux environments.
