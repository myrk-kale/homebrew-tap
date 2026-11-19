class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.14.1/ataraxia-v0.14.1-universal-apple-darwin.tar.gz"
    sha256 "06612d37ead2c809cfb8538a3c3df04334b6133800bbaaa52f972305aebc798a"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.14.1/ataraxia-v0.14.1-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "9fd740914aa6f1497220fd99cf9ad60664e1964a7f70126053e955d7f61dd9a3"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.14.1/ataraxia-v0.14.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "c7449dcca2206a0687888217e5ebe7ff0909a994c2b4c4b807faa7cce6071f14"
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
