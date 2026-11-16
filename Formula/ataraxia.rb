class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.6.0/ataraxia-v0.6.0-universal-apple-darwin.tar.gz"
    sha256 "375e789ce51dd9357f313b70ba50e6059a2bc510be444db42ca1f5769906feaf"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.6.0/ataraxia-v0.6.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "d345d3e8e2751a846e235f4b99c8d271e06d95f18bb18d6574a9174513ad979e"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.6.0/ataraxia-v0.6.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "1db43908162da080c386bc985cad52f9baf8c78d55da15c7cbf29b8d419704d8"
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
