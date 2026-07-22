# Bash Arguments DevOps Lab — Starter Data

## Purpose

This package provides safe sample data for the six-task Bash Arguments DevOps Lab.

It is designed for these scripts:

```text
01-argument-inspector.sh
02-deployment-plan.sh
03-validate-request.sh
04-artifact-preflight.sh
05-local-deploy.sh
06-deployment-runner.sh
```

All data is fictional and intended for local practice only.

---

## What is the artifact in this lab?

An artifact is the application file that the deployment workflow checks and copies to the simulated server.

The primary artifact is:

```text
artifacts/inventory-api.txt
```

Its contents represent a simple Inventory API release.

---

## Package structure

```text
bash-arguments-devops-lab-data/
├── README.md
├── artifacts/
│   ├── customer-portal.txt
│   ├── inventory-api.txt
│   └── payments-api.txt
├── lab-server/
│   └── README.md
├── logs/
│   └── README.md
└── test-data/
    ├── argument-scenarios.csv
    └── deployment-commands.txt
```

The `lab-server/` and `logs/` directories contain explanatory README files so GitHub can track them. The deployment script creates application files in `lab-server/` and audit records in `logs/deployment.log` during the lab.

---

## Main lab values

```text
Application: inventory-api
Environment: dev
Version: v1.0.0
Artifact: artifacts/inventory-api.txt
```

Complete argument set:

```bash
inventory-api dev v1.0.0 artifacts/inventory-api.txt
```

---

## Task 1 — Argument inspector data

Standard test:

```bash
./01-argument-inspector.sh inventory-api dev v1.0.0 artifacts/inventory-api.txt
```

Quoted application-name test:

```bash
./01-argument-inspector.sh "customer portal" test v2.1.0 artifacts/customer-portal.txt
```

The quoted name `customer portal` must remain one argument, so `$#` should be `4`.

---

## Task 2 — Deployment-plan data

Development plan:

```bash
./02-deployment-plan.sh inventory-api dev v1.0.0 artifacts/inventory-api.txt
```

Testing plan:

```bash
./02-deployment-plan.sh payments-api test v3.0.0 artifacts/payments-api.txt
```

Production plan:

```bash
./02-deployment-plan.sh customer-portal prod v2.1.0 artifacts/customer-portal.txt
```

---

## Task 3 — Request-validation data

Valid development request:

```bash
./03-validate-request.sh inventory-api dev v1.0.0 artifacts/inventory-api.txt
```

Valid testing request:

```bash
./03-validate-request.sh payments-api test v3.0.0 artifacts/payments-api.txt
```

Valid production request:

```bash
./03-validate-request.sh customer-portal prod v2.1.0 artifacts/customer-portal.txt
```

Invalid environment:

```bash
./03-validate-request.sh inventory-api classroom v1.0.0 artifacts/inventory-api.txt
```

Too few arguments:

```bash
./03-validate-request.sh inventory-api dev
```

No arguments:

```bash
./03-validate-request.sh
```

Print the exit status immediately after each test:

```bash
echo "$?"
```

---

## Task 4 — Artifact-preflight data

Valid Inventory API artifact:

```bash
./04-artifact-preflight.sh artifacts/inventory-api.txt
```

Valid Payments API artifact:

```bash
./04-artifact-preflight.sh artifacts/payments-api.txt
```

Missing artifact:

```bash
./04-artifact-preflight.sh artifacts/missing.txt
```

The path `artifacts/missing.txt` is intentionally absent.

Create an empty artifact:

```bash
touch artifacts/empty.txt
```

Test it:

```bash
./04-artifact-preflight.sh artifacts/empty.txt
echo "$?"
```

The empty file should fail the `-s` condition.

---

## Task 5 — Local-deployment data

Deploy Inventory API to development:

```bash
./05-local-deploy.sh inventory-api dev v1.0.0 artifacts/inventory-api.txt
```

Expected file:

```text
lab-server/dev/inventory-api/v1.0.0/inventory-api.txt
```

Deploy Payments API to testing:

```bash
./05-local-deploy.sh payments-api test v3.0.0 artifacts/payments-api.txt
```

Expected file:

```text
lab-server/test/payments-api/v3.0.0/payments-api.txt
```

Failure test:

```bash
./05-local-deploy.sh inventory-api dev v1.0.1 artifacts/missing.txt
echo "$?"
```

---

## Task 6 — Complete workflow data

Successful development workflow:

```bash
./06-deployment-runner.sh inventory-api dev v1.0.0 artifacts/inventory-api.txt
```

Successful testing workflow:

```bash
./06-deployment-runner.sh payments-api test v3.0.0 artifacts/payments-api.txt
```

Successful production workflow:

```bash
./06-deployment-runner.sh customer-portal prod v2.1.0 artifacts/customer-portal.txt
```

Invalid-environment workflow:

```bash
./06-deployment-runner.sh inventory-api classroom v1.0.0 artifacts/inventory-api.txt
```

Missing-artifact workflow:

```bash
./06-deployment-runner.sh inventory-api test v1.0.1 artifacts/missing.txt
```

Missing-argument workflow:

```bash
./06-deployment-runner.sh inventory-api dev v1.0.0
```

Check the audit log:

```bash
cat logs/deployment.log
```

---

## Display the scenario table

```bash
column -s, -t test-data/argument-scenarios.csv
```

If `column` is unavailable:

```bash
cat test-data/argument-scenarios.csv
```

---

## Verify all supplied artifacts

```bash
ls -lh artifacts/
cat artifacts/inventory-api.txt
cat artifacts/payments-api.txt
cat artifacts/customer-portal.txt
```

---

## Safety

The sample scripts should copy files only into `lab-server/`. This data does not require `sudo`, system-account changes, remote access, cloud resources, or production credentials.
