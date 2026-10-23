class CocoMcp < Formula
  desc "Inspect and debug MCP servers in depth, from the command-line or a native window"
  homepage "https://github.com/camiloazula/coco-mcp"
  version "0.6.0"
  license any_of: ["MIT", "Apache-2.0"]

  # New versions are the GitHub releases of the main repository; each one
  # carries the archives below, built by its release workflow from the tag.
  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.6.0/coco-mcp-v0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "61a974a324c3c0be46a8dd92c7f7c247e84c7424340e1a4320dc1ed9f7f24a29"
    end
    on_intel do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.6.0/coco-mcp-v0.6.0-x86_64-apple-darwin.tar.gz"
      sha256 "c3f800712f2df38737739c36f51245de2ca30f65ac02e765039f9e4e7910b7a9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.6.0/coco-mcp-v0.6.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "08693a4a2e750bc95edec7736f683762be0d119ba51b96b8fd0321fe67d3dccb"
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
