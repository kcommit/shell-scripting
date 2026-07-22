# Simulated Lab Server

This directory represents a safe local deployment server.

It contains no deployed application when the lab begins. The deployment controller creates environment and application directories only after every conditional readiness gate passes.

After a successful development deployment, the expected structure is:

```text
lab-server/
└── dev/
    └── inventory-api/
        └── inventory-api-v1.0.0.tar.gz
```

After an approved production deployment, the expected structure is:

```text
lab-server/
└── prod/
    └── inventory-api/
        └── inventory-api-v1.0.0.tar.gz
```

Verify deployed files with:

```bash
find lab-server -type f
```

This README ensures that GitHub tracks the directory before the first deployment.

