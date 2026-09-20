# Instructions for Claude Code

Goal: publish this folder to GitHub Pages so the run sheet is public without sign-in.

1. `gh auth status` (ask the user to run `gh auth login` if needed).
2. `git init && git add index.html README.md CLAUDE.md supabase .gitignore && git commit -m "THD Visit run sheet"`
   - Never add `SECRETS.local.md`.
3. `gh repo create natalietran071-rgb/TTI-THD-Visit --public --source=. --push`
4. Enable Pages: `gh api -X POST repos/natalietran071-rgb/TTI-THD-Visit/pages -f "source[branch]=main" -f "source[path]=/"`
5. Wait for `gh api repos/natalietran071-rgb/TTI-THD-Visit/pages` to report `status: built`, then open the URL.
6. Report both links to the user (admin link from `SECRETS.local.md`).

Editing notes
- All app code is in `index.html` (vanilla JS, no build). Supabase URL + anon key near the bottom (`SB_URL`, `SB_KEY`).
- Module schema lives in the `M` object (events, cars, people, venues, restaurants); UI, editor, change log and Excel export are driven from it.
- People fields use a tag picker linked to the People module by full name; renaming a person cascades to all modules.
- Keep UI text in English; the owner (Natalie) prefers Vietnamese–English mix in chat, tables over prose.
