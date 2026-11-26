class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.23.1/ataraxia-v0.23.1-universal-apple-darwin.tar.gz"
    sha256 "ac052c9bf0f102896c6720bca84dbaca0c88965144593b84cfd8dcb1e23bc945"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.23.1/ataraxia-v0.23.1-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "02916214d5c1464ecbced00a541eeeeff7515ac95d29798a22dc0474a999abb1"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.23.1/ataraxia-v0.23.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "9852ec58d4958c6bfa3d267e613f882c5d1d92db35e16bf3a4efb641f7838178"
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
