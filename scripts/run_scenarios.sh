#!/usr/bin/env bash
set -euo pipefail

year="${1:-2025}"
shift || true

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
runs_dir="$repo_root/$year/runs"

if [ ! -d "$runs_dir" ]; then
  echo "Runs directory not found: $runs_dir" >&2
  exit 1
fi

if [ "$#" -gt 0 ]; then
  scenarios=("$@")
else
  scenarios=(base alt_drop_cpue alt_sst)
fi

for s in "${scenarios[@]}"; do
  dir="$runs_dir/$s"
  if [ ! -d "$dir" ]; then
    echo "Skipping missing scenario: $s"
    continue
  fi
  echo "==> Running scenario: $s"
  make -C "$dir" mpd
  echo
  done
