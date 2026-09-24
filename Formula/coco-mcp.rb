class CocoMcp < Formula
  desc "Inspect and debug MCP servers in depth, from the command-line or a native window"
  homepage "https://github.com/camiloazula/coco-mcp"
  version "0.2.0"
  license any_of: ["MIT", "Apache-2.0"]

  # New versions are the GitHub releases of the main repository; each one
  # carries the archives below, built by its release workflow from the tag.
  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.2.0/coco-mcp-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "7bb525e66ca462daa6c523b2abc060c2ceb6f0ba52660b44d744726b801980a9"
    end
    on_intel do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.2.0/coco-mcp-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "00d7243a36184d16cefdc6f3d8d50408b6d12f9af6105c6bc497e5a3ccb73568"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.2.0/coco-mcp-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bf73dd3507173c5bcaede72169fdb3c5be2d0a2e882b0410f9ca81b9a8858696"
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
