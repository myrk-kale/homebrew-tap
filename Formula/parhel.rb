class Parhel < Formula
  desc "Copy-on-write Git worktrees with ignored build output included"
  homepage "https://github.com/myrk-kale/parhel"
  license "MIT"

  # Release archives: a universal binary on macOS, static musl binaries on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/parhel/releases/download/v0.4.1/parhel-v0.4.1-universal-apple-darwin.tar.gz"
    sha256 "21003047fa5040c7021724d9e61511e8187f6776064fd3705ffee341e8b4cecb"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/parhel/releases/download/v0.4.1/parhel-v0.4.1-aarch64-unknown-linux-musl.tar.gz"
    sha256 "7b7fe15648a45e25bf282bc26d82c9591e97e3c7dc784863a38e9d9ece96c2cc"
  else
    url "https://github.com/myrk-kale/parhel/releases/download/v0.4.1/parhel-v0.4.1-x86_64-unknown-linux-musl.tar.gz"
    sha256 "75450fd0b9e253f210a727e20f190a4429ccfc1c369876cc8689b7631eee3561"
  end

  head do
    url "https://github.com/myrk-kale/parhel.git", branch: "main"
    depends_on "rust" => :build
  end

  uses_from_macos "git"

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args
    else
      bin.install "git-parhel"
    end
    man1.install Dir["man/*.1"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/git-parhel --version") unless build.head?

    system "git", "init", "-q", "-b", "main", "src"
    (testpath/"src/.gitignore").write "target/\n"
    (testpath/"src/target").mkpath
    (testpath/"src/target/artifact").write "built"
    system "git", "-C", "src", "add", ".gitignore"
    system "git", "-C", "src", "-c", "user.name=brew", "-c", "user.email=brew@example.com",
           "commit", "-q", "-m", "init"
    # APFS clones; the test directory on Linux is usually ext4, which cannot reflink.
    flags = OS.mac? ? [] : ["--copy"]
    cd "src" do
      system bin/"git-parhel", "add", "../wt", "--new-branch", "brew-test", *flags
    end
    assert_equal "built", (testpath/"wt/target/artifact").read
    assert_empty shell_output("git -C #{testpath}/wt status --porcelain")
  end
end
