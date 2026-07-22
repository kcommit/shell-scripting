# Simulated Lab Server

This directory starts without a deployed application.

The deployment scripts create environment, application, and version directories here.

After running:

```bash
./06-deployment-runner.sh inventory-api dev v1.0.0 artifacts/inventory-api.txt
```

the expected structure is:

```text
lab-server/
└── dev/
    └── inventory-api/
        └── v1.0.0/
            └── inventory-api.txt
```

Verify it with:

```bash
find lab-server -type f
cat lab-server/dev/inventory-api/v1.0.0/inventory-api.txt
```

This README also ensures that GitHub tracks the directory before a deployment occurs.

