class CocoMcp < Formula
  desc "Inspect and debug MCP servers in depth, from the command-line or a native window"
  homepage "https://github.com/camiloazula/coco-mcp"
  version "0.7.0"
  license any_of: ["MIT", "Apache-2.0"]

  # New versions are the GitHub releases of the main repository; each one
  # carries the archives below, built by its release workflow from the tag.
  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.7.0/coco-mcp-v0.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "ed7c52f366c317930c43925baa9df3a7e1f45c102118aa5f95bb46660a12bd22"
    end
    on_intel do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.7.0/coco-mcp-v0.7.0-x86_64-apple-darwin.tar.gz"
      sha256 "de94cb8d66028594c8ed2044ea4d6cb3f00060670d40a43ae939293346888397"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.7.0/coco-mcp-v0.7.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "86f544dfc3dcd5c0d9c6e43de359e9a807755cf75bf3ce3e4b0e24e5faa95ad7"
    end

    # Shared libraries the window links at run time.
    depends_on "fontconfig"
    depends_on "freetype"
    depends_on "libxkbcommon"
    depends_on "vulkan-loader"
    depends_on "wayland"
  end

  # The one binary carries both modes, `coco-mcp --cli` and
  # `coco-mcp --desktop`; the archive holds it next to the licences.
  def install
    bin.install "coco-mcp"
    doc.install "README.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coco-mcp --version")
    assert_match "snapshot", shell_output("#{bin}/coco-mcp --cli --help")
  end
end
