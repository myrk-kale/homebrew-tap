class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.2.0/ataraxia-v0.2.0-universal-apple-darwin.tar.gz"
    sha256 "58bf58c5d02ef2c14d6f22ba4d358cafae73b7911cc69f9709ac27f611c08c70"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.2.0/ataraxia-v0.2.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "020107d0288430c5e9e98a389ec8e01960379a5f1a182a4acc84384c45aef1b9"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.2.0/ataraxia-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "5e3a7f0b52a1380a2395875710a4d3900e45bca27a06ca57e1e95269067b9a4b"
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
