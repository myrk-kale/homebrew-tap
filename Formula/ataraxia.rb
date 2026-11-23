class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.18.0/ataraxia-v0.18.0-universal-apple-darwin.tar.gz"
    sha256 "e34f8aa47403c3496b21b7b0632ab108bb1f64d7dc46b95a9c2bf751c9947dc5"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.18.0/ataraxia-v0.18.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "90046165b22c552ad6a7f8ef1901d3de57723cc6388d0e9025fde6f5e38aa477"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.18.0/ataraxia-v0.18.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "83d00f1d047b60c8bd2bf55b7d2abe15a80d1b47ead2716fcf91c3f08b149a6e"
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
