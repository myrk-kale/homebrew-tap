class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.10.0/ataraxia-v0.10.0-universal-apple-darwin.tar.gz"
    sha256 "50a1286a3347da2bf9c4f47038c12722f68e6fa171d105a2ad7735b395d21c3c"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.10.0/ataraxia-v0.10.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "a13dc383424d39eeeb72bd0a49ecc38c383fcdfa1dc6914da9b898a008e4e8ba"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.10.0/ataraxia-v0.10.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "b276ed6fe5c34314db7c05a24ea5a754f94e38c7efaae3d7da5f7a4228e87773"
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
