class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.1.1/ataraxia-v0.1.1-universal-apple-darwin.tar.gz"
    sha256 "86ea306bb9f413705809ba04b3b6ffbb2871f463877314dca640b3f019efea42"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.1.1/ataraxia-v0.1.1-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "c9b63e0156c60ac6f967049822c9e92925213c61318698a74f1854fd6764c825"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.1.1/ataraxia-v0.1.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "1939b0cba0fa9bb88b92982414d1bbd674c9a4910994ac3123181c92612c2372"
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
