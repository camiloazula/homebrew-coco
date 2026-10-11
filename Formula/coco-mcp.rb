class CocoMcp < Formula
  desc "Inspect and debug MCP servers in depth, from the command-line or a native window"
  homepage "https://github.com/camiloazula/coco-mcp"
  version "0.5.1"
  license any_of: ["MIT", "Apache-2.0"]

  # New versions are the GitHub releases of the main repository; each one
  # carries the archives below, built by its release workflow from the tag.
  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.5.1/coco-mcp-v0.5.1-aarch64-apple-darwin.tar.gz"
      sha256 "4cad885e4ceabfbbd598f5d82357003fb6e3e0711a211feecd52792f93a073a0"
    end
    on_intel do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.5.1/coco-mcp-v0.5.1-x86_64-apple-darwin.tar.gz"
      sha256 "3288ac459fa2093cccca82f0557613ec29c97c97e510273fbfeb09ddcb469edb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/camiloazula/coco-mcp/releases/download/v0.5.1/coco-mcp-v0.5.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1916a0ec023cf3b22954280336a3a2001a7721308bd6aae09a5292209c2057bf"
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
