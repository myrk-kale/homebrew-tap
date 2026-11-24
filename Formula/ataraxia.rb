class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.20.0/ataraxia-v0.20.0-universal-apple-darwin.tar.gz"
    sha256 "3adf98b1111dcce214f65e55f845af850c2c465b7b711167f459c45bd9949fe9"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.20.0/ataraxia-v0.20.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "9d51e87dff719cf4a7efc4222479d64107786e0a6613e181622c9d7967612ebe"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.20.0/ataraxia-v0.20.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "3f49abaf234937887d612e1680b5fbb59a7cc871365fd856b324561cad86efdc"
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
