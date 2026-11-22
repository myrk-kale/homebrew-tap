class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.16.0/ataraxia-v0.16.0-universal-apple-darwin.tar.gz"
    sha256 "c7ea73a7a762eb6f87d09997def2ded4eda15e701553926653f76f2816db27d9"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.16.0/ataraxia-v0.16.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "80da2317bfaad40d3c4b4feba33472e2adbf1c06deceacbae7869a1ccbd73f29"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.16.0/ataraxia-v0.16.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "ff058cb953e95295c31efd9fa25c3a74b852e0b5d63fb726468640a94e8ae70d"
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
