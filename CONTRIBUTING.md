# Contributing: Automated Releases with Conventional Commits

This repository uses **fully automated releases** powered by semantic-release and Conventional Commits.

## Commit Message Format

Use the following format for all commit messages:

`type(scope?): description`

## Commit Types & Release Impact

| Type | Release | Description | Example |
|------|---------|-------------|---------|
| `feat:` | **Minor** (1.1.0) | New feature | `feat: add user profile endpoint` |
| `fix:` | **Patch** (1.0.1) | Bug fix | `fix: resolve authentication timeout` |
| `feat!:` | **Major** (2.0.0) | Breaking change | `feat!: change API response format` |
| `BREAKING CHANGE:` | **Major** (2.0.0) | Breaking change in footer | See below |
| `docs:` | No release | Documentation only | `docs: update README` |
| `style:` | No release | Code style/formatting | `style: fix indentation` |
| `refactor:` | No release | Code refactoring | `refactor: extract user service` |
| `test:` | No release | Test changes | `test: add integration tests` |
| `chore:` | No release | Build/maintenance | `chore: update dependencies` |

## Breaking Changes

For breaking changes, use either:

1. **Exclamation mark**: `feat!: change API response format`
2. **Footer notation**:
   ```
   feat: add new authentication method
   
   BREAKING CHANGE: Authentication now requires API keys instead of basic auth
   ```

## Development Workflow

1. **Create feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make commits with proper format**:
   ```bash
   git commit -m "feat: add password reset functionality"
   git commit -m "fix: resolve email validation edge case"
   git commit -m "docs: update API documentation"
   ```

3. **Push and create Pull Request**:
   ```bash
   git push origin feature/your-feature-name
   ```

4. **Merge triggers automatic release**:
   - CI runs tests and validates commits
   - After merge to `main`, semantic-release automatically:
     - Analyzes commit history
     - Determines next version number
     - Updates CHANGELOG.md
     - Creates git tag
     - Publishes GitHub Release
     - Optionally publishes to npm

## Git Hooks (Automatic Validation)

Pre-commit hooks automatically:
- **pre-commit**: Runs `lint-staged` (auto-fixes code style)
- **commit-msg**: Validates commit message format

## No Manual Release Steps Required!

Unlike traditional workflows, you **do not** need to:
- Run `npm version`
- Manually update CHANGELOG.md
- Create git tags
- Create GitHub Releases

Everything is automated based on your commit messages!
