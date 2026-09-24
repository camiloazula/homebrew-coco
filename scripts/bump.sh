#!/usr/bin/env bash
# bump.sh X.Y.Z: point Formula/coco-mcp.rb at release vX.Y.Z of the main
# repository. The version, each archive URL and its sha256 are rewritten from
# the release's SHA256SUMS; then every archive is downloaded and checked
# against the sum written for it, so a formula is never left pointing at a
# file that does not match. Needs `gh` and `curl`.
set -euo pipefail
version="${1:?usage: bump.sh X.Y.Z}"
root="$(cd "$(dirname "$0")/.." && pwd)"
formula="$root/Formula/coco-mcp.rb"
sums="$(mktemp)"
trap 'rm -f "$sums"' EXIT
gh release download "v$version" -R camiloazula/coco-mcp -p SHA256SUMS -O "$sums" --clobber

# Each `url` line names its target; the `sha256` line after it takes that
# archive's sum. Everything else in the formula is left as it is.
awk -v version="$version" -v sums="$sums" '
  BEGIN {
    while ((getline line < sums) > 0) {
      split(line, f, /[ \t]+/)
      if (f[2] != "") sum[f[2]] = f[1]
    }
  }
  /^  version "/ { sub(/"[^"]*"/, "\"" version "\""); print; next }
  /url "https:\/\/github.com\/camiloazula\/coco-mcp\/releases\/download\// {
    match($0, /coco-mcp-v[^"]*-[a-z0-9_]+-[a-z0-9_]+-[a-z0-9_]+(-[a-z0-9_]+)?\.(tar\.gz|zip)/)
    old = substr($0, RSTART, RLENGTH)
    target = old
    sub(/^coco-mcp-v[^-]*-/, "", target)
    file = "coco-mcp-v" version "-" target
    if (!(file in sum)) { print "no sum for " file > "/dev/stderr"; exit 1 }
    indent = $0; sub(/url.*/, "", indent)
    print indent "url \"https://github.com/camiloazula/coco-mcp/releases/download/v" version "/" file "\""
    pending = sum[file]
    next
  }
  /^ *sha256 "/ && pending != "" {
    sub(/"[^"]*"/, "\"" pending "\""); pending = ""; print; next
  }
  { print }
' "$formula" > "$formula.new"
mv "$formula.new" "$formula"

# Every archive the formula now names, downloaded and checked.
grep -E '^\s*(url|sha256) "' "$formula" | paste - - | while read -r _ url _ sha; do
  url="${url//\"/}"; sha="${sha//\"/}"
  got="$(curl -fsSL "$url" | sha256sum | cut -d' ' -f1)"
  if [ "$got" != "$sha" ]; then
    echo "::error::$url has sha256 $got, the formula says $sha" >&2
    exit 1
  fi
  echo "checked $url"
done
