# Bash Conditionals Lab — Baby-Steps Solution

This solution matches the six-task beginner conditionals lab.

## Quick reminder

```bash
if [ condition ]
then
    echo "The condition is true"
else
    echo "The condition is false"
fi
```

Remember:

- Put spaces inside `[ ]`.
- Use `fi` to close the conditional.
- Put variables inside double quotes.

---

# Task 1 Solution — Your First `if`

File: `task1.sh`

```bash
#!/bin/bash

# Use the first if condition

fruit="$1"

if [ "$fruit" = "apple" ]
then
    echo "You chose apple"
fi
```

Test with `apple`:

```bash
bash task1.sh apple
```

Output:

```text
You chose apple
```

Test with `banana`:

```bash
bash task1.sh banana
```

There is no output because the condition is false and the script has no `else`.

---

# Task 2 Solution — Add `else`

File: `task2.sh`

```bash
#!/bin/bash

# Use if and else

fruit="$1"

if [ "$fruit" = "apple" ]
then
    echo "You chose apple"
else
    echo "You did not choose apple"
fi
```

Tests:

```bash
bash task2.sh apple
bash task2.sh banana
```

Output:

```text
You chose apple
You did not choose apple
```

`else` runs when the `if` condition is false.

---

# Task 3 Solution — Add `elif`

File: `task3.sh`

```bash
#!/bin/bash

# Use if, elif, and else

fruit="$1"

if [ "$fruit" = "apple" ]
then
    echo "Apple selected"
elif [ "$fruit" = "banana" ]
then
    echo "Banana selected"
else
    echo "Another fruit selected"
fi
```

Tests:

```bash
bash task3.sh apple
bash task3.sh banana
bash task3.sh cherry
```

Output:

```text
Apple selected
Banana selected
Another fruit selected
```

`elif` checks another condition when the earlier condition is false.

---

# Task 4 Solution — Check a Number

File: `task4.sh`

```bash
#!/bin/bash

# Check whether the basket has three fruits

fruit_count="$1"

if [ "$fruit_count" -eq 3 ]
then
    echo "The basket has three fruits"
else
    echo "The basket does not have three fruits"
fi
```

Tests:

```bash
bash task4.sh 3
bash task4.sh 5
```

Output:

```text
The basket has three fruits
The basket does not have three fruits
```

`-eq` means numerically equal.

---

# Task 5 Solution — Small, Medium, or Large Basket

File: `task5.sh`

```bash
#!/bin/bash

# Classify the basket size

fruit_count="$1"

if [ "$fruit_count" -gt 5 ]
then
    echo "Large basket"
elif [ "$fruit_count" -eq 5 ]
then
    echo "Medium basket"
else
    echo "Small basket"
fi
```

Tests:

```bash
bash task5.sh 8
bash task5.sh 5
bash task5.sh 2
```

Output:

```text
Large basket
Medium basket
Small basket
```

- `-gt` means greater than.
- `-eq` means equal.

The script checks the conditions from top to bottom and runs the first matching block.

---

# Task 6 Solution — Use `[[ ]]`

File: `task6.sh`

```bash
#!/bin/bash

# Use double brackets with a fruit name containing a space

fruit="$1"

if [[ "$fruit" == "green apple" ]]
then
    echo "Green apple selected"
else
    echo "Different fruit selected"
fi
```

Tests:

```bash
bash task6.sh "green apple"
bash task6.sh banana
```

Output:

```text
Green apple selected
Different fruit selected
```

`"green apple"` is inside quotes, so Bash receives it as one argument.

---

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
./task2.sh banana
./task3.sh cherry
./task4.sh 3
./task5.sh 8
./task6.sh "green apple"
```

# Quick Revision

## Conditional words

| Word | Meaning |
|---|---|
| `if` | Check the first condition |
| `then` | Start the commands for a true condition |
| `elif` | Check another condition |
| `else` | Run when earlier conditions are false |
| `fi` | End the conditional |

## Comparison operators

| Operator | Meaning |
|---|---|
| `=` | Strings are equal |
| `!=` | Strings are not equal |
| `-eq` | Numbers are equal |
| `-ne` | Numbers are not equal |
| `-gt` | Greater than |
| `-ge` | Greater than or equal |
| `-lt` | Less than |
| `-le` | Less than or equal |

# Final Result

You have completed six simple Bash scripts using:

- `if`
- `if` and `else`
- `if`, `elif`, and `else`
- String comparison
- Number comparison
- Traditional `[ ]`
- Bash `[[ ]]`
