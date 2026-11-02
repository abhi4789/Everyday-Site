# Everyday — website

Static site (plain HTML/CSS, no JavaScript, no build step, no cookies or analytics) for GitHub Pages.

```
index.html          Home            /
privacy/index.html  Privacy Policy  /privacy/
support/index.html  Support         /support/
assets/             style.css, self-hosted Kalam (woff2) + OFL.txt license, icons
.nojekyll           tells GitHub Pages to serve files as-is
check.sh            lists placeholders / owner-confirm notes and checks links
```

All links are relative, so the site works at a user site (`you.github.io`), a project site (`you.github.io/everyday-site/`) or a custom domain.

## Preview locally

```bash
cd "Everyday-Website"
python3 -m http.server 8000
# open http://localhost:8000
```

## Before publishing

```bash
./check.sh
```

It should report no placeholders and no broken links. When the App Store listing is live, replace the `<span class="badge">Coming soon to the App Store</span>` in `index.html` with `<a class="badge" href="YOUR_APP_STORE_URL">Download on the App Store</a>` (using the real URL), then re-run it. Open decisions are tracked in `OWNER-REVIEW.md`.

## Deploy (GitHub Pages)

1. Put the contents of this folder in its own repository (the iOS project stays separate), e.g. `everyday-site`, with `index.html` at the repo root.
2. `git init && git add . && git commit -m "Everyday website" && git branch -M main`
3. Create an empty GitHub repo, then `git remote add origin <url> && git push -u origin main`.
4. GitHub → repo **Settings → Pages → Build and deployment → Source: Deploy from a branch → Branch: `main` / `/ (root)` → Save**.
5. Wait about a minute. The site appears at `https://<user>.github.io/<repo>/`. Tick **Enforce HTTPS**.
6. Use `…/privacy/` and `…/support/` as the Privacy Policy URL and Support URL in App Store Connect.
7. Optional custom domain: Settings → Pages → Custom domain, then add a CNAME (or A/AAAA) record at your DNS host as GitHub instructs.
