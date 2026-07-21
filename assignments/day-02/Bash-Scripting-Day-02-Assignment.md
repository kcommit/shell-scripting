# Bash Scripting — Day 2 Assignment

## From Output and Variables to Safe User Creation

**Level:** Beginner  
**Estimated time:** 90–120 minutes  
**Total marks:** 100  
**Required environment:** WSL Ubuntu, Linux VM, or a disposable Linux lab machine

---

## Learning Objectives

After completing this assignment, the student should be able to:

- Write a properly documented Bash script.
- Explain the purpose of a shebang line.
- Use single-line comments and a multiline descriptive block.
- Store and expand Bash variables correctly.
- Accept and validate user input.
- Distinguish standard output from standard error.
- Interpret command exit statuses.
- Use `&&` and `||` for conditional command execution.
- Check whether a Linux user exists.
- Create a user safely and report the true result.

---

## Safety Rules

1. Perform the assignment only on WSL, a disposable VM, or an instructor-approved lab machine.
2. Do not test account-creation scripts on a production server.
3. The user-creation script must use dry-run mode by default.
4. Do not manually edit `/etc/passwd`, `/etc/shadow`, or `/etc/group`.
5. Do not place a plaintext password inside a script.
6. Do not delete existing users during this assignment.
7. Use `sudo` only for the final approved user-creation test.

---

## Required Directory Structure

Create the following structure:

```text
day-02/
├── README.md
├── greeting.sh
├── stream_demo.sh
├── directory_logic.sh
├── create_user_safe.sh
├── logs/
│   ├── greeting-output.txt
│   ├── stdout.log
│   ├── stderr.log
│   └── user-creation.log
└── evidence/
    ├── exit-status.txt
    ├── user-check.txt
    └── verification.txt
```

Create the directories:

```bash
mkdir -p day-02/{logs,evidence}
cd day-02
```

---

# Assignment Tasks

## Task 1 — Create and Document `greeting.sh` (10 Marks)

Create a script named `greeting.sh` containing:

- A Bash shebang.
- Script title.
- Author name.
- Date.
- Purpose.
- Usage example.
- At least three normal `#` comments.
- One multiline descriptive block.

The script must print:

```text
NIT: Hello Doston
Welcome to Bash Scripting Day 2
```

### Required verification

```bash
bash -n greeting.sh
bash greeting.sh
```

### Evidence

Save the output:

```bash
bash greeting.sh > logs/greeting-output.txt
```

---

## Task 2 — Variables and Safe Expansion (10 Marks)

Extend `greeting.sh` with the following variables:

- `institute`
- `course`
- `instructor`
- `student_name`

Requirements:

1. Assign values without spaces around `=`.
2. Print each value with a clear label.
3. Expand variables using `$variable` or `${variable}`.
4. Place variable expansions inside double quotes.
5. Add one example showing the difference between literal text and variable expansion.

Your output should clearly demonstrate why:

```bash
echo "Name is name"
```

is different from:

```bash
echo "Name is $name"
```

### Test requirement

Use at least one value containing a space, such as:

```text
Bash Scripting
```

---

## Task 3 — Accept and Validate User Input (15 Marks)

Modify `greeting.sh` to request the student's name interactively.

Requirements:

1. Display a clear prompt.
2. Store the input in a variable named `student_name`.
3. Use `read -r`.
4. Reject an empty name.
5. Send the empty-input error to standard error.
6. Return a nonzero exit status when validation fails.
7. Print the accepted name when validation succeeds.

Expected successful interaction:

```text
Enter your name: Ali
You entered: Ali
Welcome, Ali!
```

Expected empty-input behavior:

```text
Error: Name cannot be empty.
```

### Required tests

- A normal name
- A name containing a space
- Empty input

---

## Task 4 — Standard Output and Standard Error (15 Marks)

Create `stream_demo.sh` to demonstrate stdout and stderr.

The script must:

1. Print two normal informational messages to stdout.
2. Print two error messages to stderr.
3. Accept a directory path from the first positional argument.
4. Display the directory contents if the path exists.
5. Print an error to stderr if the directory does not exist.
6. Return exit status `0` for success and a nonzero status for failure.

### Required test commands

Run the script with an existing directory:

```bash
./stream_demo.sh /tmp
```

Run it with a missing directory:

```bash
./stream_demo.sh /missing
```

Separate the streams:

```bash
./stream_demo.sh /missing > logs/stdout.log 2> logs/stderr.log
```

Inspect the files:

```bash
cat logs/stdout.log
cat logs/stderr.log
```

### Question for `README.md`

Explain why standard output and standard error are kept as separate streams.

---

## Task 5 — Exit Status Investigation (10 Marks)

Run one successful command and one failing command.

Suggested commands:

```bash
ls /tmp
cd /missing
```

Immediately inspect `$?` after each command.

Record the following in `evidence/exit-status.txt`:

```text
Successful command:
Exit status:
Meaning:

Failing command:
Exit status:
Meaning:
```

### Required explanation

Answer these questions in `README.md`:

1. What does exit status `0` normally mean?
2. What does a nonzero exit status normally mean?
3. Why must `$?` be checked immediately?
4. Can different commands use different nonzero status values?

---

## Task 6 — Use `&&` and `||` (10 Marks)

Create `directory_logic.sh`.

The script must:

1. Accept a directory name as an argument.
2. Reject a missing argument.
3. Create the directory if it does not exist.
4. Enter the directory only after successful creation.
5. Print a fallback error when creation or navigation fails.
6. Use both `&&` and `||` meaningfully.

