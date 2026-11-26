class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.24.0/ataraxia-v0.24.0-universal-apple-darwin.tar.gz"
    sha256 "8f14a504ccd84f848f08fee8de85709b87ba71cfd8c295f254eff9688113e026"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.24.0/ataraxia-v0.24.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "be9ad8fea9d072202dd39e8192d9ec5db375d2bd77660d70b0033fdd1339a519"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.24.0/ataraxia-v0.24.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "59495d17d1c0d709cd344581008678454489735019d7fa6953a48ee73d6adc85"
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
