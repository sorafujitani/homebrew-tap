class Linearctl < Formula
  desc "Focused terminal UI for Linear"
  homepage "https://github.com/sorafujitani/linearctl"
  url "https://github.com/sorafujitani/linearctl/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "9a5b00f7ad1ea261c3e6b06b0589033941216df4d937f45bb232ff806d27cc65"
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
