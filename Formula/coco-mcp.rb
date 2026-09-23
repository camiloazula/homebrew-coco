class CocoMcp < Formula
  desc "Inspect and debug MCP servers in depth, from the command-line or a native window"
  homepage "https://github.com/camiloazula/coco-mcp"
  version "0.3.1"
  license any_of: ["MIT", "Apache-2.0"]

  # New versions are the GitHub releases of the main repository; each one
  # carries the archives below, built by its release workflow from the tag.
  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.3.1/coco-mcp-v0.3.1-aarch64-apple-darwin.tar.gz"
      sha256 "345a464e2faf150ba95d8d5f12d02abefd3c3e1d42bdda6862f02d3d62969c81"
    end
    on_intel do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.3.1/coco-mcp-v0.3.1-x86_64-apple-darwin.tar.gz"
      sha256 "62046938e0a60ac6a260ae00706643a81a24b83d5f36c3a4768d0fd7dba92e7f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.3.1/coco-mcp-v0.3.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b3d703a7a1128a1df0a6376549d3c18cf2ded853402170ec73674edfbdfd47a8"
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
