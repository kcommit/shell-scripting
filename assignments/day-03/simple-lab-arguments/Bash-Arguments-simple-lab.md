# Bash Arguments Lab 

## Six simple tasks

## Objective

Learn Bash arguments with the simple examples `apple`, `banana`, and `cherry`.

Each task adds only one small new idea.

## What is an argument?

An **argument** is a value written after a script name.

```bash
./fruit.sh apple
```

In this command:

- `./fruit.sh` is the script name.
- `apple` is the first argument.
- Inside the script, `$1` contains `apple`.

## What can we use?

Use only:

- `#!/bin/bash`
- Comments
- `echo`
- Simple variables
- `$0`, `$1`, `$2`, `$3`, `$#`, and `"$@"`

Do not use:

- Conditions
- Functions
- Loops
- Arrays
- `case`

---

# Task 1 — One Fruit

## Create

```text
task1.sh
```

## Run

```bash
bash task1.sh apple
```

## Your work

1. Start the script with `#!/bin/bash`.
2. Add this comment:

   ```bash
   # Show one fruit
   ```

3. Use `$1` to display the first fruit.

Expected output:

```text
First fruit: apple
```

Try another fruit:

```bash
bash task1.sh mango
```

Expected output:

```text
First fruit: mango
```

**New idea:** `$1` contains the first argument.

---

# Task 2 — Two Fruits

## Create

```text
task2.sh
```

## Run

```bash
bash task2.sh apple banana
```

## Your work

1. Use `$1` to display the first fruit.
2. Use `$2` to display the second fruit.

Expected output:

```text
First fruit: apple
Second fruit: banana
```

Change the order:

```bash
bash task2.sh banana apple
```

Expected output:

```text
First fruit: banana
Second fruit: apple
```

**New idea:** `$2` contains the second argument.

---

# Task 3 — Three Fruits

## Create

```text
task3.sh
```

## Run

```bash
bash task3.sh apple banana cherry
```

## Your work

1. Use `$1` to display `apple`.
2. Use `$2` to display `banana`.
3. Use `$3` to display `cherry`.

Expected output:

```text
Fruit 1: apple
Fruit 2: banana
Fruit 3: cherry
```

Try different fruits:

```bash
bash task3.sh mango orange grapes
```

Expected output:

```text
Fruit 1: mango
Fruit 2: orange
Fruit 3: grapes
```

**New idea:** `$3` contains the third argument.

---

# Task 4 — Put Arguments in Variables

## Create

```text
task4.sh
```

## Run

```bash
bash task4.sh apple banana cherry
```

## Your work

Store the three arguments in variables:

```text
$1 goes into first_fruit
$2 goes into second_fruit
$3 goes into third_fruit
```

Then use `echo` to display the variables.

Expected output:

```text
First fruit: apple
Second fruit: banana
Third fruit: cherry
```

## Important variable rule

Do not put spaces around `=`.

Correct:

```bash
first_fruit="$1"
```

Incorrect:

```bash
first_fruit = "$1"
```

**New idea:** An argument can be stored in a variable with a clear name.

---

# Task 5 — Count All Fruits

## Create

```text
task5.sh
```

## Run

```bash
bash task5.sh apple banana cherry
```

## Your work

Display:

1. The script name using `$0`.
2. The number of fruits using `$#`.
3. All fruits using `"$@"`.

Expected output:

```text
Script name: task5.sh
Number of fruits: 3
All fruits: apple banana cherry
```

The script name may include a path, depending on how you run it.

Now give five fruits:

```bash
bash task5.sh apple banana cherry mango orange
```

Expected output:

```text
Script name: task5.sh
Number of fruits: 5
All fruits: apple banana cherry mango orange
```

**New ideas:**

- `$0` contains the script name.
- `$#` contains the number of arguments.
- `"$@"` contains all arguments.

---

# Task 6 — A Fruit Name with a Space

## Create

```text
task6.sh
```

## Run

```bash
bash task6.sh apple "green banana" cherry
```

## Your work

Display:

1. The first fruit using `$1`.
2. The second fruit using `$2`.
3. The third fruit using `$3`.
4. The number of fruits using `$#`.
5. All fruits using `"$@"`.

Expected output:

```text
First fruit: apple
Second fruit: green banana
Third fruit: cherry
Number of fruits: 3
All fruits: apple green banana cherry
```

`"green banana"` is one argument because it is inside quotes.

Now run it without quotes:

```bash
bash task6.sh apple green banana cherry
```

Look at the result. Bash now receives four arguments:

```text
$1 = apple
$2 = green
$3 = banana
$4 = cherry
$# = 4
```

**New idea:** Quotes keep words with spaces together as one argument.

---

# Final Practice

Run all six scripts in order:

```bash
bash task1.sh apple
bash task2.sh apple banana
bash task3.sh apple banana cherry
bash task4.sh apple banana cherry
bash task5.sh apple banana cherry
bash task6.sh apple "green banana" cherry
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
./task3.sh apple banana cherry
```

# Quick Revision

| Symbol | Simple meaning |
|---|---|
| `$0` | Script name |
| `$1` | First fruit |
| `$2` | Second fruit |
| `$3` | Third fruit |
| `$#` | Number of fruits given |
| `"$@"` | All fruits given |

# Student Questions

1. What does `$1` contain?
2. What does `$2` contain?
3. What does `$3` contain?
4. What does `$0` show?
5. What does `$#` show?
6. What does `"$@"` show?
7. Why is `"green banana"` one argument?
8. Why must a variable assignment have no spaces around `=`?

# Student Submission

Submit these files:

```text
arguments-baby-steps/
├── task1.sh
├── task2.sh
├── task3.sh
├── task4.sh
├── task5.sh
└── task6.sh
```

# Completion Checklist

- [ ] Every script starts with `#!/bin/bash`.
- [ ] Every script has a comment.
- [ ] Task 1 uses `$1`.
- [ ] Task 2 uses `$1` and `$2`.
- [ ] Task 3 uses `$1`, `$2`, and `$3`.
- [ ] Task 4 stores arguments in variables.
- [ ] Task 5 uses `$0`, `$#`, and `"$@"`.
- [ ] Task 6 keeps `"green banana"` as one argument.
- [ ] All six scripts run correctly.
- [ ] `bash -n` reports no syntax errors.

# Safety

This lab only displays fruit names. It does not create users, delete files, use `sudo`, or connect to another machine.
