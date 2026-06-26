# app-for-harness-demo

An application to rebrand for bespoke Harness SE demos. Designed to run as a Docker container with branding baked in at build time via the Harness CI/CD pipeline — or rebranded live in the browser during a demo.

---

## Suggested Demo Approach

### 1. Before the demo — prepare the branding

Confirm the customer's company name, domain, and industry, then update the pipeline variables in Harness before the call:

- Open the pipeline in Harness Pipeline Studio
- Update the pipeline variables: `BRAND_NAME`, `BRAND_DOMAIN`, `BRAND_INDUSTRY`

### 2. During the demo — show the running application

Open the app in the browser and walk through the branded experience:

- Login page shows the customer's logo and colour theme
- Home page surfaces industry-specific modules (incidents for tech, account for finance, patient admission for healthcare, etc.)
- Use the **⚙ Rebrand** panel to make live adjustments if needed — useful for showing how quickly the experience can be tailored

This gives the customer a tangible, familiar-feeling product to anchor the rest of the demo.

### 3. During the demo — build the pipeline from scratch in Harness

With the app as the working artefact, open a blank canvas in Harness Pipeline Studio and build the end-to-end pipeline live, introducing each module as you go:

| Step | Harness Module | What to show |
|---|---|---|
| **Source** | Harness Code | Host the repo in Harness Code, trigger the pipeline on push |
| **Build** | Harness CI | Build the Docker image using Harness Cloud-hosted runners, pass `BRAND_*` build args |
| **Artifact** | Harness Artifact Registry (HAR) | Push the image to HAR, show versioned artifact storage |
| **Security** | STO (Security Testing Orchestration) | Scan the image for vulnerabilities, gate the pipeline on severity thresholds |
| **Deploy** | Harness CD | Deploy the image to a target Kubernetes cluster using the manifests in `k8s/`, show rollback capability |

Building the pipeline live — rather than showing a pre-built one — lets the customer see how quickly Harness connects each stage and makes the platform feel approachable rather than pre-scripted.

---

## Running Locally

**Option A — Docker (recommended):**
```bash
docker build -t app-for-harness-demo .
docker run -p 8080:80 app-for-harness-demo
# Open http://localhost:8080
```

**Option B — Python (no install needed):**
```bash
python3 -m http.server 8080
# Open http://localhost:8080
```

**Option C — VS Code Live Server extension:**
Right-click `index.html` → "Open with Live Server"

---

## Build-time Branding (Harness Pipeline)

Branding is injected at Docker build time via build arguments. In your Harness CI pipeline, pass pipeline variables to the Docker build step:

```bash
docker build \
  --build-arg BRAND_NAME="Acme Corp" \
  --build-arg BRAND_DOMAIN="acme.com" \
  --build-arg BRAND_INDUSTRY="finance" \
  -t app-for-harness-demo .
```

In a Harness pipeline, reference pipeline variables using Harness expressions:

```
--build-arg BRAND_NAME=<+pipeline.variables.BRAND_NAME>
--build-arg BRAND_DOMAIN=<+pipeline.variables.BRAND_DOMAIN>
--build-arg BRAND_INDUSTRY=<+pipeline.variables.BRAND_INDUSTRY>
```

**Available industries:** `technology` · `finance` · `healthcare` · `retail` · `automotive`

If no build args are supplied, the image defaults to **Harness · harness.io · technology**.

---

## Runtime Rebranding (Live Demo Panel)

During a demo, click the **⚙ Rebrand** button in the bottom-right corner of any page to override branding on the fly without rebuilding.

| Input | Example | Effect |
|---|---|---|
| **Company name** | `Barclays` | Updates the logo label and page titles |
| **Website domain** | `barclays.com` | Fetches the company logo, sets the favicon, pre-fills login email |
| **Industry** | `Finance / Banking` | Swaps the full colour palette and welcome tagline |

**Industry presets:**
| Industry | Primary colour | Accent | Tagline |
|---|---|---|---|
| Technology / SaaS | Green `#1CC47E` | Indigo | *Ready to build something great today?* |
| Finance / Banking | Navy `#0057B8` | Gold | *Your numbers are looking sharp.* |
| Healthcare | Teal `#10B981` | Purple | *Good to have you back.* |
| Retail / E-commerce | Orange `#FF6B35` | Indigo | *Plenty to explore — let's get started.* |
| Automotive | Red `#E53E3E` | Steel | *Everything's running smoothly.* |

Branding is saved to `localStorage` and persists across pages. **Reset to default** reverts to the build-time branding.

---

## File Structure

```
app-for-harness-demo/
├── Dockerfile          ← Accepts BRAND_NAME, BRAND_DOMAIN, BRAND_INDUSTRY build args
├── .dockerignore
├── k8s/
│   ├── deployment.yaml ← Kubernetes Deployment (1 replica, nginx container)
│   └── service.yaml    ← Kubernetes Service (LoadBalancer, port 80)
├── brand-config.js     ← Placeholder values replaced at build time by Dockerfile
├── brand.js            ← Reads brand-config.js on load, fetches logo, updates name
├── rebrand-panel.js    ← ⚙ Rebrand button, panel UI, industry presets
├── theme.css           ← Default colours, fonts, spacing
├── base.css            ← Shared components (buttons, forms, badges)
├── index.html          ← Login page
├── home.html           ← Post-login home (cards + interactive modals)
└── README.md
```

---

## Kubernetes Deployment

The `k8s/` directory contains manifests for deploying to a Kubernetes cluster.

**Apply manually:**
```bash
kubectl apply -f k8s/
```

**With Harness CD:**

In your Harness CD stage, point the manifest source at the `k8s/` folder in this repo. Harness will pull the manifests and substitute the image with the artifact built by the CI stage — no manual image tag updates needed.

The `deployment.yaml` image field is overridden by Harness CD at deploy time using the artifact reference from the pipeline. The image is hosted in Harness Artifact Registry:

```yaml
image: pkg.harness.io/eerjnxtns4grlg5vnnjzuw/branded-app-registry/app-for-harness-demo:<tag>
```

---

## Demo Flow

1. **Open** `index.html` — branded login portal
2. **Sign in** — 1.2s animation, redirects to home
3. **Home page** — three interactive cards that adapt to the selected industry
4. **Sign out** — returns to the login page

### Industry-specific modules

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
Live deposit/withdraw against a running balance with a colour-coded transaction list.

#### Incidents *(Technology / SaaS)*
Live incident feed across five services. Every 8 seconds an active incident advances through its lifecycle — *investigating* → *identified* → *monitoring* → *resolved* — so the feed changes in real time during the demo.

#### Patient Admission *(Healthcare)*
Registration form that generates admission references and builds a running admissions list with priority indicators.

#### Basket *(Retail / E-commerce)*
Six-product grid with quantity controls, live basket summary, and grand total.

---

## Tips
- Build the image with the customer's branding before a call so it's ready to go
- Use **⚙ Rebrand** for last-minute changes without a rebuild
- The login email, favicon, and logo all derive from the domain — nothing to configure manually
- The "Demo Mode" banner on the login page can be removed for cleaner screenshots
