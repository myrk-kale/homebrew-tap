class Parhel < Formula
  desc "Copy-on-write Git worktrees with ignored build output included"
  homepage "https://github.com/myrk-kale/parhel"
  url "https://github.com/myrk-kale/parhel/releases/download/v0.1.1/parhel-v0.1.1-universal-apple-darwin.tar.gz"
  sha256 "498f4b8916d790a9b00c583b7f5d828ccc222deb0866f24bad1a3d4aa44e6d56"
  license "MIT"

  head do
    url "https://github.com/myrk-kale/parhel.git", branch: "main"
    depends_on "rust" => :build
  end

  depends_on :macos

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
    cd "src" do
      system bin/"git-parhel", "add", "../wt", "--new-branch", "brew-test"
    end
    assert_equal "built", (testpath/"wt/target/artifact").read
    assert_empty shell_output("git -C #{testpath}/wt status --porcelain")
  end
end
