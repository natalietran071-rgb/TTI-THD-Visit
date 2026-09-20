# Instructions for Claude Code

Goal: publish this folder to GitHub Pages so the run sheet is public without sign-in.

Current state
- Repo `natalietran071-rgb/TTI-THD-Visit` holds `index.html`, `README.md`, `supabase/`, `.gitignore`, `.github/workflows/pages.yml`.
- Never add `SECRETS.local.md`.
- `pages.yml` deploys `index.html` to GitHub Pages on push. It needs Pages enabled once with Source = **GitHub Actions**
  (Settings → Pages); the Actions token cannot create the Pages site itself. After enabling, re-run the workflow.
- Pages URL: `https://natalietran071-rgb.github.io/TTI-THD-Visit/` (admin link = same URL + `#edit=<code>` from `SECRETS.local.md`).

Editing notes
- All app code is in `index.html` (vanilla JS, no build). Supabase URL + anon key near the bottom (`SB_URL`, `SB_KEY`).
- Module schema lives in the `M` object (events, cars, people, venues, restaurants); UI, editor, change log and Excel export are driven from it.
- People fields use a tag picker linked to the People module by full name; renaming a person cascades to all modules.
- Keep UI text in English; the owner (Natalie) prefers Vietnamese–English mix in chat, tables over prose.
