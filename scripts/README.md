# Scripts

## Chapter Domain Redirects

The three chapter domains each redirect to their corresponding path on the main site:

| Chapter domain | Redirects to |
|---|---|
| seminoleyouthalliance.org | orlandoyouthalliance.org/seminole/ |
| lakelandyouthalliance.org | orlandoyouthalliance.org/lakeland/ |
| osceolayouthalliance.org | orlandoyouthalliance.org/osceola/ |

Each redirect is a standalone GitHub repo under the `orlando-youth-alliance` org (e.g. `orlando-youth-alliance/seminoleyouthalliance.org`). Each repo contains two files:

- `CNAME` — tells GitHub Pages which domain to serve
- `index.html` — a `<meta http-equiv="refresh">` redirect to the main site

### Step 1 — Create the repos

Run the script once. It creates all three repos, pushes the files, and enables GitHub Pages on each:

```zsh
scripts/create-chapter-redirects.sh
```

If Pages cannot be enabled automatically for any repo, the script will print a TODO box at the end with direct links to enable it manually (Settings → Pages → Source: main branch, root folder).

### Step 2 — Configure DNS

All three are apex domains, so use `A` records (not `CNAME`) at each registrar pointing to GitHub's IPs:

```
185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153
```

### Step 3 — Enforce HTTPS

Once DNS has propagated (allow up to 24 hours, often much faster), go to Settings → Pages in each repo and enable **Enforce HTTPS**. GitHub provisions the certificate automatically — if the button is greyed out, wait a few minutes and refresh.
