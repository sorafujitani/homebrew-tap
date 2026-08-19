class Hermes < Formula
  desc "Rust-native stateful shell workflows for Zsh"
  homepage "https://github.com/sorafujitani/hermes.zsh"
  url "https://github.com/sorafujitani/hermes.zsh/archive/c592a4054b6d02266f5ad71bb21537ed6508206a.tar.gz"
  version "0.1.0"
  sha256 "ed8a55895e7277dd94ab63ad5a545d91ff59902594b5ad040765e45374584b82"
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
