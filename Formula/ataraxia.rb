class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.5.0/ataraxia-v0.5.0-universal-apple-darwin.tar.gz"
    sha256 "759d591b3b013562d3c59e0dece1a9911cb19e9df044ab2be952847b853fbeaa"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.5.0/ataraxia-v0.5.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "12bd9422fb3ccec46388b4950dc9926329df1c8233a4127e72222330e89e2877"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.5.0/ataraxia-v0.5.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "aa8e71b032097fca257dd4ba1400d34bbcd76926c25af69acef3b945e4c90c5a"
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
