class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.13.0/ataraxia-v0.13.0-universal-apple-darwin.tar.gz"
    sha256 "54b85cb2328255eac55086562866cbd6cb66d09421b2643e2764793047a21f91"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.13.0/ataraxia-v0.13.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "9c6616723b97c900f3ee170270155296c5f8414797ee54fecd15d4327def0bce"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.13.0/ataraxia-v0.13.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "5c3789c1589a63b04057157fcf8725401ee6a853404a5f7a9459715f7b8fe504"
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
