class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.25.0/ataraxia-v0.25.0-universal-apple-darwin.tar.gz"
    sha256 "623ca5e8d5820c20b12bbe373935bc978857b4421c07758001230ec3060fbe42"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.25.0/ataraxia-v0.25.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "3eabdd802aea5c96c3eebcf8d337a1325c6b0727fb920caba81ce378926bb88b"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.25.0/ataraxia-v0.25.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "5a37cd5813d9f363383f7787cbe7c9eccdd885aca106d1f71ffc2cae6408aeff"
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
