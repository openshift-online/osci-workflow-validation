# CLAUDE.md

<!-- Canonical source: AGENTS.md. This file is auto-generated for Claude Code compatibility. -->

This file provides guidance to AI coding assistants when working with this repository.

## Project Overview

OSCI Workflow Validation — a minimal Go HTTP server used to validate OpenShift CI workflows, specifically the ephemeral-namespace workflow that provisions test environments for CI jobs.

## Build & Test Commands

```bash
go build ./...       # Build the server
go test ./...        # Run tests
```

## Architecture

- Single-binary HTTP server at the root package level
- **deploy/**: Kubernetes/OpenShift deployment manifests

## Key Conventions

- Module path: `github.com/openshift-online/osci-workflow-validation`
- Keep the server minimal and focused on CI validation
