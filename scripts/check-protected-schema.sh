#!/usr/bin/env bash
# Fail when the canonical schema differs in the selected comparison range.
#
# Usage:
#   ./scripts/check-protected-schema.sh [base [head]]
#
# With no arguments, checks all staged and unstaged changes against HEAD.
# With base and head, checks the commit range (as used by CI).

set -euo pipefail

protected_file='macrodroid-llm-schema.yaml'

if [[ ! -f "$protected_file" ]]; then
  printf 'ERROR: protected file is missing: %s\n' "$protected_file" >&2
  exit 1
fi

if (( $# == 0 )); then
  if git diff --quiet HEAD -- "$protected_file"; then
    printf 'Protected schema unchanged: %s\n' "$protected_file"
    exit 0
  fi
elif (( $# == 2 )); then
  base="$1"
  head="$2"

  # GitHub uses an all-zero SHA as the "before" value for a newly created ref.
  if [[ "$base" =~ ^0+$ ]]; then
    base="$(git hash-object -t tree /dev/null)"
  fi

  if git diff --quiet "$base" "$head" -- "$protected_file"; then
    printf 'Protected schema unchanged between %s and %s: %s\n' "$base" "$head" "$protected_file"
    exit 0
  fi
else
  printf 'Usage: %s [base head]\n' "$0" >&2
  exit 2
fi

cat >&2 <<EOF
ERROR: $protected_file is protected and must not be changed by an AI agent.
Restore it with:
  git restore --source=HEAD --staged --worktree -- $protected_file
EOF
exit 1
