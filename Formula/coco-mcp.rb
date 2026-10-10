class CocoMcp < Formula
  desc "Inspect and debug MCP servers in depth, from the command-line or a native window"
  homepage "https://github.com/camiloazula/coco-mcp"
  version "0.5.0"
  license any_of: ["MIT", "Apache-2.0"]

  # New versions are the GitHub releases of the main repository; each one
  # carries the archives below, built by its release workflow from the tag.
  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.5.0/coco-mcp-v0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "8ee28ac08aabdada3939c9147f17d7b95ceca7987507a7d5d9807d7f5d1415e3"
    end
    on_intel do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.5.0/coco-mcp-v0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "2945736a3a04bcdbb0a0aebb0b0e67e000a98e117acb0504233a36decdaafe26"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.5.0/coco-mcp-v0.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2744fc1d2f0c2dcff3e40722585d8428aa700fbcf47ec2dd8667790f33552363"
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
