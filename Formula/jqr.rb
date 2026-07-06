class Jqr < Formula
  desc "Jq with JSON repair - filter truncated or mangled JSON"
  homepage "https://github.com/vlasky/jqr"
  version "1.1.0"
  license "MIT"

  depends_on "jq"

  on_macos do
    on_arm do
      url "https://github.com/vlasky/jqr/releases/download/v1.1.0/jqr-1.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "170f26df5536fc2042d3fe1e30e7a2b1509a1dc3e54e2d615d82489b900cd455"
    end
    on_intel do
      url "https://github.com/vlasky/jqr/releases/download/v1.1.0/jqr-1.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "9c74d5d6b459e610984de9fc770c2f4dd0ef1666e0a22c9897c192918038be97"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vlasky/jqr/releases/download/v1.1.0/jqr-1.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e9b478a56b49df5e5dacc0e91c63bd3861bbe1a496e8225204cb17964e7cb57f"
    end
    on_intel do
      url "https://github.com/vlasky/jqr/releases/download/v1.1.0/jqr-1.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8f4036cbc0858166fa608e44a8431e97999917c4386035f431782d324c774dfc"
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
