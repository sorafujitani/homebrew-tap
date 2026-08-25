class Zshctl < Formula
  desc "Rust-native stateful shell workflows for Zsh"
  homepage "https://github.com/sorafujitani/zshctl"
  url "https://github.com/sorafujitani/zshctl/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "b897d094f7f95dcb04a46d6297ee2e6a280e95400d0ff70142522b811c68176a"
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
