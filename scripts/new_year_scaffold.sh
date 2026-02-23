#!/usr/bin/env bash
set -euo pipefail

new_year="${1:?Usage: new_year_scaffold.sh <new_year> <prev_year>}"
prev_year="${2:?Usage: new_year_scaffold.sh <new_year> <prev_year>}"

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
new_root="$repo_root/$new_year/runs"
prev_root="$repo_root/$prev_year/runs"

tpl="$repo_root/templates/scenario"
mkdir -p "$new_root/data" "$new_root/base" "$new_root/alt_drop_cpue" "$new_root/alt_sst"

if [ -f "$prev_root/data/README.md" ]; then
  cp "$prev_root/data/README.md" "$new_root/data/README.md"
else
  cp "$repo_root/2025/runs/data/README.md" "$new_root/data/README.md"
fi

for s in base alt_drop_cpue alt_sst; do
  cp "$tpl/Makefile" "$new_root/$s/Makefile"
  cp "$tpl/control.dat" "$new_root/$s/control.dat"
  cp "$tpl/README.md" "$new_root/$s/README.md"
done

cat > "$repo_root/$new_year/README.md" <<TXT
# $new_year Assessment Workspace

Initialized from scaffold using previous year: $prev_year.
TXT

echo "Initialized year scaffold: $repo_root/$new_year"
