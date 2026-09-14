class Linearctl < Formula
  desc "Focused terminal UI for Linear"
  homepage "https://github.com/sorafujitani/linearctl"
  url "https://github.com/sorafujitani/linearctl/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "974ad2712e1fa7d5c43b03c33ea873aa205ae1278738a88eb6b7ebcbb07e93f0"
  license "MIT"
  head "https://github.com/sorafujitani/linearctl.git", branch: "main"

  bottle do
    root_url "https://github.com/sorafujitani/homebrew-tap/releases/download/linearctl-v0.1.3"
    rebuild 1
    sha256 cellar: "/opt/homebrew/Cellar", arm64_sonoma: "094b505285a02bcb25c14996430b737bdad30d35b85e5c0bbc9527d711e06579"
    sha256 cellar: :any_skip_relocation, sequoia: "fd7c9d4c0b7cbfff26fe5b01f26113502b85bc81f75bdf52f6f1c758fc63158e"
  end

  depends_on "bun" => :build

  def install
    system "bun", "install", "--frozen-lockfile", "--ignore-scripts"
    system "bun", "run", "scripts/build.ts", "--outfile", bin/"linearctl"
  end

  test do
    assert_match "linearctl #{version}", shell_output("#{bin}/linearctl --version")
    assert_match "APP", shell_output("#{bin}/linearctl team list --mock")
  end
end
