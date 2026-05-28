#!/usr/bin/env bash
set -euo pipefail

chezmoi_bin="${CHEZMOI_BIN:-chezmoi}"
repo_root="$(git rev-parse --show-toplevel 2>/dev/null || "$chezmoi_bin" source-path)"
cd "$repo_root"

tmpdir="$(mktemp -d)"
cleanup() {
  rm -rf "$tmpdir"
}
trap cleanup EXIT

mapfile -t age_files < <(find . -type f -name '*.age' -not -path './.git/*' | sort)
if [[ ${#age_files[@]} -eq 0 ]]; then
  echo "No .age files found under $repo_root" >&2
  exit 0
fi

for file in "${age_files[@]}"; do
  rel="${file#./}"
  plain="$tmpdir/${rel//\//__}.plain"
  encrypted="$tmpdir/${rel//\//__}.age"
  umask 077
  "$chezmoi_bin" decrypt "$repo_root/$rel" > "$plain"
  "$chezmoi_bin" encrypt "$plain" > "$encrypted"
  mv "$encrypted" "$repo_root/$rel"
  rm -f "$plain"
  echo "rekeyed $rel"
done

cat <<'EOF'

Rekey complete. Review and commit the encrypted-file changes:
  git diff --stat
  git status --short
EOF
