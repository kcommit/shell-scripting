# Bash Conditionals Lab 

## Six simple tasks

## Objective

Learn Bash conditionals with simple fruit examples.

Each task adds only one small new idea.

## What is a conditional?

A conditional helps a script make a decision.

Example idea:

```text
If the fruit is apple, display "You chose apple."
```

In Bash, we can write:

```bash
if [ "$fruit" = "apple" ]
then
    echo "You chose apple"
fi
```

## Important words

| Word | Simple meaning |
|---|---|
| `if` | Check a condition |
| `then` | Run these commands when the condition is true |
| `elif` | Check another condition |
| `else` | Run when the earlier conditions are false |
| `fi` | End the conditional |

`fi` is `if` written backwards.

## Lab rules

Use only:

- `#!/bin/bash`
- Comments
- `echo`
- Variables and arguments
- `if`, `elif`, `else`, and `fi`
- `[ ]` and `[[ ]]`

Do not use:

- Functions
- Loops
- Arrays
- `case`

## Spacing rule

Spaces inside `[ ]` are required.

Correct:

```bash
[ "$fruit" = "apple" ]
```

Incorrect:

```bash
["$fruit"="apple"]
```

---

# Task 1 — Your First `if`

## Create

```text
task1.sh
```

## Run

```bash
bash task1.sh apple
```

## Your work

1. Store `$1` in a variable named `fruit`.
2. Use `if` to check whether the fruit is `apple`.
3. If it is `apple`, display:

   ```text
   You chose apple
   ```

4. End the condition with `fi`.

Expected output:

```text
You chose apple
```

Try:

```bash
bash task1.sh banana
```

This time, the script should display nothing because there is no `else` yet.

**New idea:** `if` runs a command only when a condition is true.

---

# Task 2 — Add `else`

## Create

```text
task2.sh
```

## Run Test 1

```bash
bash task2.sh apple
```

Expected output:

```text
You chose apple
```

## Run Test 2

```bash
bash task2.sh banana
```

Expected output:

```text
You did not choose apple
```

## Your work

1. Store `$1` in `fruit`.
2. If `fruit` is `apple`, display `You chose apple`.
3. Otherwise, use `else` to display `You did not choose apple`.
4. End with `fi`.

**New idea:** `else` runs when the `if` condition is false.

---

# Task 3 — Add `elif`

## Create

```text
task3.sh
```

## Your work

Check three choices:

1. If the fruit is `apple`, display `Apple selected`.
2. Else if the fruit is `banana`, display `Banana selected`.
3. Otherwise, display `Another fruit selected`.

## Test 1

```bash
bash task3.sh apple
```

Expected output:

```text
Apple selected
```

## Test 2

```bash
bash task3.sh banana
```

Expected output:

```text
Banana selected
```

## Test 3

```bash
bash task3.sh cherry
```

Expected output:

```text
Another fruit selected
```

**New idea:** `elif` checks another condition when the first condition is false.

---

# Task 4 — Check a Number

## Create

```text
task4.sh
```

## Your work

1. Store `$1` in a variable named `fruit_count`.
2. Use `-eq` to check whether the number is equal to `3`.
3. If it is `3`, display `The basket has three fruits`.
4. Otherwise, display `The basket does not have three fruits`.

## Test 1

```bash
bash task4.sh 3
```

Expected output:

```text
The basket has three fruits
```

## Test 2

```bash
bash task4.sh 5
```

Expected output:

```text
The basket does not have three fruits
```

**New idea:** `-eq` means numerically equal.

---

# Task 5 — Small, Medium, or Large Basket

## Create

```text
task5.sh
```

## Your work

Store `$1` in `fruit_count`, then classify the basket:

1. If the number is greater than `5`, display `Large basket`.
2. Else if the number is equal to `5`, display `Medium basket`.
3. Otherwise, display `Small basket`.

Use:

- `-gt` for greater than
- `-eq` for equal

## Test 1

```bash
bash task5.sh 8
```

Expected output:

```text
Large basket
```

## Test 2

```bash
bash task5.sh 5
```

Expected output:

```text
Medium basket
```

## Test 3

```bash
bash task5.sh 2
```

Expected output:

```text
Small basket
```

**New idea:** Conditions can classify numbers into different groups.

---

# Task 6 — Use Double Brackets `[[ ]]`

## Create

```text
task6.sh
```

## Your work

1. Store `$1` in `fruit`.
2. Use `[[ ]]` to check whether the fruit is `green apple`.
3. If it matches, display `Green apple selected`.
4. Otherwise, display `Different fruit selected`.

## Test 1

```bash
bash task6.sh "green apple"
```

Expected output:

```text
Green apple selected
```

## Test 2

```bash
bash task6.sh banana
```

Expected output:

```text
Different fruit selected
```

Remember that `"green apple"` needs quotes because it contains a space.

**New idea:** Bash also provides `[[ condition ]]` for testing conditions.

---

# Final Practice

Run all six scripts:

```bash
bash task1.sh apple
bash task2.sh banana
bash task3.sh cherry
bash task4.sh 3
bash task5.sh 8
bash task6.sh "green apple"
```

# Syntax Check

```bash
bash -n task1.sh
bash -n task2.sh
bash -n task3.sh
bash -n task4.sh
bash -n task5.sh
bash -n task6.sh
```

No output means Bash found no syntax errors.

# Make the Scripts Executable

```bash
chmod u+x task1.sh
chmod u+x task2.sh
chmod u+x task3.sh
chmod u+x task4.sh
chmod u+x task5.sh
chmod u+x task6.sh
```

Now you can run a script with `./`:

```bash
./task3.sh banana
```

# Quick Revision

## String comparison

| Operator | Meaning |
|---|---|
| `=` | Equal strings |
| `!=` | Strings are not equal |

## Number comparison

| Operator | Meaning |
|---|---|
| `-eq` | Equal |
| `-ne` | Not equal |
| `-gt` | Greater than |
| `-ge` | Greater than or equal |
| `-lt` | Less than |
| `-le` | Less than or equal |

## Conditional words

| Word | Meaning |
|---|---|
| `if` | Check the first condition |
| `elif` | Check another condition |
| `else` | Run when the conditions are false |
| `fi` | End the conditional |

# Student Questions

1. What does `if` do?
2. What does `else` do?
3. What does `elif` do?
4. Why do we write `fi`?
5. What does `=` compare?
6. What does `-eq` mean?
7. What does `-gt` mean?
8. Why does `"green apple"` need quotes?
9. Why are spaces required inside `[ ]`?
10. What is one difference between `[ ]` and `[[ ]]`?

# Student Submission

Submit these files:

```text
conditionals-baby-steps/
├── task1.sh
├── task2.sh
├── task3.sh
├── task4.sh
├── task5.sh
└── task6.sh
```

# Completion Checklist

- [ ] Every script starts with `#!/bin/bash`.
- [ ] Every script contains a comment.
- [ ] Task 1 uses `if` and `fi`.
- [ ] Task 2 uses `if`, `else`, and `fi`.
- [ ] Task 3 uses `if`, `elif`, `else`, and `fi`.
- [ ] Task 4 uses `-eq`.
- [ ] Task 5 uses `-gt` and `-eq`.
- [ ] Task 6 uses `[[ ]]`.
- [ ] All tests show the expected output.
- [ ] `bash -n` reports no syntax errors.

# Safety

This lab only displays fruit names and basket sizes. It does not create users, delete files, use `sudo`, or connect to another machine.
