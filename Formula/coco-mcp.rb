class CocoMcp < Formula
  desc "Inspect and debug MCP servers in depth, from the command-line or a native window"
  homepage "https://github.com/camiloazula/coco-mcp"
  version "0.3.2"
  license any_of: ["MIT", "Apache-2.0"]

  # New versions are the GitHub releases of the main repository; each one
  # carries the archives below, built by its release workflow from the tag.
  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.3.2/coco-mcp-v0.3.2-aarch64-apple-darwin.tar.gz"
      sha256 "66cf94890a025b90206537f09919ca9b038d5972c87c74f24642682607913376"
    end
    on_intel do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.3.2/coco-mcp-v0.3.2-x86_64-apple-darwin.tar.gz"
      sha256 "8d13c04e0c4df5406408d68c235e5c76fb2fd107772177cbbc734011106048fb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.3.2/coco-mcp-v0.3.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d9f24cddce5b671650a7817a729eb185f84c4271d5466eb237d29326423400ac"
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
