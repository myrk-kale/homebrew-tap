class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.14.2/ataraxia-v0.14.2-universal-apple-darwin.tar.gz"
    sha256 "a0bf2291025274e03496685d60ef1f59c5eaf0b3b40253e222ebfcb5319f592e"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.14.2/ataraxia-v0.14.2-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "1dc33da66d0c4d77cb320bbdaf3fbcc2193ac4ea74f21e6fc688d1ba61e03d8e"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.14.2/ataraxia-v0.14.2-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "531deeae66f625e59f92c0abae72dd556b42528d87c953698f031b0dfccac2f8"
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
