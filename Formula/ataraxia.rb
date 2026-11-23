class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.17.0/ataraxia-v0.17.0-universal-apple-darwin.tar.gz"
    sha256 "3ab090506896e0aae84a79be3f322cf2b0e8e17e005ba73492ee2e91b2c9e23c"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.17.0/ataraxia-v0.17.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "db1e2d2498ae92b63aa3e084b4b9aa3f35bb4acb4ad03c5b3f30636b8933fe83"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.17.0/ataraxia-v0.17.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "bcfcd615ad4e67ec882755151c51c1d4c8e9902c40bbeb4c75235e0f6528c242"
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
