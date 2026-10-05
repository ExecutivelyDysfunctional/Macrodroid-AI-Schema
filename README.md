# Macrodroid-AI-Schema

## Canonical schema protection

`macrodroid-llm-schema.yaml` is the canonical schema and is deliberately read-only for AI agents. The repository enforces this policy in three layers:

- [`AGENTS.md`](AGENTS.md) tells AI agents not to touch the file.
- [`scripts/check-protected-schema.sh`](scripts/check-protected-schema.sh) detects staged or unstaged changes locally.
- [GitHub Actions](.github/workflows/protect-canonical-schema.yml) fails when a pull request or push changes it. The pull-request check runs the policy from the trusted base branch, so a pull request cannot bypass it by changing the guard in the same change.

The file also has a [`CODEOWNERS`](.github/CODEOWNERS) entry. For GitHub to block a merge, configure the branch-protection rule to require both the **Reject canonical schema changes** status check and **Require review from Code Owners**.

Run the local guard before finishing any work:

```bash
./scripts/check-protected-schema.sh
```
