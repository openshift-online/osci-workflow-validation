# osci-workflow-validation

A minimal Go HTTP server used to validate OpenShift CI workflows — specifically the **ephemeral-namespace** workflow that provisions short-lived namespaces on the ConsoleDot ephemeral cluster via [bonfire](https://github.com/RedHatInsights/bonfire).

## Quick Start

```bash
make build       # Build the server binary
make test        # Run tests
make run         # Build and start the server
```

## What This Repo Does

This repository exists solely to exercise the `ephemeral-namespace` workflow defined in the [openshift/release](https://github.com/openshift/release) step registry. The application itself is intentionally trivial: a health-check endpoint and a version endpoint.

The CI configuration for this repo defines two tests:

| Test | Purpose |
|------|---------|
| `unit` | Runs `go test ./...` to validate the application builds and passes tests. |
| `ephemeral-smoke` | Uses the `ephemeral-namespace` workflow to reserve a namespace, deploy the built image, verify the health endpoint, and release the namespace. |

## Local Development

```bash
go test ./...
go run .
curl http://localhost:8080/healthz
```

## OpenShift CI Integration

The CI configuration lives in `openshift/release` at:

```
ci-operator/config/openshift-online/osci-workflow-validation/openshift-online-osci-workflow-validation-main.yaml
```

### Ephemeral Namespace Workflow

The `ephemeral-smoke` test uses the `ephemeral-namespace` workflow which:

1. **Pre**: Reserves a namespace from the ephemeral cluster pool using `bonfire namespace reserve`
2. **Test**: Deploys the application and verifies the `/healthz` endpoint returns `200`
3. **Post**: Releases the namespace back to the pool via `bonfire namespace release`

### Required Secret

The workflow requires a secret named `ephemeral-bot-svc-account` in the `test-credentials` namespace containing:

| Key | Description |
|-----|-------------|
| `oc-login-token` | Service account token for the ephemeral cluster |
| `oc-login-server` | API server URL of the ephemeral cluster |
