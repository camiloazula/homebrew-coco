class CocoMcp < Formula
  desc "Inspect and debug MCP servers in depth, from the command-line or a native window"
  homepage "https://github.com/camiloazula/coco-mcp"
  version "0.6.1"
  license any_of: ["MIT", "Apache-2.0"]

  # New versions are the GitHub releases of the main repository; each one
  # carries the archives below, built by its release workflow from the tag.
  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.6.1/coco-mcp-v0.6.1-aarch64-apple-darwin.tar.gz"
      sha256 "50fd9dc79e145853e4a1f34f1b50da1ee959f538541311a46d164a1f75ab02b6"
    end
    on_intel do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.6.1/coco-mcp-v0.6.1-x86_64-apple-darwin.tar.gz"
      sha256 "c9a06225635e1602a56e692e6c121145fae65f5982e22616e1099bbe48705a2c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.6.1/coco-mcp-v0.6.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d44a12a4207fa5da15fca62536ca4dad6a5d1f8a88523b929ceb38b4fb2f4823"
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
