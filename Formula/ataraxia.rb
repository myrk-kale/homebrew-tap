class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.12.1/ataraxia-v0.12.1-universal-apple-darwin.tar.gz"
    sha256 "21d378976effe41f9c53461739db2e9793bb2a7a3f44641d270de37edaaa1011"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.12.1/ataraxia-v0.12.1-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "32cf163c01e82ee28e1efebc3e18b3414791a1720fe672ff68e624c54771b6cc"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.12.1/ataraxia-v0.12.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "fb037fff1e53c507df31d1479a76a4034e3b64c4631db7b66b7049f46d1a99f4"
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
