class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.7.0/ataraxia-v0.7.0-universal-apple-darwin.tar.gz"
    sha256 "d7148e8371859a3970c74e0b315f049dd4f1ff7667b8d7effadc6bfc4aadba94"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.7.0/ataraxia-v0.7.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "4b3816456455bbdb21f024823f4f741ee652e7d03afe225078b60790ad845255"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.7.0/ataraxia-v0.7.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "98bb81564bb4fceba01872124001b9deff46c9a63d7bbd553dc38a864ec5352c"
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
