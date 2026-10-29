class Jqr < Formula
  desc "Jq with JSON repair - filter truncated or mangled JSON"
  homepage "https://github.com/vlasky/jqr"
  version "1.1.1"
  license "MIT"

  depends_on "jq"

  on_macos do
    on_arm do
      url "https://github.com/vlasky/jqr/releases/download/v1.1.1/jqr-1.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "a2ac25ed6f6c5db13d6de12e721843ecba3d03566218739c6e1bb9acc7cb605b"
    end
    on_intel do
      url "https://github.com/vlasky/jqr/releases/download/v1.1.1/jqr-1.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "0ddecf8d3e94f095b7febc2988613debbe8ee465e271dbe8b084dd1e2dce0916"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vlasky/jqr/releases/download/v1.1.1/jqr-1.1.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "49c03beaddb509b1f3da795b6dba5431c587098ca078fd3d1478554dd20c6d7e"
    end
    on_intel do
      url "https://github.com/vlasky/jqr/releases/download/v1.1.1/jqr-1.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b2fae4699ab9332165f64bb8d11a096dc69fee8caaee7ea9c426cd54c317072f"
    end
  end

  head do
    url "https://github.com/vlasky/jqr.git", branch: "main"
    depends_on "rust" => :build
  end

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args
    else
      bin.install "jqr"
    end
  end

  test do
    assert_equal "3", pipe_output("#{bin}/jqr --quiet '.items | length'", '{"items":[1,2,3').strip
    assert_match version.to_s, shell_output("#{bin}/jqr --version")
  end
end
