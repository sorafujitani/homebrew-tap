class Linearctl < Formula
  desc "Focused terminal UI for Linear"
  homepage "https://github.com/sorafujitani/linearctl"
  url "https://github.com/sorafujitani/linearctl/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "ea3dc7f390259fe65af8f4470ce0fdb3c2f333a8128f7f97da37eae6a4596a4b"
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
