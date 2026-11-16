class Ataraxia < Formula
  desc "Desktop environment for agent-assisted software development"
  homepage "https://github.com/myrk-kale/ataraxia"
  license "MIT"

  # Release archives: a universal binary on macOS, one binary per architecture on Linux.
  if OS.mac?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.8.0/ataraxia-v0.8.0-universal-apple-darwin.tar.gz"
    sha256 "e220d3aee976befc422d82473c2ece18ff474791c2003f93e59e5aa258436e0b"
  elsif Hardware::CPU.arm?
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.8.0/ataraxia-v0.8.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "88e86456477cb093f42e8a01a6878f619c35213f8cb894e5136f701815e3e114"
  else
    url "https://github.com/myrk-kale/ataraxia/releases/download/v0.8.0/ataraxia-v0.8.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "4ae9dada573faebad2155b0e9c191d81524c6e46c43e554be5cba1229dd145cc"
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
