class Linearctl < Formula
  desc "Focused terminal UI for Linear"
  homepage "https://github.com/sorafujitani/linearctl"
  url "https://github.com/sorafujitani/linearctl/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "974ad2712e1fa7d5c43b03c33ea873aa205ae1278738a88eb6b7ebcbb07e93f0"
  license "MIT"
  head "https://github.com/sorafujitani/linearctl.git", branch: "main"

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
