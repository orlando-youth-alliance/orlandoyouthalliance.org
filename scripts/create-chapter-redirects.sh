#!/usr/bin/env zsh
set -euo pipefail

GH_ORG="orlando-youth-alliance"

typeset -A CHAPTERS=(
  seminole seminoleyouthalliance.org
  lakeland lakelandyouthalliance.org
  osceola osceolayouthalliance.org
)

pages_todo=()

for slug in ${(k)CHAPTERS}; do
  domain="${CHAPTERS[$slug]}"
  repo="$GH_ORG/${domain}"

  if gh repo view "$repo" &>/dev/null; then
    echo "==> Skipping $repo (already exists)"
    continue
  fi

  echo "==> Creating $repo for $domain → orlandoyouthalliance.org/$slug/"

  gh repo create "$repo" --public --description "Redirect $domain to orlandoyouthalliance.org/$slug/"

  tmpdir=$(mktemp -d)

  echo "$domain" > "$tmpdir/CNAME"

  cat > "$tmpdir/index.html" <<HTML
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="0; url=https://orlandoyouthalliance.org/${slug}/">
    <link rel="canonical" href="https://orlandoyouthalliance.org/${slug}/">
    <title>Redirecting…</title>
  </head>
  <body>
    <p>Redirecting… <a href="https://orlandoyouthalliance.org/${slug}/">Click here if not redirected.</a></p>
  </body>
</html>
HTML

  git -C "$tmpdir" init -b main
  git -C "$tmpdir" add CNAME index.html
  git -C "$tmpdir" commit -m "Add redirect to orlandoyouthalliance.org/${slug}/"
  git -C "$tmpdir" remote add origin "https://github.com/$repo.git"
  git -C "$tmpdir" push -u origin main
  rm -rf "$tmpdir"

  if ! gh api "repos/$repo/pages" \
      --method POST \
      --field 'source[branch]=main' \
      --field 'source[path]=/' &>/dev/null; then
    echo "    ⚠ Pages could not be enabled automatically for $repo"
    pages_todo+=("https://github.com/$repo/settings/pages")
  fi

  echo "    Done. Configure DNS for $domain:"
  echo "    - Apex A records (no www):"
  echo "      185.199.108.153, 185.199.109.153, 185.199.110.153, 185.199.111.153"
  echo ""
done

echo "All done."

if (( ${#pages_todo[@]} > 0 )); then
  echo ""
  echo "┌─ TODO ────────────────────────────────────────────────────────────┐"
  echo "│ Enable GitHub Pages manually for these repos, then enforce HTTPS: │"
  for url in "${pages_todo[@]}"; do
    echo "│  $url"
  done
  echo "└───────────────────────────────────────────────────────────────────┘"
else
  echo "Enable 'Enforce HTTPS' in each repo's Pages settings after DNS propagates."
fi
