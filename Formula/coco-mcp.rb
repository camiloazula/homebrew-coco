class CocoMcp < Formula
  desc "Inspect and debug MCP servers in depth, from the command-line or a native window"
  homepage "https://github.com/camiloazula/coco-mcp"
  version "0.4.0"
  license any_of: ["MIT", "Apache-2.0"]

  # New versions are the GitHub releases of the main repository; each one
  # carries the archives below, built by its release workflow from the tag.
  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.4.0/coco-mcp-v0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "71bb506c14de8569d292eaca998584940b0304e10831cc737ccecbce6282189d"
    end
    on_intel do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.4.0/coco-mcp-v0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "7b5a2600382409ae7f5305d34fef500b62f5359568bed0739ef83a7e4407814e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.4.0/coco-mcp-v0.4.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c98782f210deaf3ab768ab51c229791d801f8983b60a014086f7656c6407ef5c"
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
