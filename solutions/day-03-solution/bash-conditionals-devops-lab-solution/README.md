# Bash Conditionals DevOps Lab — Complete Solution

## Objective

This solution implements all six tasks in the Bash Conditionals Real DevOps Release Flow Lab.

It demonstrates:

- `if`, `elif`, `else`, and `fi`
- Traditional `[ condition ]`
- Modern Bash `[[ condition ]]`
- Numeric, string, file, and pattern conditions
- Command exit statuses
- `&&`, `||`, and `!`
- Arguments and quoted variables
- Release-readiness gates
- Safe local deployment
- Audit logging

The solution does not use functions, loops, arrays, `case`, `getopts`, `sudo`, remote servers, cloud resources, or production systems.

---

## Files

| File | Purpose |
|---|---|
| `01-resource-check.sh` | Classifies CPU and disk usage |
| `02-environment-gate.sh` | Approves environments and production change tickets |
| `03-artifact-preflight.sh` | Validates the release artifact |
| `04-tool-health-check.sh` | Checks whether a required command exists |
| `05-release-readiness.sh` | Runs every release-approval gate |
| `06-deployment-controller.sh` | Deploys approved artifacts and creates audit records |
| `artifacts/inventory-api-v1.0.0.tar.gz` | Valid release artifact |
| `artifacts/release.txt` | Wrong-extension failure-test file |
| `test-data/deployment-scenarios.csv` | Ready-made success and failure scenarios |

---

## Prepare the scripts

```bash
chmod u+x *.sh
```

Check all syntax:

```bash
bash -n 01-resource-check.sh
bash -n 02-environment-gate.sh
bash -n 03-artifact-preflight.sh
bash -n 04-tool-health-check.sh
bash -n 05-release-readiness.sh
bash -n 06-deployment-controller.sh
```

No output means Bash found no syntax errors.

---

## Task 1 — Resource tests

Healthy:

```bash
./01-resource-check.sh 45 60
echo "$?"
```

Warning:

```bash
./01-resource-check.sh 75 55
echo "$?"
```

Critical:

```bash
./01-resource-check.sh 40 95
echo "$?"
```

Invalid range:

```bash
./01-resource-check.sh 120 50
echo "$?"
```

This beginner solution expects whole-number input.

---

## Task 2 — Environment tests

Development:

```bash
./02-environment-gate.sh dev NONE
```

Approved production:

```bash
./02-environment-gate.sh prod CHG-2026-1001
```

Unapproved production:

```bash
./02-environment-gate.sh prod NONE
```

Invalid environment:

```bash
./02-environment-gate.sh classroom CHG-2026-1001
```

---

## Task 3 — Artifact tests

Valid artifact:

```bash
./03-artifact-preflight.sh artifacts/inventory-api-v1.0.0.tar.gz
```

Missing artifact:

```bash
./03-artifact-preflight.sh artifacts/missing.tar.gz
```

Wrong extension:

```bash
./03-artifact-preflight.sh artifacts/release.txt
```

Empty artifact:

```bash
touch artifacts/empty.tar.gz
./03-artifact-preflight.sh artifacts/empty.tar.gz
```

---

## Task 4 — Tool tests

Available tool:

```bash
./04-tool-health-check.sh tar
```

Missing tool:

```bash
./04-tool-health-check.sh missingtool
```

`command -v` returns `0` when the command is found, so Bash treats the condition as true.

---

## Task 5 — Release-readiness tests

Ready release:

```bash
./05-release-readiness.sh inventory-api dev NONE artifacts/inventory-api-v1.0.0.tar.gz 45 60
```

Critical resources:

```bash
./05-release-readiness.sh inventory-api dev NONE artifacts/inventory-api-v1.0.0.tar.gz 95 60
```

Unapproved production:

```bash
./05-release-readiness.sh inventory-api prod NONE artifacts/inventory-api-v1.0.0.tar.gz 45 60
```

Missing artifact:

```bash
./05-release-readiness.sh inventory-api test NONE artifacts/missing.tar.gz 45 60
```

---

## Task 6 — Complete controller tests

Healthy development deployment:

```bash
./06-deployment-controller.sh inventory-api dev NONE artifacts/inventory-api-v1.0.0.tar.gz 45 60
echo "$?"
```

Approved production deployment:

```bash
./06-deployment-controller.sh inventory-api prod CHG-2026-1001 artifacts/inventory-api-v1.0.0.tar.gz 40 55
echo "$?"
```

Critical-resource failure:

```bash
./06-deployment-controller.sh inventory-api dev NONE artifacts/inventory-api-v1.0.0.tar.gz 95 60
echo "$?"
```

Unapproved-production failure:

```bash
./06-deployment-controller.sh inventory-api prod NONE artifacts/inventory-api-v1.0.0.tar.gz 45 60
echo "$?"
```

Missing-artifact failure:

```bash
./06-deployment-controller.sh inventory-api test NONE artifacts/missing.tar.gz 45 60
echo "$?"
```

Missing-argument failure:

```bash
./06-deployment-controller.sh inventory-api dev NONE artifacts/inventory-api-v1.0.0.tar.gz 45
echo "$?"
```

---

## Verify deployed artifacts

```bash
find lab-server -type f
```

Expected tested files:

```text
lab-server/dev/inventory-api/inventory-api-v1.0.0.tar.gz
lab-server/prod/inventory-api/inventory-api-v1.0.0.tar.gz
```

---

## Verify the audit log

```bash
cat logs/deployment-audit.log
```

The log contains successful and failed workflow records. New records are added with `>>`, so previous history is preserved.

---

## Exit-status design

| Result | Exit status |
|---|---:|
| Healthy resource check | `0` |
| Resource warning | `2` |
| Critical resources | `3` |
| Invalid input or failed gate | `1` |
| Complete deployment success | `0` |

Every non-zero status is false inside an `if` condition.

---

## Important condition examples

Numeric comparison:

```bash
[ "$cpu_usage" -ge 90 ]
```

String comparison:

```bash
[[ "$environment" == "dev" ]]
```

Wildcard ticket check:

```bash
[[ "$ticket" == CHG-* ]]
```

File check:

```bash
[[ -f "$artifact" ]]
```

Command exit-status check:

```bash
if command -v "$tool" > /dev/null 2>&1
then
    echo "Tool exists."
fi
```

---

## Safety

This solution copies artifacts only into `lab-server/`. It does not use elevated privileges, modify system services or users, contact remote hosts, or change production resources.

