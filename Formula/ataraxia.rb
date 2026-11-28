class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.27.0/ataraxia-v0.27.0-universal-apple-darwin.tar.gz"
    sha256 "70c73afaf84b84c785c9dfe65c73b2b1c188088ba4701d066ef69145b305355b"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.27.0/ataraxia-v0.27.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "9cd261017d5e6666ecbcbc400c4a7901e77446e89cb83130e1f060636d95dbdb"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.27.0/ataraxia-v0.27.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "ba40d4a20dee7cc7ba219c63d0941eda8efade8c8af98810b47b2ba574b8fa17"
  end

  def install
    bin.install "ataraxia"
    doc.install "README.md", "CHANGELOG.md", "LICENSE"
  end

  def caveats
    s = <<~EOS
      `ataraxia` opens the app. While it runs, the agent of each chat reaches it through a local
      HTTP API, and is told how, so there is nothing to register.
    EOS
    if OS.linux?
      s += <<~EOS

        The window needs GTK 3 and WebKitGTK 4.1 from your distribution:
          Debian, Ubuntu: sudo apt install libwebkit2gtk-4.1-0 libgtk-3-0
          Fedora:         sudo dnf install webkit2gtk4.1 gtk3
      EOS
    end
    s
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ataraxia --version")
  end
end
