class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.23.0/ataraxia-v0.23.0-universal-apple-darwin.tar.gz"
    sha256 "ef5647ded0e59e93aac89efd4b0505145cad82451107f8f2be36e3bd55748ee4"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.23.0/ataraxia-v0.23.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "d022be564dd773754c979ee9e803c4e89514dfddfc87a9539566e1426eb56768"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.23.0/ataraxia-v0.23.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "af6e7e65b89b4cc994f4b5767c97d636479c43263a94eb96cfd102b89c932447"
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
