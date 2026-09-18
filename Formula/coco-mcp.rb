class CocoMcp < Formula
  desc "Inspect and debug MCP servers in depth, from the command line or a native window"
  homepage "https://github.com/camiloazula/coco-mcp"
  url "https://github.com/camiloazula/coco-mcp/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f748f2a8b0c0923d7c1c07024297bda2b9029187783c7c0c35143303448ae84e"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/camiloazula/coco-mcp.git", branch: "main"

  # New versions are the GitHub releases of the main repository.
  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build

  on_linux do
    depends_on "pkg-config" => :build
    depends_on "fontconfig"
    depends_on "freetype"
    depends_on "libxkbcommon"
    depends_on "vulkan-loader"
    depends_on "wayland"
  end

  # Built from source on the user's machine, as `cargo install` does: the
  # project ships no prebuilt binaries. The one binary carries both modes,
  # `coco-mcp --cli` and `coco-mcp --desktop`.
  def install
    system "cargo", "install", *std_cargo_args(path: "apps/desktop")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coco-mcp --version")
    assert_match "snapshot", shell_output("#{bin}/coco-mcp --cli --help")
  end
end
