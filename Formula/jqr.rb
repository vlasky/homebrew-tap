class Jqr < Formula
  desc "Jq with JSON repair - filter truncated or mangled JSON"
  homepage "https://github.com/vlasky/jqr"
  url "https://github.com/vlasky/jqr/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "219f634332fc2934e5e680d5604de45cb7bcaf6cdf6e74ec045908fc6143012e"
  license "MIT"
  head "https://github.com/vlasky/jqr.git", branch: "main"

  depends_on "rust" => :build
  depends_on "jq"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_equal "3", pipe_output("#{bin}/jqr --quiet '.items | length'", '{"items":[1,2,3').strip
  end
end
