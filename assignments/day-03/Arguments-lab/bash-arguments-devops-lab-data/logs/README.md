# Deployment Logs

This directory starts without a deployment audit record.

The workflow runner creates and appends to:

```text
logs/deployment.log
```

Run a workflow:

```bash
./06-deployment-runner.sh inventory-api dev v1.0.0 artifacts/inventory-api.txt
```

Then display the generated log:

```bash
cat logs/deployment.log
```

A record should contain the date, user, application, environment, version, artifact, and final status.

This README also ensures that GitHub tracks the directory before the first workflow run.

