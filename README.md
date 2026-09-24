# Homebrew tap for Coco MCP

The Homebrew formula for [Coco MCP](https://github.com/camiloazula/coco-mcp),
a tool for inspecting and debugging Model Context Protocol servers from the
command line or a native window.

```bash
brew install camiloazula/coco/coco-mcp
```

The formula installs the binary of the latest release, on macOS (arm64 and
x86_64) and Linux (x86_64), from the archives the main repository's release
workflow builds for each tag. `brew upgrade coco-mcp` follows new releases
once the formula is bumped, which happens with each release: the `bump`
workflow runs when the main repository's release workflow announces one, and
every hour as a fallback. It rewrites the version and each archive's URL and
sha256 from the release's `SHA256SUMS` (`scripts/bump.sh X.Y.Z`), downloads
every archive to check it, and merges the change through a pull request.

The formula and this file are under MIT OR Apache-2.0, as Coco MCP is.
