class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.9.0/ataraxia-v0.9.0-universal-apple-darwin.tar.gz"
    sha256 "00634955666f4a1387692e08d92e8b6f209063d5c4a487e8430c702c43d627f7"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.9.0/ataraxia-v0.9.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "07a8bc968cd108c0d285bf562db81c329d1fe8b369d7bf227846b1b4b25d9388"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.9.0/ataraxia-v0.9.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "e3597e07040388bb7cdf28804eedcb3d3214ffacc6ecddf10d52e0a55e936cd1"
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
