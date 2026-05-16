# TnT Handicap Calculator

A Blazor WebAssembly PWA for calculating team golf handicaps in a Two-person Net Team (TnT) format.

---

## What It Does

The app calculates **course handicaps** for two players and combines them into a **team handicap**, accounting for each player's GHIN Handicap Index, the tee they play from, and an allowance percentage applied to each player's contribution.

### Inputs

| Field | Description |
|---|---|
| Player A / B GHIN Index | Each player's USGA Handicap Index (supports + handicaps via checkbox) |
| +HCP checkbox | Check if a player is a plus handicapper — the index is treated as negative in the formula |
| Allowance % (A / B) | The percentage of each player's course handicap that counts toward the team total (defaults: 35% / 15%) |
| Holes | 18-hole, Front 9, or Back 9 |

### Course Handicap Formula

**18-hole:**
```
CH = Index × (Slope ÷ 113) + (CR − 72)
```

**9-hole (Front or Back):**
```
CH = (Index ÷ 2) × (Slope ÷ 113) + (CR − 36)
```

**Team Handicap:**
```
Team = Round(CH_A × Allowance_A% + CH_B × Allowance_B%)
```

### Course Data

The app has rating and slope data hard-coded for **11 tees** at a single course:

| Tee | 18-hole CR | 18-hole Slope |
|---|---|---|
| Black | 74.5 | 142 |
| Black/Gold | 73.4 | 137 |
| Gold | 72.2 | 136 |
| Gold/Blue | 70.8 | 135 |
| Blue | 69.9 | 128 |
| Blue/White | 68.9 | 124 |
| White | 67.5 | 122 |
| White/Green | 65.6 | 114 |
| Green | 64.5 | 108 |
| Green/Orange | 61.9 | 100 |
| Orange | 61.0 | 97 |

Front 9 and Back 9 rating/slope data is also embedded for each tee.

### Output

- **Formula panel** — shows the exact formula with the entered values substituted in
- **Player course handicap table** — CH and weighted contribution for each tee combination
- **Team handicap matrix** — an 11×11 grid showing the rounded team handicap for every A-tee / B-tee combination

---

## Tech Stack

- **.NET 9 Blazor WebAssembly** — runs entirely in the browser, no server required
- **PWA** — installable on desktop and mobile via the browser's "Add to Home Screen" / "Install" prompt
- **No external data dependencies** — all course data is baked into the app

---

## Running Locally

```bash
dotnet watch
```

Opens the app at `http://localhost:5255` with hot reload enabled.

---

## Deployment

The app is hosted on **GitHub Pages** at:

```
https://coreysewall.github.io/tnt-handicap/
```

### How to redeploy after changes

1. **Publish a release build:**
   ```bash
   dotnet publish -c Release -o publish
   ```

2. **Replace the `docs/` folder** with the contents of `publish/wwwroot/`:
   ```powershell
   Remove-Item docs\* -Recurse -Force
   Copy-Item publish\wwwroot\* docs\ -Recurse
   ```

3. **Commit everything** (source changes + updated `docs/`):
   ```bash
   git add -A
   git commit -m "Deploy: <description of changes>"
   ```

4. **Push to GitHub:**
   ```bash
   git push
   ```

GitHub Pages automatically picks up changes to the `docs/` folder on the `main` branch within a minute or two.

### How GitHub Pages is configured

- Repository: `github.com/coreysewall/tnt-handicap`
- Pages source: `main` branch, `/docs` folder
- The `docs/index.html` has `<base href="/tnt-handicap/" />` which matches the Pages URL path
