class Hermes < Formula
  desc "Rust-native stateful shell workflows for Zsh"
  homepage "https://github.com/sorafujitani/hermes.zsh"
  url "https://github.com/sorafujitani/hermes.zsh/archive/7dd206db576700045bf2e683c453839cabc3b469.tar.gz"
  version "0.1.0"
  sha256 "92ebc14404e55f1499c66b2f2b59dc3e62aae62a07a3a9c0f76625673c6db776"
  license "MIT"

  head "https://github.com/sorafujitani/hermes.zsh.git", branch: "main"

  depends_on "rust" => :build
  depends_on "fzf"
  depends_on "ghq"
  on_linux do
    depends_on "zsh"
  end

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/hermes-cli")
    pkgshare.install "hermes.zsh", "shells", "docs", "spec", "scripts"
  end

  def caveats
    <<~EOS
      Add Hermes to your Zsh startup file:

        source "#{opt_pkgshare}/hermes.zsh"
        hermes-bind-default-keys

      Then open a new shell and check the daemon:

        hermes server status
    EOS
  end

  test do
    assert_match "Fast, stateful shell workflows for Zsh", shell_output("#{bin}/hermes --help")
    assert_match "0.1.0", shell_output("#{bin}/hermes --version")
  end
end
