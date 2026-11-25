class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.20.1/ataraxia-v0.20.1-universal-apple-darwin.tar.gz"
    sha256 "06569000877f0bc74697e713fd32a0de99fc53c8a7cc713b0275764ade75017d"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.20.1/ataraxia-v0.20.1-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "11ab51bace63f5a34d1709d27d0bf8788dfb763594882300b535c4118451af48"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.20.1/ataraxia-v0.20.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "4ea56bfd75165c542f82865311b3630e8b8f5c2346b49b6bf0b788ccdb48c229"
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
