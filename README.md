# Orlando Youth Alliance Website

The website for Orlando Youth Alliance (OYA), a 501(c)(3) nonprofit providing
a safe space for LGBTQ youth in Central Florida. This repo also produces the
chapter sites for Seminole, Lakeland, and Osceola.

## Stack

- [Eleventy](https://www.11ty.dev/) (v3) — static site generator, Nunjucks/Liquid templates
- [Tailwind CSS](https://tailwindcss.com/) (v4) — styling, compiled via the Tailwind CLI

## Chapters

The site supports multiple chapter "brands" from one codebase. Chapter info
(name, logo) lives in `src/_data/chapter.js`, selected at build time via the
`CHAPTER` env var (defaults to `orlando`):

- `orlando` — Orlando Youth Alliance (default)
- `seminole` — Seminole Youth Alliance
- `lakeland` — Lakeland Youth Alliance
- `osceola` — Osceola Youth Alliance

All chapters currently share the same content (`src/content/`) — only the
logo and site name change per chapter.

To override content for a specific chapter, place a file at
`src/content/<chapter>/<page>.md` (e.g. `src/content/seminole/about.md`).
This is not wired up yet — it would require a small change to the build to
prefer a chapter-specific file over the shared one when present.

## Deployment

GitHub Actions builds and deploys to GitHub Pages on every push to `main`:

- The default build (`npm run build-ghpages`) produces the root site at
  `orlandoyouthalliance.org`.
- `npm run build:seminole` / `build:lakeland` / `build:osceola` each build a
  chapter into its own subpath (`_site/seminole/`, etc.), with asset and
  internal links automatically prefixed for that subpath.
- The chapter domains (`seminoleyouthalliance.org`, etc.) use registrar-level
  domain forwarding to redirect to their corresponding
  `orlandoyouthalliance.org/<chapter>/` path.

## Quickstart

```bash
npm install
npm run serve
```

This watches Tailwind CSS and serves the site at `http://localhost:8080`.

To preview all chapters at once, each under its own subpath
(`/seminole/`, `/lakeland/`, `/osceola/`):

```bash
npm run serve:all
```
