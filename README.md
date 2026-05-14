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

Once the site is running, click the **⚙ Rebrand** button in the bottom-right corner of any page. The panel header shows the currently active branding so you can verify inputs before making changes. Update any of the three fields and click **Apply Branding**:

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

Branding is saved to `localStorage` and persists as you navigate between pages. **Reset to default** clears it and reverts to the `theme.css` defaults (Harness · harness.io · Technology / SaaS).

---

### Option 2 — Edit theme.css directly (or tell Claude)

The site defaults to **Harness · harness.io · Technology / SaaS**. To change the defaults, tell Claude:
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
3. **Home page** — three interactive cards that adapt to the selected industry (see below)
4. **Sign out** — returns to the login page

### Industry-specific modules

One card swaps out automatically when you change industry, replacing the generic module with something relevant to that vertical.

| Industry | Card 1 | Card 2 | Card 3 |
|---|---|---|---|
| **Technology / SaaS** | Quick Start | Highlights | **Incidents** |
| **Finance / Banking** | **Account** | Highlights | Connect |
| **Healthcare** | **Patient Admission** | Highlights | Connect |
| **Retail / E-commerce** | **Basket** | Highlights | Connect |
| **Automotive** | Quick Start | Highlights | Connect |

#### Quick Start
Toggleable onboarding checklist — mark steps complete as you walk through setup.

#### Highlights
Key metrics (active users, uptime, response time, events) and a weekly activity bar chart.

#### Connect
Toggle integrations on/off (Slack, GitHub, Jira, Salesforce, Google, Datadog).

#### Account *(Finance)*
Live deposit/withdraw against a running balance. Transactions appear in a recent activity list with colour-coded in/out indicators.

#### Incidents *(Technology / SaaS)*
Live incident response feed across five services (Payment, Auth, API Gateway, Database, CDN). A system-status banner reflects the worst current state (investigating → degraded → all clear). Every 8 seconds an active incident automatically advances one step through the lifecycle — from *investigating* → *identified* → *monitoring* → *resolved* — so the feed changes in real time during the demo. A badge on the card shows the active incident count.

#### Patient Admission *(Healthcare)*
Registration form with first/last name, date of birth, gender, ward/department, presenting complaint, and a three-way priority toggle (Routine / Urgent / Emergency, each colour-coded). Submitting generates an admission reference (e.g. `ADM-00424`), flashes a confirmation on the button, resets the form, and appends the entry to a "Today's Admissions" list showing initials, ward, priority, time, and reference. The card badge tracks the running admission count.

#### Basket *(Retail / E-commerce)*
Six-product grid with −/+ quantity controls. A live basket summary below shows each line item, quantity, and subtotal, with a running grand total. A Checkout button clears the basket. The card badge shows total items in the basket and updates on every change.

### Tips
- Use **⚙ Rebrand** right before a call to set the customer's branding live — the industry-specific card swaps in automatically
- The login email, browser favicon, and logo all update from the domain — nothing to configure manually
- The "Demo Mode" banner on the login page can be removed for cleaner screenshots
