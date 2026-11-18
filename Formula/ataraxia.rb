class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.12.0/ataraxia-v0.12.0-universal-apple-darwin.tar.gz"
    sha256 "af2197d9643079ade6f5b6bb3b52ef162e123793e9d19a52df813fced20507f0"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.12.0/ataraxia-v0.12.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "91b48b1e13322ea13498bee39f4e9145f3231c224c0a3fcc55de1c9990e545c3"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.12.0/ataraxia-v0.12.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "e3038472d7ea3e6f8de70759d8273b70fa0875082b4ab2f01909bc4b2146623a"
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
