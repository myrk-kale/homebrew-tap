class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.21.0/ataraxia-v0.21.0-universal-apple-darwin.tar.gz"
    sha256 "f51ba70e5044418af130f422935a4b01b1cfb28ac44b1ef87cedca184dbc6daf"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.21.0/ataraxia-v0.21.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "a5faa6f0d86e978ba36f1c8d2eec3732cc8e19b5891e4a6045bbc4e38a603398"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.21.0/ataraxia-v0.21.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "290d90534c2b63711d8789c84e131075a0edfe8e1615ab979451aa481a2b8ecc"
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
