class Jaqi < Formula
  desc "Fast, jq-compatible JSON processor (fork of jaq)"
  homepage "https://github.com/vlasky/jaqi"
  version "3.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/vlasky/jaqi/releases/download/v3.2.0/jaqi-3.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "04ce7485c061ad01e81b4ba2ba3012ec375c3ecb5872fa3b3663583c235c36f2"
    end
    on_intel do
      url "https://github.com/vlasky/jaqi/releases/download/v3.2.0/jaqi-3.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "bf3b305b0d774f5385325e93a269894d52a94e3c76b36a44b53e3e7b6faa1b97"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vlasky/jaqi/releases/download/v3.2.0/jaqi-3.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b975942b260c9d27fdb53207ac8138a2cc4c3fa6a3698c02482d846426f234bf"
    end
    on_intel do
      url "https://github.com/vlasky/jaqi/releases/download/v3.2.0/jaqi-3.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7e26b05fc425e15bb8d1d4102d96552f3b8afc20ef92f936ab2b6d03c19c7c01"
    end
  end

  head do
    url "https://github.com/vlasky/jaqi.git", branch: "main"
    depends_on "rust" => :build
  end

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args(path: "jaqi")
    else
      bin.install "jaqi"
    end
  end

  test do
    assert_equal "3", pipe_output("#{bin}/jaqi -n \"1+2\"").strip
    assert_match version.to_s, shell_output("#{bin}/jaqi --version")
  end
end
