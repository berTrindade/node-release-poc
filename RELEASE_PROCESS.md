# Release process (node-release-poc)

This document describes the core release process concepts used in this POC and how the repository implements them.

Core concepts mapped to this repository

1. Versioning

- We use semantic versioning via `standard-version` (package.json scripts: `npm run release`).
- `standard-version` bumps package.json, generates CHANGELOG.md based on Conventional Commits, and creates a git tag (e.g., `v1.2.0`).

2. Branching Strategy

- Short-lived feature branches are encouraged. Merge into `main`/`master` via pull request.
- Releases are produced by tagging commits on `main` (or by CI on a release branch). Tag pushes trigger the release workflow.

3. Testing & Quality Gates

- Unit tests use Jest + Supertest (see `tests/`).
- ESLint is configured and run in CI. Husky+lint-staged enforce pre-commit linting locally.
- CI workflow runs lint + tests; failure stops the pipeline.

4. Tagging & Artifacts

- `standard-version` creates annotated tags (vX.Y.Z).
- Build artifact is produced by `npm run build` (npm pack into `dist/`).
- Release workflow attaches the tarball to the GitHub Release.

5. Automation (CI/CD)

- GitHub Actions CI workflow runs on push and PR to run lint, tests, and create the package artifact.
- Release workflow runs on tag push to produce a GitHub Release and attach artifacts.

6. Documentation & Changelogs

- CHANGELOG.md is maintained by `standard-version` and included in releases.
- This repository contains `RELEASE_PROCESS.md`, `CONTRIBUTING.md`, and `README.md` to document process and usage.

7. Deployment & Rollback

- This POC focuses on release artifacts and tagging. For production, replace the Release step with a deployment job that:
  - Publishes images to a registry (e.g., Docker Hub, ECR) and/or uploads packages to a registry (npm, GitHub Packages).
  - Uses tracked releases and image tags (e.g., `my-service:v1.2.0`).
  - Supports rollback by redeploying a previous tag.

8. Monitoring & Feedback

- The POC exposes a `/health` endpoint for readiness/health checks. Production systems should integrate metrics, logs, and alerting.

How repository components implement these concepts

- package.json scripts:

  - `lint`, `test`: local quality gates matching CI jobs (Testing & Quality Gates)
  - `build`: creates an artifact for release (Tagging & Artifacts)
  - `release`: runs `standard-version` to bump versions and generate changelog (Versioning & Documentation)

- Husky + lint-staged + commitlint:

  - Enforce pre-commit lint fixes and Conventional Commit messages locally so commit history is usable by `standard-version` (Quality Gates, Documentation)

- GitHub Actions workflows:

  - `ci.yml`: runs lint/test/build on PRs and pushes (Automation)
  - `release.yml`: triggers on tag push to run final checks and create a GitHub Release with artifacts (Automation, Tagging & Artifacts)

- CHANGELOG.md (managed by `standard-version`) captures human-friendly release notes (Documentation & Changelogs)

- Dockerfile provides a production-lean container image to run releases (Deployment)

Extending this POC for production

- Add integration tests and end-to-end suites; run them in CI before release.
- Wire in a container registry and deploy step in the release workflow (e.g., build and push Docker image, then deploy to staging/production).
- Integrate canary or blue/green deployments with automated rollback based on health and metrics.
- Add SSO and secrets handling (GitHub Actions secrets) and ensure least-privilege tokens for release automation.
