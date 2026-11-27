class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.26.0/ataraxia-v0.26.0-universal-apple-darwin.tar.gz"
    sha256 "a35093e5f3b47d5ac9bf266910fd3754e70b23baaa44f4756dac45f4f30c4de5"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.26.0/ataraxia-v0.26.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "8101290fb647fd450eee8d5d743704dcb58cd1e83ea51847ab624ec78f40e339"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.26.0/ataraxia-v0.26.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "80fa4f1276dc7da58c944391dfc1c8e1ad5a940fdeffd543bcd9c4a5290d7822"
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
