class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.3.0/ataraxia-v0.3.0-universal-apple-darwin.tar.gz"
    sha256 "51c15589db2963fbbe73b861bb7eaa32411aa8cbce655f53b82725c855946ba3"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.3.0/ataraxia-v0.3.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "2b4ec38d5dc68cef026a8fefa5bf6ef4245a6d4d4e6534b35d8c648e699040e5"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.3.0/ataraxia-v0.3.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "18676ecf501023992d5d7f239368e9816102771f36762ca3f94b69e3872f7214"
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
