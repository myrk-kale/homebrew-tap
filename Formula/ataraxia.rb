class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.20.2/ataraxia-v0.20.2-universal-apple-darwin.tar.gz"
    sha256 "10322c5b7fabdd1cbf369a5ae8d43084c1864d1df5242779f242da9b4eeaba6b"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.20.2/ataraxia-v0.20.2-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "1dfc997e9ba3902832881c8717a461444550c552b46efd8316ff3404200d4962"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.20.2/ataraxia-v0.20.2-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "e61bf6e64229c09edefd8166e3f00f75b967bb5c3e2ac2464f474f3b169bf273"
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
