# Harness Demo Site

A locally-hostable branded demo portal for Harness SE presentations. Rebrand for any customer in seconds — no code changes required.

## 🚀 Running Locally

**Option A — Python (no install needed):**
```bash
cd harness-demo
python3 -m http.server 8080
# Open http://localhost:8080
```

**Option B — Node.js:**
```bash
npx serve harness-demo
```

**Option C — VS Code Live Server extension:**
Right-click `index.html` → "Open with Live Server"

---

## 🎨 Rebranding for a Customer Demo

### Option 1 — In-browser rebrand panel (recommended)

Once the site is running, click the **⚙ Rebrand** button in the bottom-right corner of any page. A panel will prompt for three inputs:

| Input | Example | Effect |
|---|---|---|
| **Company name** | `Barclays` | Updates the logo label and page titles across all pages |
| **Website domain** | `barclays.com` | Fetches the company logo (Clearbit → Google → initials fallback), sets the browser favicon, and pre-fills the login email as `demo@domain` |
| **Industry** | `Finance / Banking` | Swaps the full colour palette and sets a matching welcome tagline |

**Industry presets:**
| Industry | Primary colour | Accent | Tagline |
|---|---|---|---|
| Technology / SaaS | Green `#1CC47E` | Indigo | *Ready to build something great today?* |
| Finance / Banking | Navy `#0057B8` | Gold | *Your numbers are looking sharp.* |
| Healthcare | Teal `#10B981` | Purple | *Good to have you back.* |
| Retail / E-commerce | Orange `#FF6B35` | Indigo | *Plenty to explore — let's get started.* |
| Automotive | Red `#E53E3E` | Steel | *Everything's running smoothly.* |

Branding is saved to `localStorage` and persists as you navigate between pages. **Reset to default** clears it and reverts to `theme.css`.

---

### Option 2 — Edit theme.css directly (or tell Claude)

**Tell Claude:**
> "Rebrand the demo for Barclays, domain barclays.com, finance industry."

Claude will update `theme.css` — every page reads from it automatically.

**Key variables:**
| Variable | What it controls |
|---|---|
| `--company-name` | Name shown in nav and login |
| `--company-domain` | Domain used to auto-fetch the logo |
| `--company-tagline` | Fallback tagline (used when no industry is selected) |
| `--color-primary` | Buttons, links, active states |
| `--color-accent` | Secondary highlights, avatar backgrounds |
| `--color-bg` | Page background |
| `--color-bg-surface` | Card and nav backgrounds |
| `--font-display` | Headings and logo font |
| `--font-body` | All body text |

---

## 📁 File Structure

```
harness-demo/
├── theme.css           ← ✏️  Default branding (name, domain, colours, fonts)
├── base.css            ← Shared components (buttons, forms, badges)
├── brand.js            ← Reads theme.css on load, fetches logo, updates name
├── rebrand-panel.js    ← ⚙ Rebrand button, panel UI, industry presets
├── index.html          ← Login page
├── home.html           ← Post-login home (cards + interactive modals)
└── README.md
```

---

## 💡 Demo Flow

1. **Open** `index.html` — branded login portal
2. **Sign in** — 1.2s animation, redirects to home
3. **Home page** — three interactive cards:
   - **Quick Start** — toggleable onboarding checklist
   - **Highlights** — key metrics and a weekly activity chart
   - **Connect** — toggle integrations on/off (Slack, GitHub, Jira, Salesforce…)
4. **Sign out** — returns to the login page

### Tips
- Use **⚙ Rebrand** right before a call to set the customer's branding live
- The login email, browser favicon, and logo all update automatically from the domain — nothing to configure manually
- The "Demo Mode" banner on the login page can be removed for cleaner screenshots
