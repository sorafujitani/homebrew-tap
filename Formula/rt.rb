class Rt < Formula
  desc "Run Ruby-defined tasks from a discoverable CLI"
  homepage "https://github.com/sorafujitani/rt"
  url "https://github.com/sorafujitani/rt/archive/refs/tags/v0.0.3.tar.gz"
  sha256 "a9dcc37fb66425cc7e497b4e3d2d73e398636257d1466b860638b4f7e7812655"
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
  end
end
