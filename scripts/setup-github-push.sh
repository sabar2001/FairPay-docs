#!/usr/bin/env bash
# One-time GitHub setup for FairPay-docs push (SSH + create repo + push).
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
GITHUB_USER="sabar2001"
REPO_NAME="FairPay-docs"
SSH_KEY="${HOME}/.ssh/id_ed25519"
SSH_CONFIG="${HOME}/.ssh/config"

echo "=== FairPay-docs GitHub push setup ==="
echo ""

if [[ ! -f "${SSH_KEY}" ]]; then
  echo "Generating SSH key at ${SSH_KEY} ..."
  mkdir -p "${HOME}/.ssh"
  chmod 700 "${HOME}/.ssh"
  ssh-keygen -t ed25519 -C "sabarnimmagadda@gmail.com" -f "${SSH_KEY}" -N ""
fi

if ! grep -q "Host github.com" "${SSH_CONFIG}" 2>/dev/null; then
  echo "Adding github.com to ~/.ssh/config ..."
  cat >> "${SSH_CONFIG}" <<'EOF'

Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
  IdentitiesOnly yes
EOF
  chmod 600 "${SSH_CONFIG}"
fi

echo ""
echo "1) Add this SSH public key to GitHub (copy the whole line):"
echo "   https://github.com/settings/ssh/new"
echo ""
cat "${SSH_KEY}.pub"
echo ""
read -r -p "Press Enter after you have added the key on GitHub..."

echo ""
echo "2) Testing SSH to GitHub..."
ssh -T git@github.com || true

echo ""
echo "3) Creating public repo ${GITHUB_USER}/${REPO_NAME} (if gh is logged in) ..."
cd "${REPO_DIR}"
git remote set-url origin "git@github.com:${GITHUB_USER}/${REPO_NAME}.git"

if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  gh repo create "${GITHUB_USER}/${REPO_NAME}" --public --source=. --remote=origin --push
  echo "Done. Enable Pages: https://github.com/${GITHUB_USER}/${REPO_NAME}/settings/pages"
else
  echo "   gh not logged in. Create the repo manually:"
  echo "   https://github.com/new?name=${REPO_NAME}&visibility=public"
  echo ""
  read -r -p "Press Enter after you created the empty public repo on GitHub..."
  git push -u origin main
  echo ""
  echo "Done. Enable Pages: https://github.com/${GITHUB_USER}/${REPO_NAME}/settings/pages"
fi
