class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.4.0/ataraxia-v0.4.0-universal-apple-darwin.tar.gz"
    sha256 "a4dcf231ae56ca16bc7cce95fa245fab6386e4cfe5b53eb6ed51461570f89ca4"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.4.0/ataraxia-v0.4.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "dcfd090ee96101a65becbcb6573e882bdc37ce18d386b14418a172f6e9a55199"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.4.0/ataraxia-v0.4.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "9c63530d6255cd8f022cbfb0d195840d3caf36d4fbef15bb6c71f7c0e28cab97"
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
