# Contributing: Conventional Commits

This repository uses Conventional Commits to drive changelogs and releases.

Commit message format

Use the following format (backticks shown for clarity):

`type(scope?): description`

Examples:

- feat(api): add user endpoint
- fix(server): return 500 when X
- docs: update README
- chore: bump deps

When you run `npm run release` (standard-version) the commit history is parsed and CHANGELOG.md is generated automatically.

Use the configured commit hooks (Husky):

- pre-commit: runs lint-staged (auto-fixes and prevents bad code)
- commit-msg: validates the commit message against the Conventional Commits rules
