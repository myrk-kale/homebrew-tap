class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.15.0/ataraxia-v0.15.0-universal-apple-darwin.tar.gz"
    sha256 "44a943fa28405be9565668ecf4f7d426cb59619597823e1ff0d3e4bd93caaf12"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.15.0/ataraxia-v0.15.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "9b541f586f3428c6384729448f78d2dd44b3ae819d3d5ee31540314023ac71ba"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.15.0/ataraxia-v0.15.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "9cc059ccc04d51526c4e120ddbe5e0b7f4501d50f9ecc13eb228b80c409b723c"
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
