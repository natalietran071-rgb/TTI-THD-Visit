# THD Visit Vietnam – Run Sheet

Single-page run sheet for the Home Depot executive visit (20–25 Sep 2026).
Static `index.html` + Supabase for live shared data. No build step.

## Links
| Mode | URL |
|---|---|
| View only (share with everyone) | `https://tti-thd-visit.vercel.app/` |
| GitHub Pages mirror (once Pages is enabled) | `https://natalietran071-rgb.github.io/TTI-THD-Visit/` |
| Admin edit | same URL + `#edit=<code>` (code in `SECRETS.local.md`, never committed) |

## How it works
- **Data**: Supabase project `ryobi-orgchart-app` (ref `hivklrirmsxkpjozoqwd`), table `public.thd_records`
  (`collection` = events | people | cars | venues | restaurants, `id`, `data` jsonb). Schema: `supabase/schema.sql`.
- **Read**: anyone, via anon key + RLS select policy. Live updates via Supabase Realtime.
- **Write**: only through RPC `thd_save(p_token, ...)`; the token's SHA-256 is checked against `thd_settings`.
  The anon key in `index.html` is public by design and cannot write without the edit code.
- **Excel export**: in-browser with ExcelJS (5 original sheets + Cars + Change Log).
- **Car trips** (Transportation sheet) are derived from each event's cars + each car's driver/PIC.

## Deploy
**Vercel (primary)**: project `tti-thd-visit` in team `natalietran071-5454's projects`, imported from this repo.
Preset *Other*, no build command, root `./`. Every push to `claude/practical-volta-ozx2y1` (the default branch) redeploys production.

**GitHub Pages (optional mirror)**
1. Repo: `natalietran071-rgb/TTI-THD-Visit` (public).
2. Push `index.html`, `README.md`, `supabase/`, `.gitignore` to the default branch.
3. One-time: Settings → Pages → Source → **GitHub Actions**. Then Actions → “Deploy to GitHub Pages” → Re-run (or push any change).
   `.github/workflows/pages.yml` publishes `index.html` on every push after that.
4. Open the view URL; header badge should say **View only** and status **Live, view only**.
5. Open the admin URL; badge should say **Edit link**.

## Maintenance
- Rotate edit code: `supabase/rotate-edit-token.sql`.
- Supabase Free pauses projects after ~1 week idle; resume from the dashboard if the page shows "Couldn't reach the data service".
- Security advisor warnings about SECURITY DEFINER functions `thd_save` / `thd_check_token` are expected (token-guarded).
