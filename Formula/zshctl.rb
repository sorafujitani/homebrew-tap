class Zshctl < Formula
  desc "Rust-native stateful shell workflows for Zsh"
  homepage "https://github.com/sorafujitani/zshctl"
  url "https://github.com/sorafujitani/zshctl/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "d424b60321dfa6afb299b8f31c056f8a5f4d41f4aa560eaab1b14f46e8f8658c"
  license "MIT"

  head "https://github.com/sorafujitani/zshctl.git", branch: "main"

  depends_on "rust" => :build
  depends_on "fzf"
  depends_on "ghq"
  on_linux do
    depends_on "zsh"
  end

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/zshctl-cli")
    pkgshare.install "zshctl.zsh", "shells", "docs", "spec", "scripts"
  end

  def caveats
    <<~EOS
      Add zshctl to your Zsh startup file:

        source "#{opt_pkgshare}/zshctl.zsh"
        zshctl-bind-default-keys

      Then open a new shell and check the daemon:

        zshctl server status
    EOS
  end

  test do
    assert_match "Fast, stateful shell workflows for Zsh", shell_output("#{bin}/zshctl --help")
    assert_match version.to_s, shell_output("#{bin}/zshctl --version")
    assert_path_exists bin/"zshctld"
    assert_path_exists pkgshare/"zshctl.zsh"
  end
end
