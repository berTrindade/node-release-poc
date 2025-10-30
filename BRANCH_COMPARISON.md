# Node.js Release POC - Branch Comparison

This repository demonstrates two different approaches to Node.js release processes:

## Branch Overview

### 🔧 manual-release Branch
- **Approach**: Developer-controlled releases using `standard-version`
- **Trigger**: Manual execution of `npm run release` + `git push --follow-tags`
- **Control**: High - developers choose when to release
- **Workflow**: Feature → PR → Merge → Manual Release Command → CI Release

### 🤖 auto-release Branch  
- **Approach**: Fully automated releases using `semantic-release`
- **Trigger**: Automatic on merge to `main` branch
- **Control**: Automated - releases happen on every merge
- **Workflow**: Feature → PR → Merge → Automatic Release

## Feature Comparison

| Feature | manual-release | auto-release |
|---------|---------------|--------------|
| **Release Tool** | standard-version | semantic-release |
| **Versioning** | Manual trigger | Automatic |
| **Changelog** | Generated locally | Generated in CI |
| **GitHub Release** | Created by CI after tag push | Created automatically |
| **npm Publishing** | Not configured | Optional via NPM_TOKEN |
| **Developer Control** | High (timing) | Low (commit-based) |
| **Release Frequency** | On-demand | Every merge |
| **Risk of Human Error** | Medium | Very Low |

## Workflow Diagrams

### Manual Release Flow
```
Developer → npm run release → git push --follow-tags → GitHub Actions
```

### Auto Release Flow  
```
Developer → git push → PR merge → GitHub Actions (automatic)
```

## File Differences

### manual-release Branch
- `package.json`: Uses `standard-version` dependency
- `.github/workflows/`: Separate `ci.yml` and `release.yml` workflows
- `RELEASE_PROCESS.md`: Manual release documentation
- Release triggered by: Tag push

### auto-release Branch
- `package.json`: Uses `semantic-release` and plugins
- `.releaserc.json`: Semantic-release configuration
- `.github/workflows/ci.yml`: Combined CI and release workflow
- `RELEASE_PROCESS.md`: Automated release documentation  
- Release triggered by: Push to main

## 8 Core Release Concepts Implementation

Both branches implement the same 8 core release concepts but with different levels of automation:

1. **Versioning**: SemVer via commit analysis
2. **Branching Strategy**: Feature branches → main
3. **Testing & Quality Gates**: Jest + ESLint + Husky hooks
4. **Tagging & Artifacts**: Git tags + npm tarballs + GitHub Releases
5. **Automation (CI/CD)**: GitHub Actions workflows
6. **Documentation & Changelogs**: Auto-generated CHANGELOG.md
7. **Deployment & Rollback**: Docker + git tag-based rollbacks
8. **Monitoring & Feedback**: Health endpoints + release notifications

## When to Use Each Approach

### Choose manual-release when:
- You need precise control over release timing
- You want to batch multiple features into releases
- You have complex release approval processes
- You want to review changes before releases
- You have infrequent, planned releases

### Choose auto-release when:
- You practice continuous delivery
- You want to minimize human error
- You have good test coverage and confidence
- You want fast feedback loops
- You prefer smaller, more frequent releases

## Getting Started

### Clone and Test manual-release:
```bash
git clone <repo-url>
cd node-release-poc
git checkout manual-release
npm install
npm test
npm run lint
```

### Clone and Test auto-release:
```bash
git clone <repo-url>  
cd node-release-poc
git checkout auto-release
npm install
npm test
npm run lint
```

## Production Considerations

Both approaches can be extended for production with:
- Container registry integration
- Deployment automation (Kubernetes, etc.)
- Advanced testing (integration, E2E)
- Security scanning and vulnerability checks
- Monitoring and observability integration
- Approval workflows for critical releases

See the `RELEASE_PROCESS.md` file in each branch for detailed implementation guidance.