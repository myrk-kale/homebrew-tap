class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.5.1/ataraxia-v0.5.1-universal-apple-darwin.tar.gz"
    sha256 "f9cbd705bfbfc3014ce8064f195677ddb85dfe6456083714cf0bd418d2dbc7ed"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.5.1/ataraxia-v0.5.1-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "c8e17606c9e54f1a13ac5518327dbacd0272daab3c2851155cf818d3a0c97df3"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.5.1/ataraxia-v0.5.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "cb0690b89a35b093e1375d39f566985ff67ba33faf816e4c7d00c8a072d1dd13"
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
