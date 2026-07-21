# FairPay Docs (public)

Static pages for **App Store / Google Play** required URLs and **Supabase Auth** redirects. This repo is public while the main [FairPay](https://github.com/sabar2001/FairPay) app repo stays private.

**Canonical site:** [https://docs.fairpay.nimtech.xyz](https://docs.fairpay.nimtech.xyz) (Render deployment from this repo).

## Live URLs

| Page | URL |
|------|-----|
| Home | https://docs.fairpay.nimtech.xyz/ |
| Marketing | https://docs.fairpay.nimtech.xyz/marketing.html |
| Support | https://docs.fairpay.nimtech.xyz/support.html |
| Privacy | https://docs.fairpay.nimtech.xyz/privacy.html |
| Terms | https://docs.fairpay.nimtech.xyz/terms.html |
| Auth callback | https://docs.fairpay.nimtech.xyz/auth-callback.html |

GitHub Pages (`https://sabar2001.github.io/FairPay-docs/`) may remain as a legacy mirror. Do not use it in app code, store listings, or Supabase configuration.

## Supabase (production project)

**Authentication → URL Configuration:**

| Field | Value |
|-------|--------|
| **Site URL** | `https://docs.fairpay.nimtech.xyz/` |
| **Redirect URLs** | `https://docs.fairpay.nimtech.xyz/auth-callback.html` |
| | `fairpay://auth-callback` |
| **Legacy redirect (keep until App Store users upgrade)** | `https://sabar2001.github.io/FairPay-docs/auth-callback.html` |

The app sends confirmation emails to the HTTPS callback page, which forwards tokens into the app via `fairpay://auth-callback`.

## App Store Connect / Google Play

- **Support URL:** `https://docs.fairpay.nimtech.xyz/support.html`
- **Privacy Policy URL:** `https://docs.fairpay.nimtech.xyz/privacy.html`

## Syncing from the private app repo

Source copies live in `FairPay/docs/` in the private repo. After editing support or privacy there, run:

```bash
../FairPay/scripts/sync-fairpay-docs.sh
```

That script copies the HTML into this repo, rewrites canonical URLs to the custom domain, and pushes when a git remote is configured.
