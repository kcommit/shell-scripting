# Bash Arguments Lab 

This solution matches the six-task beginner lab.

## Important idea

Arguments are values written after a script name:

```bash
bash task1.sh apple
```

Here, `$1` contains `apple`.

---

# Task 1 Solution — One Fruit

File: `task1.sh`

```bash
#!/bin/bash

# Show one fruit

echo "First fruit: $1"
```

Run:

```bash
bash task1.sh apple
```

Output:

```text
First fruit: apple
```

`$1` contains the first argument.

---

# Task 2 Solution — Two Fruits

File: `task2.sh`

```bash
#!/bin/bash

# Show two fruits

echo "First fruit: $1"
echo "Second fruit: $2"
```

Run:

```bash
bash task2.sh apple banana
```

Output:

```text
First fruit: apple
Second fruit: banana
```

`$1` contains the first argument, and `$2` contains the second argument.

---

# Task 3 Solution — Three Fruits

File: `task3.sh`

```bash
#!/bin/bash

# Show three fruits

echo "Fruit 1: $1"
echo "Fruit 2: $2"
echo "Fruit 3: $3"
```

Run:

```bash
bash task3.sh apple banana cherry
```

Output:

```text
Fruit 1: apple
Fruit 2: banana
Fruit 3: cherry
```

`$3` contains the third argument.

---

# Task 4 Solution — Put Arguments in Variables

File: `task4.sh`

```bash
#!/bin/bash

# Store arguments in variables

first_fruit="$1"
second_fruit="$2"
third_fruit="$3"

echo "First fruit: $first_fruit"
echo "Second fruit: $second_fruit"
echo "Third fruit: $third_fruit"
```

Run:

```bash
bash task4.sh apple banana cherry
```

Output:

```text
First fruit: apple
Second fruit: banana
Third fruit: cherry
```

There are no spaces around `=` in a variable assignment.

Correct:

```bash
first_fruit="$1"
```

Incorrect:

```bash
first_fruit = "$1"
```

---

# Task 5 Solution — Count All Fruits

File: `task5.sh`

```bash
#!/bin/bash

# Show the script name, argument count, and all fruits

echo "Script name: $0"
echo "Number of fruits: $#"
echo "All fruits: $@"
```

Run:

```bash
bash task5.sh apple banana cherry
```

Output:

```text
Script name: task5.sh
Number of fruits: 3
All fruits: apple banana cherry
```

The script name can include a path, depending on how the script is run.

- `$0` contains the script name.
- `$#` contains the number of arguments.
- `"$@"` represents all arguments.

---

# Task 6 Solution — A Fruit Name with a Space

File: `task6.sh`

```bash
#!/bin/bash

# Show an argument that contains a space

echo "First fruit: $1"
echo "Second fruit: $2"
echo "Third fruit: $3"
echo "Number of fruits: $#"
echo "All fruits: $@"
```

Run:

```bash
bash task6.sh apple "green banana" cherry
```

Output:

```text
First fruit: apple
Second fruit: green banana
Third fruit: cherry
Number of fruits: 3
All fruits: apple green banana cherry
```

`"green banana"` is one argument because it is inside quotes.

Without quotes:

```bash
bash task6.sh apple green banana cherry
```

Bash receives four arguments:

```text
$1 = apple
$2 = green
$3 = banana
$4 = cherry
$# = 4
```

---

# Syntax Check

Check all scripts:

```bash
bash -n task1.sh
bash -n task2.sh
bash -n task3.sh
bash -n task4.sh
bash -n task5.sh
bash -n task6.sh
```

No output means Bash found no syntax errors.

# Add Executable Permission

```bash
chmod u+x task1.sh
chmod u+x task2.sh
chmod u+x task3.sh
chmod u+x task4.sh
chmod u+x task5.sh
chmod u+x task6.sh
```

# Run the Complete Practice

```bash
./task1.sh apple
./task2.sh apple banana
./task3.sh apple banana cherry
./task4.sh apple banana cherry
./task5.sh apple banana cherry
./task6.sh apple "green banana" cherry
```

# Quick Revision

| Symbol | Meaning |
|---|---|
| `$0` | Script name |
| `$1` | First argument |
| `$2` | Second argument |
| `$3` | Third argument |
| `$#` | Number of arguments |
| `"$@"` | All arguments |

# Final Result

You have created six simple Bash scripts and practised positional arguments, variables, argument counting, all arguments, and quoted values.
