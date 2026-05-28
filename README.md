# FairPay Docs (public)

Static pages for **App Store / Google Play** required URLs and **Supabase Auth** redirects. This repo is public so GitHub Pages works while the main [FairPay](https://github.com/sabar2001/FairPay) app repo stays private.

## Live URLs (after Pages is enabled)

| Page | URL |
|------|-----|
| Home | https://sabar2001.github.io/FairPay-docs/ |
| Support | https://sabar2001.github.io/FairPay-docs/support.html |
| Privacy | https://sabar2001.github.io/FairPay-docs/privacy.html |
| Auth callback | https://sabar2001.github.io/FairPay-docs/auth-callback.html |

## One-time GitHub setup

1. Create a **public** repo named `FairPay-docs` on GitHub (empty, no README).
2. Push this folder (see `scripts/push-to-github.sh` in the main FairPay repo, or run the commands below).
3. **Settings → Pages** → Source: **Deploy from a branch** → Branch: `main` → Folder: `/ (root)` → Save.
4. Wait ~1 minute, then open the Support URL above to confirm.

## Supabase (production project)

**Authentication → URL Configuration:**

| Field | Value |
|-------|--------|
| **Site URL** | `https://sabar2001.github.io/FairPay-docs/` |
| **Redirect URLs** | `https://sabar2001.github.io/FairPay-docs/auth-callback.html` |
| | `fairpay://auth-callback` |

The app sends confirmation emails to the HTTPS callback page, which forwards tokens into the app via `fairpay://auth-callback`.

## App Store Connect

- **Support URL:** `https://sabar2001.github.io/FairPay-docs/support.html`
- **Privacy Policy URL:** `https://sabar2001.github.io/FairPay-docs/privacy.html`

## Syncing from the private app repo

Source copies live in `FairPay/docs/` in the private repo. After editing support or privacy there, copy files into this repo and update canonical URLs to use `FairPay-docs`:

```bash
cp ../FairPay/docs/support.html ../FairPay/docs/privacy.html .
sed -i '' 's|github.io/FairPay/|github.io/FairPay-docs/|g' support.html privacy.html
git add -A && git commit -m "Sync support and privacy pages from FairPay" && git push
```
