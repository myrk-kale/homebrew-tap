class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.14.0/ataraxia-v0.14.0-universal-apple-darwin.tar.gz"
    sha256 "9325a9a0caf23ef7ac8dc5e5af4d0d35515026ba88148d7194772520c09087c3"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.14.0/ataraxia-v0.14.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "3d68f3c8583e623235cd8ef64dbb892300b52f2e4e1acc124e4a1c5df245be20"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.14.0/ataraxia-v0.14.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "8c4b8fe761dba46a11a3b28a9a366c964d562c9931b372d97fad974c6bef4f3e"
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
