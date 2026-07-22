# Bash Conditionals DevOps Lab — Starter Data

## What is an artifact?

An artifact is a packaged output prepared for testing or deployment.

Examples include:

- A `.tar.gz` application package
- A `.zip` release package
- A `.jar` Java application
- A `.war` web application
- A Docker image
- A compiled binary
- A Linux `.deb` or `.rpm` package

In this lab, the deployment artifact is:

```text
artifacts/inventory-api-v1.0.0.tar.gz
```

It contains a small simulated Inventory API release.

---

## Package contents

```text
bash-conditionals-devops-lab-data/
├── README.md
├── artifacts/
│   ├── inventory-api-v1.0.0.tar.gz
│   └── release.txt
├── lab-server/
│   └── README.md
├── logs/
│   └── README.md
├── source/
│   └── inventory-api-v1.0.0/
│       ├── VERSION
│       ├── application.txt
│       └── config.env
└── test-data/
    └── deployment-scenarios.csv
```

The `lab-server/` and `logs/` directories contain explanatory README files so GitHub can track them. The deployment controller later creates deployed artifacts in `lab-server/` and audit records in `logs/deployment-audit.log`.

---

## Verify the valid artifact

Run these commands from the lab-data directory:

```bash
ls -lh artifacts/
file artifacts/inventory-api-v1.0.0.tar.gz
tar -tzf artifacts/inventory-api-v1.0.0.tar.gz
```

Expected files inside the archive:

```text
inventory-api-v1.0.0/
inventory-api-v1.0.0/VERSION
inventory-api-v1.0.0/application.txt
inventory-api-v1.0.0/config.env
```

---

## Extract the artifact manually

This is optional and is useful for understanding the package:

```bash
mkdir -p extracted-artifact
tar -xzf artifacts/inventory-api-v1.0.0.tar.gz -C extracted-artifact
find extracted-artifact -type f
```

The conditionals lab itself only checks and copies the artifact. It does not require extraction.

---

## Test data

The file below contains ready-made success and failure scenarios:

```text
test-data/deployment-scenarios.csv
```

Display it in a readable column format:

```bash
column -s, -t test-data/deployment-scenarios.csv
```

If `column` is unavailable, use:

```bash
cat test-data/deployment-scenarios.csv
```

---

## Create an empty artifact for a failure test

```bash
touch artifacts/empty.tar.gz
```

Test it with the preflight script:

```bash
./03-artifact-preflight.sh artifacts/empty.tar.gz
echo "$?"
```

The check should fail because `-s` is false for an empty file.

---

## Incorrect-extension test data

This file exists and is not empty, but it does not end with `.tar.gz`:

```text
artifacts/release.txt
```

Test it:

```bash
./03-artifact-preflight.sh artifacts/release.txt
echo "$?"
```

The check should fail because the filename has the wrong extension.

---

## Missing-artifact test

Use this intentionally nonexistent path:

```text
artifacts/missing.tar.gz
```

Test it:

```bash
./03-artifact-preflight.sh artifacts/missing.tar.gz
echo "$?"
```

The check should fail because `-f` is false.

---

## Healthy development workflow values

```text
Application: inventory-api
Environment: dev
Ticket: NONE
Artifact: artifacts/inventory-api-v1.0.0.tar.gz
CPU: 45
Disk: 60
```

Command:

```bash
./06-deployment-controller.sh inventory-api dev NONE artifacts/inventory-api-v1.0.0.tar.gz 45 60
```

---

## Approved production workflow values

```text
Application: inventory-api
Environment: prod
Ticket: CHG-2026-1001
Artifact: artifacts/inventory-api-v1.0.0.tar.gz
CPU: 40
Disk: 55
```

Command:

```bash
./06-deployment-controller.sh inventory-api prod CHG-2026-1001 artifacts/inventory-api-v1.0.0.tar.gz 40 55
```

---

## Safety

All data is fictional and intended for local practice. The lab should copy files only into `lab-server/`. It does not require `sudo`, remote access, cloud resources, or production credentials.
