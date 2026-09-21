class CocoMcp < Formula
  desc "Inspect and debug MCP servers in depth, from the command-line or a native window"
  homepage "https://github.com/camiloazula/coco-mcp"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  # New versions are the GitHub releases of the main repository; each one
  # carries the archives below, built by its release workflow from the tag.
  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.1.0/coco-mcp-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "1c7b4494f6eede27930445250783fa5b0cd4b304a747bcf0c00d18be8d2aad34"
    end
    on_intel do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.1.0/coco-mcp-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "51368ec0cccbfc830fc64058dfd4c058b2d32de01916b4f69a6299f74f3be27e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.1.0/coco-mcp-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5179c32df71b3a03098ff92465eef48cf991dd281d0de818ce6be2f56c754f51"
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
