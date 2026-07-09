class Rt < Formula
  desc "Run Ruby-defined tasks from a discoverable CLI"
  homepage "https://github.com/sorafujitani/rt"
  url "https://github.com/sorafujitani/rt/archive/refs/tags/v0.0.2.tar.gz"
  sha256 "87a5b42827e9632fa626f86c2c184d65e63a358e527c200e0831df8f043cc3e3"
  license "MIT"
  head "https://github.com/sorafujitani/rt.git", branch: "main"

  depends_on "rust" => :build

  uses_from_macos "ruby"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    (testpath/"tasks/greet.rb").write <<~RUBY
      desc "Greet someone by name"
      option :name, type: :string, default: "world", description: "who to greet"
      task "greet" do |ctx|
        ctx.say "Hello, \#{ctx.option(:name)}!"
      end
    RUBY

    assert_match "Hello, brew!", shell_output("#{bin}/rt run greet --name brew")
    assert_match "greet", shell_output("#{bin}/rt list")
  end
end
