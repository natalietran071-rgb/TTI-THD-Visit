# Instructions for Claude Code

Goal: keep the run sheet public without sign-in. Live at https://tti-thd-visit.vercel.app/ (Vercel, auto-deploys on push).

Current state
- Repo `natalietran071-rgb/TTI-THD-Visit` holds `index.html`, `README.md`, `supabase/`, `.gitignore`, `.github/workflows/pages.yml`.
- Never add `SECRETS.local.md`.
- `pages.yml` deploys `index.html` to GitHub Pages on push. It needs Pages enabled once with Source = **GitHub Actions**
  (Settings → Pages); the Actions token cannot create the Pages site itself. After enabling, re-run the workflow.
- Pages URL: `https://natalietran071-rgb.github.io/TTI-THD-Visit/` (admin link = same URL + `#edit=<code>` from `SECRETS.local.md`).

Editing notes
- All app code is in `index.html` (vanilla JS, no build). Supabase URL + anon key near the bottom (`SB_URL`, `SB_KEY`).
- Module schema lives in the `M` object (events, cars, people, venues, restaurants); UI, editor, change log and Excel export are driven from it.
- Co-editing: Supabase Realtime Presence on channel `thd-presence` (editors only). `PEERS` drives the `#who` bar, the `… editing` badges (`editBtn`) and `liveWarn()` in the dialog; `liveCheck()` flags a record changed underneath an open editor.
- Venues: `venueCard()` + map helpers (`mapQuery`, `mapOpenUrl`, `mapEmbedUrl`); photos upload via `SBC.storage` to bucket `thd-photos` (policies in `supabase/schema.sql`), stored as a `; `-joined URL list in `photos`.
- People fields use a tag picker linked to the People module by full name; renaming a person cascades to all modules.
- Keep UI text in English; the owner (Natalie) prefers Vietnamese–English mix in chat, tables over prose.
