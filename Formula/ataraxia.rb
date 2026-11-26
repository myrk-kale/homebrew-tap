class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.22.0/ataraxia-v0.22.0-universal-apple-darwin.tar.gz"
    sha256 "ea6eb5381e5e30fdb551921eb7922e2b48b94db7ada4d6ef040b391c16509d5c"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.22.0/ataraxia-v0.22.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "70b2958353827381129cdb82aabc5f285ee967f72bc1a97c9bfbab0f4dbfda34"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.22.0/ataraxia-v0.22.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "c0cd8a184dcfc1f3c92a1e4914ff1d5ed30e7315f0a3ec31ca717fc07942bcf3"
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
