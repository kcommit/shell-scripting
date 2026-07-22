# Bash Arguments Lab — Complete Solution

## Purpose

This solution implements the six-task Bash arguments lab as a safe local DevOps deployment simulation.

It demonstrates:

- Positional arguments
- `$#`, `"$@"`, and `"$*"`
- Descriptive variables
- Argument validation
- `if`, `elif`, and `else`
- Double-bracket conditions
- File tests
- Exit statuses
- Local artifact deployment
- Audit logging
- Passing arguments between scripts

The solution does not use functions, loops, arrays, `case`, `getopts`, `sudo`, or remote servers.

---

## Files

| File | Purpose |
|---|---|
| `01-argument-inspector.sh` | Displays positional and special arguments |
| `02-deployment-plan.sh` | Converts arguments to variables and displays a plan |
| `03-validate-request.sh` | Validates argument count and environment |
| `04-artifact-preflight.sh` | Checks that an artifact is readable and non-empty |
| `05-local-deploy.sh` | Copies an artifact to a local simulated server |
| `06-deployment-runner.sh` | Connects validation, preflight, deployment, and logging |
| `artifacts/inventory-api.txt` | Safe sample deployment artifact |
| `logs/deployment.log` | Audit history created during workflow tests |

---

## 1. Prepare the scripts

```bash
chmod u+x *.sh
```

Check all syntax:

```bash
bash -n 01-argument-inspector.sh
bash -n 02-deployment-plan.sh
bash -n 03-validate-request.sh
bash -n 04-artifact-preflight.sh
bash -n 05-local-deploy.sh
bash -n 06-deployment-runner.sh
```

No output means Bash found no syntax errors.

---

## 2. Task 1 test

```bash
./01-argument-inspector.sh inventory-api dev v1.0.0 artifacts/inventory-api.txt
```

Quoted application-name test:

```bash
./01-argument-inspector.sh "inventory api" dev v1.0.0 artifacts/inventory-api.txt
```

The argument count remains four because `inventory api` is quoted as one argument.

---

## 3. Task 2 test

```bash
./02-deployment-plan.sh inventory-api dev v1.0.0 artifacts/inventory-api.txt
```

This displays the plan but does not copy the artifact.

---

## 4. Task 3 tests

Valid request:

```bash
./03-validate-request.sh inventory-api dev v1.0.0 artifacts/inventory-api.txt
echo "$?"
```

Invalid environment:

```bash
./03-validate-request.sh inventory-api school v1.0.0 artifacts/inventory-api.txt
echo "$?"
```

Missing arguments:

```bash
./03-validate-request.sh inventory-api dev
echo "$?"
```

The valid request returns `0`; invalid requests return `1`.

---

## 5. Task 4 tests

Valid artifact:

```bash
./04-artifact-preflight.sh artifacts/inventory-api.txt
echo "$?"
```

Missing artifact:

```bash
./04-artifact-preflight.sh artifacts/missing.txt
echo "$?"
```

Empty artifact:

```bash
touch artifacts/empty.txt
./04-artifact-preflight.sh artifacts/empty.txt
echo "$?"
```

---

## 6. Task 5 test

```bash
./05-local-deploy.sh inventory-api dev v1.0.0 artifacts/inventory-api.txt
echo "$?"
```

Verify the deployed file:

```bash
find lab-server -type f
cat lab-server/dev/inventory-api/v1.0.0/inventory-api.txt
```

---

## 7. Complete workflow test

```bash
./06-deployment-runner.sh inventory-api dev v1.0.0 artifacts/inventory-api.txt
echo "$?"
```

The successful workflow:

1. Validates four arguments.
2. Validates the environment.
3. Checks the artifact.
4. Creates the local destination.
5. Copies the artifact.
6. Writes a success record to the audit log.
7. Returns exit status `0`.

---

## 8. Failure tests

Invalid environment:

```bash
./06-deployment-runner.sh inventory-api classroom v1.0.0 artifacts/inventory-api.txt
echo "$?"
```

Missing artifact:

```bash
./06-deployment-runner.sh inventory-api test v1.0.1 artifacts/missing.txt
echo "$?"
```

Missing argument:

```bash
./06-deployment-runner.sh inventory-api dev v1.0.0
echo "$?"
```

Each command should return exit status `1` and must not display a false success message.

---

## 9. Verify the audit log

```bash
cat logs/deployment.log
```

Each record includes:

- Date and time
- Current user
- Application
- Environment
- Version
- Artifact
- Final status

The script uses `>>`, so new records are appended instead of replacing previous records.

---

## Important argument concepts

### `$#`

`$#` contains the number of arguments supplied to a script.

```bash
if [[ "$#" -ne 4 ]]; then
    echo "Exactly four arguments are required."
fi
```

### `"$@"`

`"$@"` represents all arguments while preserving each one separately.

```bash
./03-validate-request.sh "$@"
```

This is the recommended method for forwarding arguments to another script.

### `"$*"`

When quoted, `"$*"` combines all arguments into one string. It is not appropriate when another script must receive the original arguments separately.

### Why quote arguments?

Quoting preserves spaces and prevents unexpected word splitting:

```bash
artifact="$4"
cp "$artifact" "$destination/"
```

---

## Expected final structure

```text
bash-arguments-devops-lab-solution/
├── README.md
├── 01-argument-inspector.sh
├── 02-deployment-plan.sh
├── 03-validate-request.sh
├── 04-artifact-preflight.sh
├── 05-local-deploy.sh
├── 06-deployment-runner.sh
├── artifacts/
│   └── inventory-api.txt
├── lab-server/
│   └── dev/
│       └── inventory-api/
│           └── v1.0.0/
│               └── inventory-api.txt
└── logs/
    └── deployment.log
```

---

## Safety note

This solution copies files only into the local `lab-server/` directory. It does not use `sudo`, modify system accounts, contact remote hosts, or make production changes.

