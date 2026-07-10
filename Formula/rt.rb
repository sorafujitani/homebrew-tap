require "json"

class Rt < Formula
  desc "Run Ruby-defined tasks from a discoverable CLI"
  homepage "https://github.com/sorafujitani/rt"
  url "https://github.com/sorafujitani/rt/archive/refs/tags/v0.0.5.tar.gz"
  sha256 "9b47500b2cea4091e775a1629c89925f6c8111130b19980f23c75e848a049b77"
  license "MIT"
  head "https://github.com/sorafujitani/rt.git", branch: "main"

  depends_on "rust" => :build

  uses_from_macos "ruby"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    (testpath/".rt/tasks/greet.rb").write <<~RUBY
      desc "Greet someone by name"
      option :name, type: :string, default: "world", description: "who to greet"
      task "greet" do |ctx|
        ctx.say "Hello, \#{ctx.option(:name)}!"
      end
    RUBY

    assert_match "Hello, brew!", shell_output("#{bin}/rt run greet --name brew")
    assert_match "greet", shell_output("#{bin}/rt list")

    catalog = JSON.parse(shell_output("#{bin}/rt tools --json greet"))
    assert_equal "greet", catalog.fetch("tools").first.fetch("task")

    result = JSON.parse(shell_output("#{bin}/rt run --json greet --name brew"))
    assert_equal "success", result.fetch("status")
  end
end