Test the success pattern:

```bash
mkdir d1 && cd d1
```

Test the fallback pattern:

```bash
cd /missing || cd d1
```

### Required explanation

Write one sentence for each:

- `command1 && command2`
- `command1 || command2`

---

## Task 7 — Build `create_user_safe.sh` (20 Marks)

Create a safer version of the user-creation script.

### Required behavior

1. Include a shebang and documentation header.
2. Accept a username through `read -r -p`.
3. Reject empty input.
4. Accept only usernames matching this simplified lab rule:

   ```text
   Starts with a lowercase letter and contains only lowercase letters, numbers, underscores, or hyphens.
   ```

5. Check whether the account already exists using:

   ```bash
   getent passwd "$username"
   ```

6. Do not call `useradd` if the account already exists.
7. Use dry-run mode by default and print the command that would run.
8. Perform real creation only when the script receives `--apply`.
9. Quote `"$username"` everywhere it is expanded.
10. Print “New user added” only when `useradd` succeeds.
11. Print failures to stderr.
12. Record actions in `logs/user-creation.log`.

### Required usage design

```bash
./create_user_safe.sh
./create_user_safe.sh --apply
./create_user_safe.sh --help
```

### Required test cases

| Test | Example | Expected behavior |
|---|---|---|
| Empty input | Press Enter | Reject input |
| Invalid uppercase | `Ali` | Reject input |
| Invalid space | `test user` | Reject input |
| Existing account | `root` or your username | Report that it already exists |
| New account in dry-run | `student02` | Show proposed action without creating it |
| New account with approval | `student02` and `--apply` | Create and verify the user |

> Obtain instructor approval before running the `--apply` test.

### Important correction

This pattern is incorrect:

```bash
sudo useradd -m "$username"
echo "New user added $username"
```

The message runs even when `useradd` fails. Your script must connect the message to actual success by checking the exit status, using an `if` statement, or using `&&`.

---

## Task 8 — Verify the User and Complete the Report (10 Marks)

After an approved account-creation test, verify the account using:

```bash
id student02
getent passwd student02
```

Save the evidence:

```bash
{
    id student02
    getent passwd student02
} > evidence/user-check.txt
```

Do not use only this command:

```bash
grep ali /etc/passwd
```

It can also match other usernames containing the same letters, such as `khalid`. Prefer an exact account query with `getent passwd USERNAME`.

Create `evidence/verification.txt` containing the results of:

```bash
bash -n greeting.sh stream_demo.sh directory_logic.sh create_user_safe.sh

./greeting.sh >/dev/null
echo "greeting.sh exit status: $?"

./stream_demo.sh /tmp >/dev/null
echo "stream_demo.sh exit status: $?"
```

---

# Final Verification Checklist

- [ ] All four scripts exist.
- [ ] Every script has a Bash shebang.
- [ ] Every script contains a documentation header.
- [ ] Variable assignments contain no spaces around `=`.
- [ ] Variable expansions are quoted.
- [ ] Interactive input uses `read -r`.
- [ ] Empty input is rejected.
- [ ] Error messages use stderr.
- [ ] Exit statuses are checked immediately.
- [ ] `&&` and `||` are used correctly.
- [ ] Existing users are detected before `useradd`.
- [ ] Dry-run is the default behavior.
- [ ] Success is printed only after real success.
- [ ] `bash -n` reports no syntax errors.
- [ ] Required logs and evidence files are included.

---

# Submission Requirements

Submit the complete `day-02` directory containing:

```text
README.md
greeting.sh
stream_demo.sh
directory_logic.sh
create_user_safe.sh
logs/
evidence/
```

Before submission:

```bash
find . -maxdepth 3 -type f -print
bash -n ./*.sh
```

Create an archive:

```bash
cd ..
tar -czf bash-day-02-assignment.tar.gz day-02/
```

---

# Grading Rubric

| Area | Marks |
|---|---:|
| Task 1 — Script structure and documentation | 10 |
| Task 2 — Variables and safe expansion | 10 |
| Task 3 — Input and validation | 15 |
| Task 4 — stdout and stderr | 15 |
| Task 5 — Exit-status investigation | 10 |
| Task 6 — `&&` and `||` logic | 10 |
| Task 7 — Safe user-creation script | 20 |
| Task 8 — Verification and evidence | 10 |
| **Total** | **100** |

## Quality Deductions

The instructor may deduct marks for:

- Unquoted variable expansions
- Misleading success messages
- Missing input validation
- Missing evidence
- Hard-coded passwords
- Editing protected account files manually
- Testing destructive operations outside the approved lab

---

# Bonus Challenge — 10 Extra Marks

Add the following optional features to `create_user_safe.sh`:

1. Accept the username through `--username NAME` as an alternative to interactive input.
2. Add `--shell /bin/bash` with `/bin/bash` as the safe default.
3. Add a timestamp to every log entry.
4. Display the created UID and home directory after successful verification.
5. Return a different documented exit status for invalid input, existing user, permission failure, and creation failure.

Document every bonus option in the script's `--help` output and in `README.md`.

---

## Suggested Git Commit

```bash
git add day-02/
git commit -m "Complete Bash Day 2 output variables and user creation assignment"
```

---

**Core lesson:** Never trust a success message by itself. Validate the input, run the command, inspect its status, verify the result, and then report success.
