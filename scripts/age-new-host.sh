#!/usr/bin/env bash
set -euo pipefail

identity="${CHEZMOI_AGE_IDENTITY:-$HOME/.config/chezmoi/age.txt}"
chezmoi_bin="${CHEZMOI_BIN:-chezmoi}"

mkdir -p "$(dirname "$identity")"
chmod 700 "$(dirname "$identity")"

if [[ -e "$identity" ]]; then
  echo "age identity already exists: $identity" >&2
else
  umask 077
  "$chezmoi_bin" age-keygen -o "$identity"
  chmod 600 "$identity"
fi

recipient="$($chezmoi_bin age-keygen -y "$identity")"
cat <<EOF

Add this public recipient to age-recipients.txt on a machine that can already decrypt the repo:

$recipient

Then run scripts/age-rekey.sh on that existing machine, commit, and pull here.
EOF
