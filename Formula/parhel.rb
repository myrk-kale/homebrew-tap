class Parhel < Formula
  desc "Copy-on-write Git worktrees with ignored build output included"
  homepage "https://github.com/myrk-kale/parhel"
  license "MIT"

  # Release archives: a universal binary on macOS, static musl binaries on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/parhel/releases/download/v0.4.0/parhel-v0.4.0-universal-apple-darwin.tar.gz"
    sha256 "cdc0affe48b03593b6798000a98944d27a6d906b5a1f53c95661f1c705e9559c"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/parhel/releases/download/v0.4.0/parhel-v0.4.0-aarch64-unknown-linux-musl.tar.gz"
    sha256 "09d1daf3a55983af206c443edf148ecb86fecd4f23ef2dcc9de04aa5ba6307fe"
  else
    url "https://github.com/myrk-kale/parhel/releases/download/v0.4.0/parhel-v0.4.0-x86_64-unknown-linux-musl.tar.gz"
    sha256 "6e6966c79264d756656e24ad10fcbfd5ee1d2c53d3042cbd8ec55620faf357cd"
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
