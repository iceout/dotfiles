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
  verified="$tmpdir/${rel//\//__}.verified"
  umask 077
  "$chezmoi_bin" decrypt "$repo_root/$rel" > "$plain"
  plain_size="$(wc -c < "$plain")"
  if [[ "$plain_size" -eq 0 && "${ALLOW_EMPTY_AGE_PLAINTEXT:-}" != "1" ]]; then
    cat >&2 <<EOF
Refusing to rekey $rel because it decrypted to 0 bytes.
If this file is intentionally empty, rerun with ALLOW_EMPTY_AGE_PLAINTEXT=1.
EOF
    exit 1
  fi
  "$chezmoi_bin" encrypt "$plain" > "$encrypted"
  "$chezmoi_bin" decrypt "$encrypted" > "$verified"
  if ! cmp -s "$plain" "$verified"; then
    echo "Refusing to replace $rel because encrypted verification failed" >&2
    exit 1
  fi
  mv "$encrypted" "$repo_root/$rel"
  rm -f "$plain" "$verified"
  echo "rekeyed $rel ($plain_size bytes plaintext)"
done

cat <<'EOF'

Rekey complete. Review and commit the encrypted-file changes:
  git diff --stat
  git status --short
EOF
