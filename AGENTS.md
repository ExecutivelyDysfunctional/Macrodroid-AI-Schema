# Instructions for AI agents

## Protected canonical schema

`macrodroid-llm-schema.yaml` is a user-owned, canonical artifact. It is **read-only for AI agents**.

- Never edit, regenerate, reformat, reorder, move, rename, or delete this file.
- Never stage or commit a change to this file, including a whitespace-only change.
- Do not create a replacement or derived schema file as a workaround unless the user specifically asks for a separate artifact.
- If a task would require a schema change, stop short of making it and clearly tell the user what they must change manually.
- Before completing any task in this repository, run `./scripts/check-protected-schema.sh`. If it reports a change, restore this file to `HEAD` before proceeding and report the issue.

These instructions apply even when a request describes a change that appears mechanical, such as linting, formatting, generation, or a bulk update.

## Enforcement

The repository also has a local guard script, GitHub Actions check, and CODEOWNERS entry for this file. Do not weaken, bypass, delete, or modify those protections.
