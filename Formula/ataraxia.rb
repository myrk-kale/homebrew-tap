class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.11.0/ataraxia-v0.11.0-universal-apple-darwin.tar.gz"
    sha256 "ec6b50abd1dca7e3108bb076e7abacd74fefa061e447a15360a6dbe148c61daf"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.11.0/ataraxia-v0.11.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "0194961a65f41d25fa13877c39d93a117d0da75ca0fcb709da787919a524ac6e"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.11.0/ataraxia-v0.11.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "a9704d03db4bf048f4df0d8dd353f28d64384b5d17e621b4aee55324c45695e2"
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
