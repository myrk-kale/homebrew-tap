class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.19.0/ataraxia-v0.19.0-universal-apple-darwin.tar.gz"
    sha256 "5f096b353fb3ac84b6d9d62ac976d47c2cbceba1794fd1261fc4a468dd4983f9"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.19.0/ataraxia-v0.19.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "cc0efc394d4632b297b9bf0e6ee6b4eebfa4fbf619b49af8b6507c9af887c455"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.19.0/ataraxia-v0.19.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "2ad9865984754e9cf84e4351b09d33e2fdd1eb8f001f03af1c9c649357358dff"
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
